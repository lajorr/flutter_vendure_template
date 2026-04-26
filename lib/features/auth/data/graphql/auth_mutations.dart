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

  static const loginMutation = r'''
    mutation Login($username: String!, $password: String!) {
      login(username: $username, password: $password){
        ... on CurrentUser {
            id
        }
        ... on InvalidCredentialsError {
            errorCode
            message
        }
        ... on NotVerifiedError {
            errorCode
            message
        }
        ... on NativeAuthStrategyError {
            errorCode
            message
        }
      }
    }
  ''';
}
