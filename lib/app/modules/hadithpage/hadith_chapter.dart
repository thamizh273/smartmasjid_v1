import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmasjid_v1/app/modules/hadithchapterdetail/views/hadithchapterdetail_view.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../widgets/space.dart';

class HadithChapter extends StatelessWidget {
  const HadithChapter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Hadith",
        action: [
          Row(
            children: [
             Image.asset("assets/images/notes.png", width: 20,),
             Space(16),
             Image.asset("assets/images/bookmark.png", width: 20,),
              Space(16),
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
                  return GestureDetector(
                    child: Container(
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
                            Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/hadithnum.png"),
                                    fit: BoxFit.fill
                                ),
                              ),
                              child: Align(
                                alignment: Alignment
                                    .center,
                                child: Text("100", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                              ),
                            ),
                            Space(8),
                            Text("Revelation", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                            Spacer(),
                            Text("1-7")
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HadithchapterdetailView()));
                    },
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
