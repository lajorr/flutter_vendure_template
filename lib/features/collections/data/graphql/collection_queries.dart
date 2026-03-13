class CollectionQueries {
  static const String getCollections = r'''
    query GetCollections($options: CollectionListOptions) {
      collections(options: $options) {
        items {
          id
          name
          slug
          featuredAsset {
            preview
          }
        }
        totalItems
      }
    }
  ''';
}
