import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/bookmarkpage_controller.dart';

class BookmarkpageView extends GetView<BookmarkpageController> {
  const BookmarkpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "BookMark",
      ),
      body: Working(),
    );
  }
}
