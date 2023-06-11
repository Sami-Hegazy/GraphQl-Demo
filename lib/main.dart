import 'package:flutter/material.dart';
import 'package:graphql_demo/graphql_service.dart';
import 'package:graphql_demo/products_model.dart';

void main() {
  // final HttpLink http = HttpLink("https://demo.saleor.io/graphql/");
  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //   GraphQLClient(
  //     link: http,
  //     cache: GraphQLCache(store: InMemoryStore()),
  //   ),
  // );

  // var app = GraphQLProvider(
  //   client: client,
  //   child: const MyApp(),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQl Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GraphQlService service = GraphQlService();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Graphql Demo"),
      ),
      body: FutureBuilder<List<Products>>(
        future: service.getProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Products',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (_, index) {
                        final product = products[index];

                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              width: 180,
                              height: 180,
                              child: Image.network(product.thumbnailUrl!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  product.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Text("\$4.59"),
                          ],
                        );
                      }),
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}




/*
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Graphql Demo"),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(productsGraphql),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final productsList = result.data?['products']['edges'];
          debugPrint(productsList.toString());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Products',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (_, index) {
                      var product = productsList[index]['node'];
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            width: 180,
                            height: 180,
                            child: Image.network(product['thumbnail']['url']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                product['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const Text("\$4.59"),
                        ],
                      );
                    }),
              ))
            ],
          );
        },
      ),
    );
  }
}
*/