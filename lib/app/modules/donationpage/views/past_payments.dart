
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';



class PastPayments extends StatelessWidget {
  const PastPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "past_donation".tr,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        physics: BouncingScrollPhysics(),
        itemCount: 10,
          itemBuilder: (context, index){
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.w),
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 80.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/masjidselc.png", fit: BoxFit.fill,),
                            )
                        ),
                      ),
                      6.horizontalSpace,
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Space(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(flex: 2,child: Stxt(text: "Masjid Construction", size: f3, weight: FontWeight.w600, overflow: TextOverflow.ellipsis)),

                                Flexible(flex: 1,child: Stxt(text: "23 days left", size: f1, color: Colors.black.withOpacity(0.5),pad: EdgeInsets.symmetric(horizontal: 5.w),)),
                              ],
                            ),
                            Space(6),
                            Stxt(text: "Masjid Sadaqah", size: f2,weight: FontWeight.w400,),
                            Space(8),
                            Row(
                              children: [
                                Image.asset("assets/images/tick.png", width: 16,),
                                Space(8),
                                Stxt(text: "₹2,000 Donated", size: f3, weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
                                60.horizontalSpace,
                                Image.asset("assets/images/download.png", width: 25,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          }
      )
    );
  }
}
