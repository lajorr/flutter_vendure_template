class CartQueries {
  static const String activeOrderQuery = r'''
    query ActiveOrder {
        activeOrder {
            id
            orderPlacedAt
            code
            state
            active
            couponCodes
            totalQuantity
            subTotal
            subTotalWithTax
            currencyCode
            shipping
            shippingWithTax
            total
            totalWithTax
            customFields
            shippingAddress {
                fullName
                company
                streetLine1
                streetLine2
                city
                province
                postalCode
                country
                countryCode
                phoneNumber
                customFields
            }
            lines {
                id
                unitPrice
                unitPriceWithTax
                discountedUnitPrice
                quantity
                linePrice
                linePriceWithTax
                discountedLinePrice
                customFields
                productVariant {
                    id
                    name
                    sku
                    price
                    featuredAsset {
                        preview
                        source
                    }
                    assets{
                      preview
                      source
                    }
                }
            }
            billingAddress {
                fullName
                company
                streetLine1
                streetLine2
                city
                province
                postalCode
                country
                countryCode
                phoneNumber
                customFields
            }
            shippingLines {
                id
                price
                priceWithTax
                discountedPrice
                discountedPriceWithTax
                customFields
            }
            type
        }
    }
  ''';
}
