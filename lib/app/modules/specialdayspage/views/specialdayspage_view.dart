import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/specialdayspage_controller.dart';

class SpecialdayspageView extends GetView<SpecialdayspageController> {
   SpecialdayspageView({Key? key}) : super(key: key);

  List<SpclDays> daysList = [
    SpclDays(text: "Shab e Meraj 2023", month: "Feb", year: "Sunday, 27th Rajab 1444h", date: "19"),
    SpclDays(text: "Shab e Barat 2023", month: "Mar", year: "Wednesday, 15th Shaban 1444h", date: "08"),
    SpclDays(text: "Ramadan 2023", month: "Mar", year: "Friday, 1st Ramadan 1444h", date: "24"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(tittle: 'special_days'.tr,
        ),

        body: FrostedBottomBar(
          width: 330.w,
          opacity: .8,
          sigmaX: 10,
          sigmaY: 10,
          bottomBarColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 800),
          hideOnScroll: true,
          body: (BuildContext context, ScrollController controller) {
            return  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).primaryColor
                    ),
                    child: Center(child: Text("2023", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: daysList.length,
                        itemBuilder: (context, index) {
                          SpclDays spcldays = daysList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.shade400
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Container(
                                    height: 50.h,
                                    width: 50.h,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: 16.h,
                                            width: double.infinity,
                                            child: Container(
                                              color: Theme.of(context).primaryColor,
                                              child: Center(child: Text("${spcldays.month}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                                            )),
                                        SizedBox(
                                            child: Container(
                                              height: 37,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("${spcldays.date}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                                                ],
                                              ),
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                  title: Text("${spcldays.text}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                  subtitle:  Text("${spcldays.year}", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),),
                                ),
                              ),
                            ),
                          );
                        }

                    ),
                  ),
                ),
              ],
            );
          }, child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/masjidbot.svg"),
              Space(8),
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.QURANPAGE);
                  },
                  child: SvgPicture.asset("assets/svg/quranbot.svg")),
              Space(8),
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
                  },
                  child: SvgPicture.asset("assets/svg/homebot.svg")),
              Space(8),
              SvgPicture.asset("assets/svg/mediabot.svg"),
              Space(8),
              SvgPicture.asset("assets/svg/donatebot.svg"),
            ],
          ),
        ),)
    );
  }
}


class SpclDays{
  String? text;
  String? month;
  String? date;
  String? year;

  SpclDays({
    this.text,
    this.month,
    this.date,
    this.year,
  });
}