// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Share Play Store Link Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'assets/play_store_logo.png', // Replace with the path to your app's Play Store logo image
//                 width: 100,
//                 height: 100,
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   _sharePlayStoreLink();
//                 },
//                 child: Text('Share Play Store Link'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   _sharePlayStoreLink() async {
//     final String appStoreLink = "https://play.google.com/store/apps/details?id=your_app_package_name";
//     final String message = "Check out our app on the Play Store: $appStoreLink";
//
//     await Share.share(
//       message,
//       subject: "Check out this app",
//     );
//   }
// }
