import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/widgets/space.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../app/modules/quranpage/views/qurandetails.dart';
import '../global.dart';

Future QuranPlanner(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              // color: Color(0xff16627C),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space(20),
                Stxt(text: "Select Range", size: f3, weight: FontWeight.w600,),
                Space(20),
                Row(
                  children: [
                    Stxt(text: "From", size: f3,  weight: FontWeight.w600),
                    Spacer(),
                    Column(
                      children: [
                        Stxt(text: "Al-Fatiah 1:1 ", size: f3,  weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
                        Stxt(text: "Page 1 - Juz 1 ", size: f3),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down_outlined),
                  ],
                ),
                Space(20),
                Row(
                  children: [
                    Stxt(text: "To", size: f3,  weight: FontWeight.w600),
                    Spacer(),
                    Column(
                      children: [
                        Stxt(text: "An -Nas 114:6 ", size: f3,  weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
                        Stxt(text: "Page 604 - Juz 30 ", size: f3),
                      ],
                    ),
                    Icon(Icons.arrow_drop_down_outlined),
                  ],
                ),
                Space(20),
                Row(
                  children: [
                    Stxt(text: "Number of Days", size: f3,  weight: FontWeight.w600),
                    Spacer(),
                    Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          )
                      ),
                      child: TextField(
                      ),
                    )
                  ],
                ),
                Space(20),
                Row(
                  children: [
                    Stxt(text: "Notification", size: f3,  weight: FontWeight.w600),
                    Spacer(),
                    Obx(() {
                      return Switch(
                        value: c.switchValue.value,
                        onChanged: (newValue) {
                          c.switchValue.value = newValue;
                        },
                      );
                    }),
                  ],
                ),
                Space(20),
                Row(
                  children: [
                    Stxt(text: "Notification Time", size: f3,  weight: FontWeight.w600),
                    Spacer(),
                    Stxt(text: "12.30 PM", size: f3)
                  ],
                ),
                Space(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: ()   {
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 40),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text("Add Planner", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white))),
                  ],
                )
              ],
            ),
          )
      );
    },
  );
}