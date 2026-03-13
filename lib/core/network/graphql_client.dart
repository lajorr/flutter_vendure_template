import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';

import 'graphql_service.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 100,
    colors: true,
    printEmojis: true,
  ),
);

class LoggerLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final operationName =
        request.operation.operationName ?? 'Unnamed Operation';

    // Log Request
    _logger.i(
      '🚀 GraphQL Request: $operationName\nVariables: ${request.variables}',
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
final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  // Replace with your actual Vendure Shop API URL
  final HttpLink httpLink = HttpLink(
    'http://192.168.1.134:3000/shop-api', // Demo Vendure backend
  );

  // Example auth link if authentication is required (e.g., passing Bearer token)
  final AuthLink authLink = AuthLink(
    getToken: () async {
      // Fetch token from storage (e.g., SharedPreferences or secure storage)
      // return 'Bearer $token';
      return null; // Return null if not authenticated
    },
  );

  // Link that chains AuthLink and HttpLink
  final Link link = authLink.concat(httpLink);

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

  // Combine links (logger should be the first so it logs the request out and response in)
  final loggerLink = LoggerLink();
  final finalLink = Link.from([loggerLink, errorLink, link]);

  return GraphQLClient(
    link: finalLink,
    cache: GraphQLCache(store: InMemoryStore()), // Add persistency if required
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.networkOnly, // Or cacheAndNetwork based on needs
      ),
    ),
  );
});

/// Extends standard GraphQLClient with a reusable service
final graphqlServiceProvider = Provider<GraphQLService>((ref) {
  return GraphQLServiceImpl(ref.watch(graphqlClientProvider));
});
