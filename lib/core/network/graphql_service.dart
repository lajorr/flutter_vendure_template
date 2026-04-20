import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vendure_flutter_app/core/network/session_provider.dart';

import '../errors/exceptions.dart' as app_exceptions;

abstract class GraphQLService {
  Future<dynamic> performQuery(
    String query, {
    Map<String, dynamic>? variables,
    required String operationName,
  });
  Future<dynamic> performMutation(
    String mutation, {
    Map<String, dynamic>? variables,
    required String operationName,
  });
}

class GraphQLServiceImpl implements GraphQLService {
  final GraphQLClient _client;
  final Ref _ref;
  static const String _sessionHeader = 'vendure-auth-token';

  GraphQLServiceImpl(this._client, this._ref);

  @override
  Future<dynamic> performQuery(
    String query, {
    Map<String, dynamic>? variables,
    required String operationName,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? const {},
      operationName: operationName,
    );

    try {
      // Adding a standard 15 second timeout to network queries
      final QueryResult result = await _client
          .query(options)
          .timeout(const Duration(seconds: 15));

      if (result.hasException) {
        _handleException(result.exception!);
      }

      await _updateSessionToken(result);

      return result.data;
    } on TimeoutException {
      throw app_exceptions.AppTimeoutException(
        'The connection has timed out, please try again.',
      );
    } catch (e) {
      if (e is app_exceptions.ServerException ||
          e is app_exceptions.NetworkException) {
        rethrow;
      }
      throw app_exceptions.ServerException(e.toString());
    }
  }

  @override
  Future<dynamic> performMutation(
    String mutation, {
    Map<String, dynamic>? variables,
    required String operationName,
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? const {},
      operationName: operationName,
    );

    try {
      // Adding a standard 15 second timeout to network mutations
      final QueryResult result = await _client
          .mutate(options)
          .timeout(const Duration(seconds: 15));

      if (result.hasException) {
        _handleException(result.exception!);
      }

      await _updateSessionToken(result);

      return result.data;
    } on TimeoutException {
      throw app_exceptions.AppTimeoutException(
        'The connection has timed out, please try again.',
      );
    } catch (e) {
      if (e is app_exceptions.ServerException ||
          e is app_exceptions.NetworkException) {
        rethrow;
      }
      throw app_exceptions.ServerException(e.toString());
    }
  }

  Future<void> _updateSessionToken(QueryResult result) async {
    final httpResponseContext = result.context.entry<HttpLinkResponseContext>();
    final headers = httpResponseContext?.headers;

    if (headers != null) {
      // Case-insensitive lookup for the vendure-auth-token
      final tokenEntry = headers.entries.firstWhere(
        (e) => e.key.toLowerCase() == _sessionHeader.toLowerCase(),
        orElse: () => const MapEntry('', ''),
      );

      final newToken = tokenEntry.value;

      if (newToken.isNotEmpty) {
        // Log if the token actually changed (debug level)
        final sessionState = _ref.read(sessionTokenProvider);
        final currentToken = sessionState.value;

        if (currentToken != newToken.trim()) {
          debugPrint('🔑 Session token changed/received: ${newToken.trim()}');
          await _ref.read(sessionTokenProvider.notifier).updateToken(newToken);
        }
      }
    }
  }

  void _handleException(OperationException exception) {
    if (exception.graphqlErrors.isNotEmpty) {
      // Assuming you want the first error message or you can combine them
      throw app_exceptions.ServerException(
        exception.graphqlErrors.first.message,
      );
    }

    // GraphQL Flutter wraps lower-level exceptions within LinkException
    final linkException = exception.linkException;
    if (linkException != null) {
      if (linkException is NetworkException) {
        throw app_exceptions.NetworkException(
          'Failed to connect to the server. Please check your internet connection.',
        );
      } else if (linkException is ServerException) {
        // Checking if the original exception was a timeout (if not caught by Future.timeout)
        final originalException = linkException.originalException;
        if (originalException is TimeoutException) {
          throw app_exceptions.AppTimeoutException(
            'The connection has timed out, please try again.',
          );
        }

        throw app_exceptions.ServerException(linkException.toString());
      }
      throw app_exceptions.ServerException(linkException.toString());
    }
    throw app_exceptions.ServerException('Unexpected GraphQL Error');
  }
}
