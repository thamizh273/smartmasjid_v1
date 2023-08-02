import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';


class QuranNotes extends StatelessWidget {
  const QuranNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Notes",
      ),
      body: Center(
        child: Text("No Notes Found"),
      ),
    );
  }
}
