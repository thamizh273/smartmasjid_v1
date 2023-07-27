import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class TajweedRules extends StatelessWidget {
  const TajweedRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Tajweed Rules",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("مـ", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffC92F2F), fontSize: 20),),
                  Space(8),
                  Stxt(text: "Must Stop", size: f3, weight: FontWeight.w600, color: Color(0xffC92F2F),),
                  Spacer(),
                  Stxt(text: "found 22 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              )
              ,
              Row(
                children: [
                  Text("قلى", style: TextStyle(fontWeight: FontWeight.w600, color:Color(0xffB4592C), fontSize: 20),),
                  Space(8),
                  Stxt(text: "Better to stop", size: f3, weight: FontWeight.w600, color: Color(0xffB4592C),),
                  Spacer(),
                  Stxt(text: "found 603 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Row(
                children: [
                  Image.asset("assets/images/haq.png", width: 12,),
                  Space(8),
                  Stxt(text: "Pause at one", size: f3, weight: FontWeight.w600, color: Color(0xffB57D2E),),
                  Spacer(),
                  Stxt(text: "found 12 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Row(
                children: [
                  Text("س", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffB6AF31), fontSize: 20),),
                  Space(8),
                  Stxt(text: "A slight pause", size: f3, weight: FontWeight.w600, color: Color(0xffB6AF31),),
                  Spacer(),
                  Stxt(text: "found 7 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Row(
                children: [
                  Text("ج", style: TextStyle(fontWeight: FontWeight.w600, color:Color(0xffA3B734), fontSize: 20),),
                  Space(8),
                  Stxt(text: "Stop or Continue", size: f3, weight: FontWeight.w600, color:Color(0xffA3B734),),
                  Spacer(),
                  Stxt(text: "found 1972 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Row(
                children: [
                  Text("صلى", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xff94BA3D), fontSize: 20),),
                  Space(8),
                  Stxt(text: "Better to Continue", size: f3, weight: FontWeight.w600, color: Color(0xff94BA3D),),
                  Spacer(),
                  Stxt(text: "found 1682 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Row(
                children: [
                  Text("لا", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff6CC152), fontSize: 20),),
                  Space(8),
                  Stxt(text: "Dont Stop", size: f3, weight: FontWeight.w600, color: Color(0xff6CC152),),
                  Spacer(),
                  Stxt(text: "found 68 times", size: f2, weight: FontWeight.w600, color: Colors.black.withOpacity(0.4),),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffD7743C),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,4),
                      blurRadius: 4,
                      color: Colors.grey
                    )
                  ]
                ),
                child: Center(
                    child: Text("Ghunna (Nasalisation)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
             Image.asset("assets/images/text.png",width: 400,),
              Space(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text1.png", width: 150,),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffCB3030),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 4,
                          color: Colors.grey
                      )
                    ]
                ),
                child: Center(
                    child: Text("Ikhfa’a (Lenition/Hiding)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
              Image.asset("assets/images/text3.png",width: 350,),
              Space(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("OR"),
                ],
              ),
              Space(8),
              Text("When the letter ب appears after a مْ it will a light nasal sound in the nose."),
              Space(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text4.png", width: 220,),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff9930CB),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 4,
                          color: Colors.grey
                      )
                    ]
                ),
                child: Center(
                    child: Text("Idgham (Elision/Merging)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
              Image.asset("assets/images/text5.png",width: 350,),
              Space(8),
              Text("OR"),
              Space(8),
              Text("When a  is followed by  , the former will become incorperated"
                "into the latter and will be read with Ghunna."),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text6.png", width: 300,),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff8F8F8F),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 4,
                          color: Colors.grey
                      )
                    ]
                ),
                child: Center(
                    child: Text("Idgham without Ghunna", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
              Text("Any ن or ً  ٍ  ٌ  followed by ل or ر will become assimilated into the following letter but the ghunna will not pronounced."),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text7.png", width: 180,),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff35519A),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 4,
                          color: Colors.grey
                      )
                    ]
                ),
                child: Center(
                    child: Text("Iqlab (Assilimilation/Flipping)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
              Image.asset("assets/images/text8.png", width: 350,),
              Space(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text9.png", width: 250,),
                ],
              ),
              Space(16),
              Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff319628),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 4,
                          color: Colors.grey
                      )
                    ]
                ),
                child: Center(
                    child: Text("Qalaqala (Echoing)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),)),
              ),
              Space(16),
              Image.asset("assets/images/text10.png", width: 350,),
              Space(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/images/text11.png", width: 150,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
