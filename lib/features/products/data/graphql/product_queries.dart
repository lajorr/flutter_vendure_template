class ProductQueries {
  static const String getProducts = r'''
    query GetProducts($take: Int, $skip: Int) {
      products(options: { take: $take, skip: $skip }) {
        items {
          id
          name
          slug
          description
          assets {
            preview
          }
          variants {
            priceWithTax
          }
        }
        totalItems
      }
    }
  ''';

  static const String getProductDetails = r'''
    query GetProductDetails($slug: String!) {
      product(slug: $slug) {
        id
        name
        slug
        description
        assets {
          preview
        }
        variants {
          id
          name
          priceWithTax
          currencyCode
        }
      }
    }
  ''';
}
