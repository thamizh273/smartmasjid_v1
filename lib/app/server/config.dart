import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  Future<GraphQLClient> clientToQuery() async {
   HttpLink httpLink = HttpLink("https://smasjidgraphqlserver-3gw3zjicpa-uc.a.run.app/smasjidql", defaultHeaders: {});
    // HttpLink  httpLink = HttpLink("http://192.168.29.234:4000/ecomql", defaultHeaders: {});
    return GraphQLClient(
      cache: GraphQLCache(

      ),
      link: httpLink,
    );
  }
}
