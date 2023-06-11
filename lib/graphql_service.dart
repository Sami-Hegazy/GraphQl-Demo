import 'package:graphql_demo/graphql_config.dart';
import 'package:graphql_demo/products_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const query = """
query products{
  products(first: 10, channel: "default-channel") {
    edges {
      node {
        id
        name
        description
        thumbnail{
          url
        }
      }
    }
  }
}
""";

class GraphQlService {
  static GraphqlConfig graphqlConfig = GraphqlConfig();
  GraphQLClient client = graphqlConfig.client();

  Future<List<Products>> getProducts() async {
    try {
      final result = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(query),
      ));

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List? products = result.data?['products']['edges'];
      if (products == null || products.isEmpty) {
        return [];
      }
      final productList = products.map((product) {
        return Products.fromJson(json: product['node']);
      }).toList();

      return productList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
