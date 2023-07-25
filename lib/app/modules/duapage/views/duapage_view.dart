import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../../widgets/space.dart';
import '../controllers/duapage_controller.dart';

class DuapageView extends GetView<DuapageController> {
  DuapageView({Key? key}) : super(key: key);

  final DuapageController c = Get.put(DuapageController());
  final Color oddItemColor = Color(0xffB5CCD4);
  final Color evenItemColor = Color(0xff6C9AA9);
  final Color other = Color(0xff84ABB7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Dua",
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text("I am Feeling", style: TextStyle(fontSize: 18),),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Scrollbar(
                      thumbVisibility: false,
                      thickness: 4,
                      controller: c.scrollController,
                      radius: Radius.circular(20),
                      child: GridView.builder(
                        itemCount:c.isExpanded.value ? 20 : 12,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.landscape ? 3: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (2 / 1),
                        ),
                        itemBuilder: (context,index,) {
                          Color color = index % 2 == 0 ? evenItemColor : oddItemColor;
                          return GestureDetector(
                            onTap:(){
                              // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                            },
                            child:Container(
                              color: color,
                              // color: RandomColorModel().getColor(),
                              child: Center(
                                child: Text("Angry",style: TextStyle(fontSize: 18, color: Colors.black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
              Obx(() {
                return GestureDetector(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c.isExpanded.value ? "See Less" : "See More", style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),),
                         Icon(c.isExpanded.value ? Icons.expand_less : Icons.expand_more, color: Theme.of(context).primaryColor,),
                      ],
                    ),
                  ),
                  onTap: () {
                    c.isExpanded.toggle();
                  },
                );
              }),
              Space(16),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: false,
                  thickness: 4,
                  controller: c.scrollController,
                  radius: Radius.circular(20),
                  child: GridView.builder(
                    itemCount:10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape ? 3: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: (2 / 1),
                    ),
                    itemBuilder: (context,index,) {
                      return GestureDetector(
                        onTap:(){
                          // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                        },
                        child:FractionallySizedBox(
                          heightFactor: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xff17637D)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.asset("assets/images/slepping.png"),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Sleeping",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              )

            ],
          ),
        ),
      ),
    );
  }
}
