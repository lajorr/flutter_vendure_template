import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/auth/application/providers/auth_providers.dart';
import 'package:vendure_flutter_app/features/auth/domain/entities/customer.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_controllers.g.dart';

/// Global controller to manage the Authentication state.
/// We use the Active Customer as the source of truth for whether a user is logged in.
/// If Customer is not null, they are logged in.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<Customer?> build() async {
    return _fetchActiveCustomer();
  }

  Future<Customer?> _fetchActiveCustomer() async {
    final usecase = ref.read(getActiveCustomerUsecaseProvider);
    final result = await usecase.execute(NoParams());

    return result.fold((failure) => throw failure, (customer) => customer);
  }

  /// Call this method after a successful login or logout to refresh the global state.
  Future<void> refreshActiveCustomer() async {
    ref.invalidateSelf();
    await future; // optionally await the rebuild
  }
}

@riverpod
bool isAuthenticated(Ref ref) {
  return ref
      .watch(authControllerProvider)
      .maybeWhen(data: (customer) => customer != null, orElse: () => false);
}

/// Controller specifically for handling the Login process state (loading, error, success)
/// By keeping it separate from the global state, the UI can listen to the loading
/// state of just the login button without rebuilding the whole app.
@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {
    // Initial state is just empty
  }

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(loginUseCaseProvider);
      final result = await usecase.execute(
        LoginParams(username: email, password: password),
      );

      return result.fold((failure) => throw failure, (_) async {
        // After successful login, refresh the active customer state!
        await ref.read(authControllerProvider.notifier).refreshActiveCustomer();
      });
    });
  }
}

/// Controller specifically for handling the Sign Up process state
@riverpod
class SignUpController extends _$SignUpController {
  @override
  FutureOr<void> build() {
    // Initial state is empty
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    if (state.isLoading) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(registerUseCaseProvider);
      final result = await usecase.execute(
        RegisterParams(
          firstName: firstName,
          lastName: lastName,
          emailAddress: email,
          password: password,
          phoneNumber: phoneNumber,
        ),
      );

      return result.fold((failure) => throw failure, (_) => null);
    });
  }
}

/// Controller for Forgot Password flow
@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  FutureOr<void> build() {
    // Initial state is empty
  }

  Future<void> requestPasswordReset(String email) async {
    if (state.isLoading) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Call request password reset usecase here
    });
  }
}
