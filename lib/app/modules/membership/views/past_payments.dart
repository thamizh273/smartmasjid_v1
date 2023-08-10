import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class PastPayments extends StatelessWidget {
  const PastPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Past Payments",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 130.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 4,
                    offset: Offset(0,4),
                    color: Colors.grey.shade400
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("June 2023", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                        Spacer(),
                       Image.asset("assets/images/alert.png", width: 20,),
                        Space(8),
                        Text("Partially Paid", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Space(25),
                    Container(
                      height: 30,
                      width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    ),
                    Space(16),
                    Row(
                      children: [
                        Icon(Icons.download_for_offline, color: Theme.of(context).primaryColor,),
                        Space(8),
                        Text("Download Receipt", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                        Spacer(),
                        Container(
                          height: 20,
                          width: 20,
                         decoration: BoxDecoration(
                           color: Theme.of(context).primaryColor,
                           borderRadius: BorderRadius.circular(4)
                         ),
                        ),
                        Space(12),
                        Text("Paid", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),
                        Space(16),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                            ),
                            Space(12),
                            Text("Due", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),)
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Space(20),
            Container(
              height: 130.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 4,
                    offset: Offset(0,4),
                    color: Colors.grey.shade400
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("May 2023", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                        Spacer(),
                       Image.asset("assets/images/tick.png", width: 20,),
                        Space(8),
                        Text("Fully Paid", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Space(25),
                    Container(
                      height: 30,
                      width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    ),
                    Space(16),
                    Row(
                      children: [
                        Icon(Icons.download_for_offline, color: Theme.of(context).primaryColor,),
                        Space(8),
                        Text("Download Receipt", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                        Spacer(),
                        Container(
                          height: 20,
                          width: 20,
                         decoration: BoxDecoration(
                           color: Theme.of(context).primaryColor,
                           borderRadius: BorderRadius.circular(4)
                         ),
                        ),
                        Space(12),
                        Text("Paid", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),
                        Space(16),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                            ),
                            Space(12),
                            Text("Due", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),)
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
