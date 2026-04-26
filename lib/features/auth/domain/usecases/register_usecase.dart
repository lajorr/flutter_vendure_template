import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase extends Usecase<void, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> execute(RegisterParams params) async {
    return await _authRepository.register(
      title: params.title,
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
      emailAddress: params.emailAddress,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String? title;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String emailAddress;
  final String password;

  const RegisterParams({
    this.title,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.emailAddress,
    required this.password,
  });
}
