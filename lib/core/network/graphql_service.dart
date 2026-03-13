import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../errors/exceptions.dart' as app_exceptions;

abstract class GraphQLService {
  Future<dynamic> performQuery(String query, {Map<String, dynamic>? variables});
  Future<dynamic> performMutation(
    String mutation, {
    Map<String, dynamic>? variables,
  });
}

class GraphQLServiceImpl implements GraphQLService {
  final GraphQLClient _client;

  GraphQLServiceImpl(this._client);

  @override
  Future<dynamic> performQuery(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? const {},
    );

    try {
      // Adding a standard 15 second timeout to network queries
      final QueryResult result = await _client
          .query(options)
          .timeout(const Duration(seconds: 15));

      if (result.hasException) {
        _handleException(result.exception!);
      }

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
  }) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? const {},
    );

    try {
      // Adding a standard 15 second timeout to network mutations
      final QueryResult result = await _client
          .mutate(options)
          .timeout(const Duration(seconds: 15));

      if (result.hasException) {
        _handleException(result.exception!);
      }

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
