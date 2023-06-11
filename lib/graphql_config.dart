import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlConfig {
  static HttpLink http = HttpLink("https://demo.saleor.io/graphql/");
  // GraphQLClient client = GraphQLClient(
  //   link: http,
  //   cache: GraphQLCache(store: InMemoryStore()),
  // );

  GraphQLClient client() => GraphQLClient(link: http, cache: GraphQLCache());
}
