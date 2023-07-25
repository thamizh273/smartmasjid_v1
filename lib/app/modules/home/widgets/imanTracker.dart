

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';



class ImanTracker_widget extends StatelessWidget {
  const ImanTracker_widget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10),
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
                  text: 'Iman \n Tracker',
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

                      Stxt(text: 'Monthly Status', size: f1),
                      SizedBox(width: 5.w,),
                      SizedBox(
                        width: 50.w,
                        child: StepProgressIndicator(
                          totalSteps: 10,
                          currentStep: 4,
                          size: 6,
                          padding: 0,
                          selectedColor: Color(0xff4EAF2C),
                          unselectedColor: Color(0xffAFAFAF),
                          roundedEdges: Radius.circular(10),
                        ),
                      ),
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
                                themeData: themeData, text: 'Fajir',),
                              Imanprogress(
                                themeData: themeData, text: 'Asr',),
                              Imanprogress(
                                themeData: themeData, text: 'Isha',),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Imanprogress(themeData: themeData, text: 'Dhuhr',),
                            Imanprogress(themeData: themeData, text: 'Maghrib',),
                            Imanprogress(themeData: themeData, text: 'Quran Reading',),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Stxt(
                        text: 'Last Updated 13 hrs ago',
                        size: f0.sp,
                        color: Color(0xff878787),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      SButton(
                          color: themeData.primaryColor,
                          rad: 5,
                          height: 20.h,
                          width: 140.w,
                          pad: 0,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Stxt(
                                text: "click here to update",
                                size: f0,

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
                            Get.toNamed(Routes.IMAN_TRACKER);
                            
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