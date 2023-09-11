// import 'package:hive_flutter/hive_flutter.dart';
//
// import '../../modules/example/home-with-restAPI/model/posts.dart';
//
// class MyHive {
//   // Prevent making an instance of this class
//   MyHive._();
//
//   // Hive box to store movie data
//   static late Box<Posts> _postBox;
//
//   // Box name, it's like the table name
//   static const String _postBoxName = 'posts';
//
//   /// Initialize local db (HIVE)
//   /// Pass testPath only if you are testing hive
//   static Future<void> init(
//       {Function(HiveInterface)? registerAdapters, String? testPath}) async {
//     if (testPath != null) {
//       Hive.init(testPath);
//     } else {
//       await Hive.initFlutter();
//     }
//     await registerAdapters?.call(Hive);
//     await initPostsBox();
//   }
//
//   /// Initialize post box
//   static Future<void> initPostsBox() async {
//     _postBox = await Hive.openBox<Posts>(_postBoxName);
//   }
//
//   /// Save all posts to the database
//   static Future<void> saveAllPosts(List<Posts> posts) async {
//     try {
//       await _postBox.clear(); // Clear existing data
//       await _postBox.addAll(posts); // Add all posts to Hive
//     } catch (error) {
//       // Handle error
//     }
//   }
//
//   /// Get all posts from Hive
//   static List<Posts> getAllPosts() {
//     final posts = _postBox.values.toList();
//     return posts
//         .cast<Posts>(); // Cast the list to the correct type (List<Posts>)
//   }
// }
