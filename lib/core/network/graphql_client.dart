import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'graphql_service.dart';
import 'session_provider.dart';

part 'graphql_client.g.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
    colors: true,
    printEmojis: true,
  ),
);

/// Custom link that injects the vendure-auth-token header with the RAW token
/// value. We CANNOT use AuthLink here because AuthLink automatically prepends
/// "Bearer " to the value, but Vendure expects the plain token string.
class VendureAuthLink extends Link {
  final Ref ref;
  static const _headerKey = 'vendure-auth-token';

  VendureAuthLink(this.ref);

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    // 1. Correctly await the session token from the AsyncNotifier.
    // This handles both the initial load from storage and any subsequent updates.
    final token = await ref.read(sessionTokenProvider.future);

    _logger.i('🔑 VendureAuthLink — sending token: $token');

    final updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (entry) => HttpLinkHeaders(
        headers: {
          ...?entry?.headers,
          if (token != null && token.isNotEmpty) ...{
            _headerKey: token,
            'Authorization': 'Bearer $token',
          },
        },
      ),
    );

    yield* forward!(updatedRequest);
  }
}

class LoggerLink extends Link {
  final Ref ref;
  LoggerLink(this.ref);
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final operationName =
        request.operation.operationName ?? 'Unnamed Operation';

    // Extract the actual header value being sent
    final httpHeaders = request.context.entry<HttpLinkHeaders>();
    _logger.i(
      '🚀 GraphQL Request: $operationName\nVariables: ${request.variables}\nHeaders: ${httpHeaders?.headers}',
    );
    if (kDebugMode) {
      _logger.t('Query:\n\n${request.operation.document.toString()}');
    }

    Stream<Response> responseStream;
    try {
      responseStream = forward!(request);
    } catch (e) {
      _logger.e('❌ GraphQL Request Exception: $operationName\nError: $e');
      rethrow;
    }

    return responseStream.map((response) {
      if (response.errors != null && response.errors!.isNotEmpty) {
        _logger.e(
          '❌ GraphQL Operation Errors: $operationName\nErrors: ${response.errors}',
        );
      } else {
        _logger.d('✅ GraphQL Response: $operationName\nData: ${response.data}');
      }
      return response;
    });
  }
}

/// Provider for the GraphQLClient inside Riverpod.
/// keepAlive: true — the client must NEVER be auto-disposed, otherwise a new
/// instance is created which has no session context and Vendure issues a new
/// anonymous session token, orphaning the existing active order.
@Riverpod(keepAlive: true)
GraphQLClient graphqlClient(Ref ref) {
  // Replace with your actual Vendure Shop API URL
  final HttpLink httpLink = HttpLink(
    'https://demo.vendure.io/shop-api', // Demo Vendure backend
  );

  // Error handling link
  final ErrorLink errorLink = ErrorLink(
    onException: (Request request, NextLink forward, LinkException exception) {
      if (kDebugMode) {
        debugPrint('[GraphQL Error]: $exception');
      }
      return null;
    },
    onGraphQLError: (Request request, NextLink forward, Response response) {
      if (response.errors != null && kDebugMode) {
        for (var error in response.errors!) {
          debugPrint('[GraphQL Server Error]: ${error.message}');
        }
      }
      return null;
    },
  );

  // Link chain:
  // 1. ErrorLink       — catches errors from downstream links
  // 2. VendureAuthLink — injects raw vendure-auth-token (no "Bearer " prefix!)
  // 3. LoggerLink      — logs final outgoing headers
  // 4. HttpLink        — sends the HTTP request
  final vendureAuthLink = VendureAuthLink(ref);
  final loggerLink = LoggerLink(ref);
  final finalLink = Link.from([
    errorLink,
    vendureAuthLink,
    loggerLink,
    httpLink,
  ]);

  return GraphQLClient(
    link: finalLink,
    cache: GraphQLCache(store: InMemoryStore()),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.networkOnly),
    ),
  );
}

/// Extends standard GraphQLClient with a reusable service.
/// keepAlive: true — must stay alive alongside graphqlClientProvider.
@Riverpod(keepAlive: true)
GraphQLService graphqlService(Ref ref) {
  return GraphQLServiceImpl(ref.watch(graphqlClientProvider), ref);
}
