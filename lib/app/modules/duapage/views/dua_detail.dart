import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

class DuaDetail extends StatelessWidget {
  const DuaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Dua",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stxt(text: "I Am Feeling", size: f4, weight: FontWeight.w500,),
                Space(8),
                Stxt(text: "Angry", size: f4, weight: FontWeight.w500, color: Theme.of(context).primaryColor,),
              ],
            ),
            Space(16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                  itemBuilder: (context, index){
                  return Column(
                    children: [
                      Stxt(text: "#1", size: f4, color: Theme.of(context).primaryColor, weight: FontWeight.w600,),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Container(
                          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:Color(0xff1A667F)
          ),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                        Stxt(text: "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ", size: f5, color: Colors.white,),
                        Space(12),
                        Stxt(text: "Aʿūdhu bi-llāhi mina-sh-Shayṭāni-r-rajīm.ِ", size: f4, color: Color(0xff78BDD4),),
                        Space(12),
                        Stxt(text: "I seek protection in Allah from the rejected Shayṭān", size: f4, color: Colors.white.withOpacity(0.8),),
                ],
              ),
          ),
                        ),
                      ),
                    ],
                  );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
