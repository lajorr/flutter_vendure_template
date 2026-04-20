import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'storage_service.dart';

part 'session_provider.g.dart';

@Riverpod(keepAlive: true)
class SessionToken extends _$SessionToken {
  @override
  FutureOr<String?> build() async {
    final storage = ref.read(secureStorageServiceProvider);
    final token = await storage.getSessionToken();
    return token?.trim();
  }

  Future<void> updateToken(String? token) async {
    final trimmedToken = token?.trim();
    if (trimmedToken == null || trimmedToken.isEmpty) {
      if (state.value != null) {
        final storage = ref.read(secureStorageServiceProvider);
        await storage.deleteSessionToken();
        state = const AsyncData(null);
      }
      return;
    }

    // Only update if the token has actually changed to avoid unnecessary rebuilds
    if (state.value != trimmedToken) {
      final storage = ref.read(secureStorageServiceProvider);
      await storage.saveSessionToken(trimmedToken);
      state = AsyncData(trimmedToken);
    }
  }
}
