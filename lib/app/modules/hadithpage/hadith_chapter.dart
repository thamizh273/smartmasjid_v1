import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../widgets/space.dart';

class HadithChapter extends StatelessWidget {
  const HadithChapter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Hadith Chapters",
        action: [
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_sharp)),
              IconButton(onPressed: (){}, icon: Icon(Icons.bookmark)),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xff16627C)
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/book.png", scale: 8,),
                  Space(8),
                  Text("Sahih Al-Bukhari", style: TextStyle(fontSize: 18),)
                ],
              ),
            ),
            Space(8),
            Text("Select chapter you want to read", style: TextStyle(color: Colors.black.withOpacity(0.5)),),
            Space(16),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Stack(children: [
            //         Padding(
            //           padding: const EdgeInsets.only(top: 12),
            //           child: Text("1", style: TextStyle(fontSize: 15),),
            //         ),
            //         Image.asset("assets/images/hadithchap.png",scale: 3,)]),
            //       Space(8),
            //       Text("Revelation", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            //       Spacer(),
            //       Text("1-7")
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffBCDDF2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: Text("1"),
                            ),
                            Image.asset("assets/images/hadithchap.png",scale: 3,)]),
                          Space(8),
                          Text("Revelation", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Text("1-7")
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
