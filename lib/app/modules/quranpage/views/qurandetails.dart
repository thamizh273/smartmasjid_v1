import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../../widgets/space.dart';


class QuranDetails extends StatefulWidget {
  const QuranDetails({super.key});

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

class _QuranDetailsState extends State<QuranDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "",
        action: [
          Row(
            children: [
              Icon(Icons.dangerous_rounded),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined)),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 90.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/quranheader.png",
                  ),
                  fit: BoxFit.fill
                )
              ),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/quranvector.png", scale: 3,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
