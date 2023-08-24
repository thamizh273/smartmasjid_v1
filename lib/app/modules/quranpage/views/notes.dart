import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 130.h,
              width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16),
               border: Border.all(color: Theme.of(context).primaryColor),
               color: Colors.white
             ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stxt(text: "Notes Tittle 01", size: f4, weight: FontWeight.w600,),
                        Spacer(),
                        Icon(Icons.edit),
                      ],
                    ),
                    Space(8),
                    Stxt(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the pri.....", size: f3),
                    Space(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stxt(text: "Today", size: f1, ),
                      ],
                    )
                  ],
                ),
              ),
            )
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

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
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
    );
  }
}
