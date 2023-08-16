import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/duapage/model/dua_model.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/model/quran_model.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../widgets/space.dart';
import '../controllers/duapage_controller.dart';
import 'dua_detail.dart';

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
        child: Obx(() {
          return c.isLoadings.value ? loading(context) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              controller: c.scrollController,
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "I am Feeling", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return SizedBox(
                        //height: 400,
                        child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          controller: c.scrollController,
                          itemCount: c.isExpanded.value ? c.getduadata.value
                              .getDuasTitleList!.feeling!.length : 12,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery
                                .of(context)
                                .orientation ==
                                Orientation.landscape ? 3 : 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: (2 / 1),
                          ),
                          itemBuilder: (context, index,) {
                            var dua = c.getduadata.value
                                .getDuasTitleList!.feeling![index];
                            Color color = index % 2 == 0
                                ? evenItemColor
                                : oddItemColor;
                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => DuaDetail()));
                                Get.to(DuaDetail());
                                c.duadetailList(dua.duasNameEn);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                // color: RandomColorModel().getColor(),
                                child: Center(
                                  child: Text("${dua.duasNameEn}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  Obx(() {
                    return GestureDetector(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(c.isExpanded.value ? "See Less" : "See More",
                              style: TextStyle(fontSize: 16, color: Theme
                                  .of(context)
                                  .primaryColor, fontWeight: FontWeight.w600),),
                            Icon(c.isExpanded.value ? Icons.expand_less : Icons
                                .expand_more, color: Theme
                                .of(context)
                                .primaryColor,),
                          ],
                        ),
                      ),
                      onTap: () {
                        c.isExpanded.toggle();
                      },
                    );
                  }),
                  Space(16),
                  Stxt(text: "Daily", size: f4, weight: FontWeight.w500,),
                  Obx(() {
                    return SizedBox(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        controller: c.scrollController,
                        shrinkWrap: true,
                        itemCount: c.getduadata.value.getDuasTitleList!.daily!
                            .length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery
                              .of(context)
                              .orientation ==
                              Orientation.landscape ? 3 : 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (2 / 1),
                        ),
                        itemBuilder: (context, index,) {
                          var daily = c.getduadata.value.getDuasTitleList!
                              .daily![index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(index);
                                },
                              );
                            },
                            child: FractionallySizedBox(
                              heightFactor: 0.8,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Color(0xff17637D)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            20),
                                      ),
                                      child:  Image
                                          .asset(
                                          "assets/images/${c.getduadata.value.getDuasTitleList!.daily![index].duasNameEn!.toLowerCase()}.png")
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "${daily.duasNameEn}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })

                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}


class CustomDialogBox extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();
  final  duaCtrl =Get.put( DuapageController());

  CustomDialogBox(this.index);
  int index;
  @override
  Widget build(BuildContext context) {
    var duaList=duaCtrl.getduadata.value.getDuasTitleList!.daily!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context,duaList[index].duasNameEn,duaList[index].titlesList!.map((e) => e.title).toList(),duaList[index].titlesList!.length),
    );
  }

  Widget _buildDialogContent(BuildContext context, String? title,  items, int count, ) {
    print(count);
    print(items);
    print(title);
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xffB5CCD4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.h,
              width: 180.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Theme
                      .of(context)
                      .primaryColor)
              ),
              child: Image.asset(
                "assets/images/${title!.toLowerCase()}.png", fit: BoxFit.fill,),
            ),
            Space(16),
            Stxt(text: "${title}", size: f5, weight: FontWeight.w500,),
            Space(16),
               Container(
                 constraints: BoxConstraints(
                   maxHeight: 400,
                 ),
               
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: count,
                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 30.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white
                          ),
                          child: Row(
                            children: [
                              Space(8),
                              SizedBox(width: 200.w,child: Stxt(text: "${items[index]}", size: f3,overflow: TextOverflow.ellipsis,)),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_outlined, size: 20,),
                              Space(8)
                            ],
                          ),
                        ),
                      );
                    }
                ),
              )
          ],
        ),
      );
  }
}