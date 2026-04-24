class AuthQueries {
  static const activeCustomerQuery = r'''
    query ActiveCustomer {
      activeCustomer {
        id
        createdAt
        updatedAt
        title
        firstName
        lastName
        phoneNumber
        emailAddress
        customFields
      }
    }
  ''';
}
