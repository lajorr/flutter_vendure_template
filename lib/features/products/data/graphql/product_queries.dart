class ProductQueries {
  static const String getProducts = r'''
    query GetProducts($take: Int, $skip: Int) {
      products(options: { take: $take, skip: $skip }) {
        items {
          id
          name
          slug
          description
          enabled
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
      }
    }
  ''';
}
