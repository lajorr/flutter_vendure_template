class ProductQueries {
  static const String getProducts = r'''
    query GetProducts($take: Int, $skip: Int) {
      products(options: { take: $take, skip: $skip }) {
        items {
          id
          createdAt
          updatedAt
          languageCode
          name
          slug
          description
          enabled
          customFields
          featuredAsset {
            id
            source
            preview
          }
          assets {
            id
            source
            preview
          }
          variants {
              id
              productId
              createdAt
              updatedAt
              languageCode
              sku
              name
              price
              currencyCode
              priceWithTax
              stockLevel
              customFields
              featuredAsset {
                id
                source
                preview
              }
              assets {
                id
                source
                preview
              }
              options {
                  id
                  createdAt
                  updatedAt
                  languageCode
                  code
                  name
                  groupId
                  customFields
              }
          }
          optionGroups {
              id
              createdAt
              updatedAt
              languageCode
              code
              name
              productCount
              customFields
              options {
                  id
                  code
                  name
              }
          }
        }
        totalItems
      }
    }
  ''';

  static const String getProductDetails = r'''
    query GetProductDetails($id: ID!) {
      product(id: $id) {
        id
        name
        slug
        description
        enabled
        featuredAsset {
          id
          preview
          source
        }
        assets {
          id
          preview
          source
        }
        variants {
          id
          priceWithTax
          price
          name
          sku
          featuredAsset{
            id
            source
            preview
          }
          assets{
            id
            source
            preview
          }
          options{
            id
            name
            code
          }
          stockLevel
          facetValues{
            id
            name
            code
          }
        }
        optionGroups {
          id
          code
          name
          productCount
          options {
            id
            code
            name
          }
        }
      }
    }
  ''';
}
