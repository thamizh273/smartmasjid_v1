import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

import '../server/config.dart';


class restCallController extends GetxController {
  var res = ''.obs;

  Future restCall(body) async {
    var headers = {'user-id': 'selva', 'content-type': 'application/json'};

   var request = http.Request('POST', Uri.parse("https://smasjidgraphqlserver-3gw3zjicpa-uc.a.run.app/smasjidql"));
   // var request = http.Request('POST', Uri.parse("http://localhost:4000/ecomql"));

    print("res pa ss");

    request.body = body;

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var k = await (response.stream.bytesToString());
    print("res pa ss");
    return k;
  }

  snakbar({type, msg}) {
    switch (type) {
      case "ERROR":
        Get.snackbar("Error", msg,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.only(bottom: 30),
            maxWidth: 350,
            borderWidth: 1,
            borderColor: Colors.red,
            colorText: Colors.black,
            backgroundColor: Colors.red,
            borderRadius: 3,
            shouldIconPulse: false,
            icon: Icon(
              Icons.message,
              color: Colors.red,
            ),
            forwardAnimationCurve: Curves.ease,
            backgroundGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.red.withOpacity(0.3),
                  Colors.red.withOpacity(0.3)
                ]),
            animationDuration: Duration(milliseconds: 2000));
        break;

      // case "ERRORRs":
      //   MotionToast(
      //     description: Text("This is a styled toast"),
      //     title: Text("Error"),
      //     animationCurve: Curves.bounceIn,
      //     animationDuration: Duration(microseconds: 100),
      //     icon: Icons.message,
      //     backgroundType: BackgroundType.lighter,
      //     primaryColor: Colors.red,
      //   ).show(Get.context);
      //   break;

    }




  }


  Future gql_query(header, body) async {
    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = await graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.query(
      QueryOptions(document: gql(header), variables: body),
    );

    if (result.hasException) {
      print("loggedpa ${result.exception}");

      if (result.exception!.graphqlErrors == null) {
        snakbar(type: "ERROR", msg: "Network Error");

        return;
      }
      else if( result.exception!.graphqlErrors[0].message.contains("Data Empty!")){ }
      // else if(result.hasException) {
      //   if (result.exception!.graphqlErrors.isNotEmpty) {
      //     final graphQLError = result.exception!.graphqlErrors[0];
      //     final errorMessage = graphQLError.message;
      //     // Handle the error message here
      //     print(errorMessage);
      //     snakbar(type: "ERROR", msg: errorMessage);
      //   }
      // }

      else {
        print("graphqll error ${result.exception}");

        snakbar(type: "ERROR", msg: "Server Error");

        return;
      }
    } else if (result.data != null) {
      //print("rese dod ${result.data}")
      var res = result.data;
      return res;
    }
  }

  Future gql_mutation(header, body) async {
    print("mutating");

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = await graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(document: gql(header), variables: body),
    );

    if (result.hasException) {
      // print("eror ${result.exception}");
      var res = {"ERROR": result.exception};
      return res;
    } else if (result.data != null) {
      // print("rese dod ${result.data}");

      var res = {"SUCCESS": result.data};
      return res;
    }
  }
}