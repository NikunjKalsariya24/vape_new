import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration{
  //
  // static HttpLink httpLink =
  // HttpLink('https://4pay.ai/backend/graphql');
  // GraphQLClient client() =>
  //     GraphQLClient(link: httpLink, cache: GraphQLCache());

  // GraphQLClient client() =>
  //     GraphQLClient(link: httpLink, cache: GraphQLCache());


  ///
  // static HttpLink httpLink =
  // HttpLink('https://4pay.ai/backend/graphql');
  // GraphQLClient client({required String authToken}) {
  //   final HttpLink httpLink = HttpLink("https://4pay.ai/backend/graphql");
  //
  //   final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $authToken');
  //
  //   final Link link = authLink.concat(httpLink);
  //
  //   return GraphQLClient(
  //     link: link,
  //     cache: GraphQLCache(),
  //   );
  // }

  ///
  ///
  ///
  static String? _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static GraphQLClient client() {
    final HttpLink httpLink = HttpLink("https://knockknock.mx/backend/graphql");

    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $_authToken');

    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }
}


