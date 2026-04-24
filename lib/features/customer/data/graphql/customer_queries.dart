class CustomerQueries {
  static const String customAddressesQuery = r'''
    query ActiveCustomer {
        activeCustomer {
            addresses {
                id
                fullName
                company
                streetLine1
                streetLine2
                city
                province
                postalCode
                phoneNumber
                defaultShippingAddress
                defaultBillingAddress
                customFields
                country {
                    id
                    code
                    name
                    customFields
                }
            }
        }
    }
  ''';
}
