


import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';

import '../../../../utils/color_utils.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';



class ImanTracker_widget extends StatelessWidget {
   ImanTracker_widget({
    super.key,
    required this.themeData,
  });
  final homectrl = Get.find<HomeController>();

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
     var guest= homectrl.hh[0]==true;
    var imanWeek= guest==true?null:homectrl.imanStatusData.value.getImanTrackerStatus!;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 9),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      color: themeData.colorScheme.secondary,
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/imanTracker.png',
                  height: 85.h,

                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10,),
                Stxt(
                  text: 'iman_tracker'.tr,
                  size: f3,
                  color: themeData.primaryColor,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Stxt(text: 'weekly_status'.tr, size: f1,weight: FontWeight.w500,color: Get.theme.primaryColor,),
                      SizedBox(width: 2.w,),

                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 10.w,top: 10,bottom: 12),
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Imanprogress(
                                themeData: themeData, text: 'fajr'.tr, percent:((imanWeek==null?100:imanWeek[0].status!.injamaah!+imanWeek[0].status!.ontime!)/100),),
                              Imanprogress(
                                themeData: themeData, text: 'jummah'.tr, percent: ((imanWeek==null?100:imanWeek[1].status!.injamaah!+imanWeek[1].status!.ontime!)/100),),
                              Imanprogress(
                                themeData: themeData, text: 'dhuhr'.tr, percent: ((imanWeek==null?100:imanWeek[2].status!.injamaah!+imanWeek[2].status!.ontime!)/100),),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Imanprogress(themeData: themeData, text: 'asr'.tr, percent: ((imanWeek==null?100:imanWeek[3].status!.injamaah!+imanWeek[3].status!.ontime!)/100),),
                            Imanprogress(themeData: themeData, text: 'maghrib'.tr, percent: ((imanWeek==null?100:imanWeek[4].status!.injamaah!+imanWeek[4].status!.ontime!)/100),),
                            Imanprogress(themeData: themeData, text: 'isha'.tr, percent: ((imanWeek==null?100:imanWeek[5].status!.injamaah!+imanWeek[5].status!.ontime!)/100),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // Stxt(
                      //   text: 'Last Updated 13 hrs ago',
                      //   size: f0.sp,
                      //   color: Color(0xff878787),
                      // ),
                      SizedBox(
                        height: 5,
                      ),

                      SButton(
                          color: themeData.primaryColor,
                          rad: 5,
                          height: 30.h,
                          width: 140.w,
                          pad: 0,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Stxt(
                                text: "click_here_to_update".tr,
                                size: f0,color: clr_white

                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SvgPicture.asset(
                                'assets/svg/arrow.svg',
                                width: 10.w,
                                color: Colors.white,
                              )
                            ],
                          ), ontap: (){
                        guest?guestmessage():    Get.toNamed(Routes.IMAN_TRACKER);
                            
                      }),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}