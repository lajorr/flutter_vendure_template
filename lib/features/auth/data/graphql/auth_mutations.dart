class AuthMutations {
  static const registerCustomerAccountMutation = r'''
    mutation RegisterCustomerAccount($input:RegisterCustomerInput! ) {
      registerCustomerAccount(input: $input) {
        ... on Success {
            success
        }
        ... on MissingPasswordError {
            errorCode
            message
        }
        ... on NativeAuthStrategyError {
            errorCode
            message
        }
        ... on PasswordValidationError {
            errorCode
            message
            validationErrorMessage
        }
      }
    }
  ''';
}
