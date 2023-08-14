import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';


class QuranNotes extends StatelessWidget {
  const QuranNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Notes",
      ),
      body: Center(
        child: Column(
          children: [
            Space(100),
            Image.asset("assets/images/Notebook.png", width: 250,),
            Space(8),
            Stxt(text: "No Notes yet", size: f5, weight: FontWeight.w600,),
            Space(16),
            Stxt(text: "Tap ( Add ) to create a note", size: f2, color: Colors.black.withOpacity(0.5),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: IconButton(onPressed: (){
          showDialog(
            context: context,
            builder: (
                BuildContext context) {
              return CustomDialogBox1();
            },
          );
        }, icon: Icon(Icons.add)),
        onPressed: () {
        },
      ),
    );
  }
}
