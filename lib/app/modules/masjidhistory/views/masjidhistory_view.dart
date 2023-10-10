import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';
import 'package:smartmasjid_v1/app/modules/masjidhistory/controllers/masjidhistory_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

class MasjidhistoryView extends StatelessWidget {
  MasjidhistoryView({super.key});

  final homecntrl = Get.put(HomeController());
  final hiscntrl = Get.put(MasjidhistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "masjid_history".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            children: [
              Container(
                  height: 120.h,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/masjidhis.png", fit: BoxFit.cover,)),
              16.verticalSpace,
              Center(
                child: Stxt(text: "Test Masjid",
                  size: f5,
                  color: Get.theme.hoverColor,
                  weight: FontWeight.bold,),
              ),
              Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: menuBar(context),
                          ),
                          Expanded(
                            flex: 2,
                            child: PageView(
                              controller: homecntrl.pageController,
                              physics: const ClampingScrollPhysics(),
                              onPageChanged: (int i) {
                                FocusScope.of(context).requestFocus(
                                    FocusNode());
                                homecntrl.activePageIndex.value = i;
                              },
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints.expand(),
                                  child: SizedBox(
                                    height: 250.h,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Space(16),
                                        Text(
                                          "In the early 1980s, there were around 10 Muslim families living in the Depesanpet area of Muthialpet, Pondicherry. "
                                              "These people need to go to Kottakuppam Busthaniya Masjid for their prayers. On considering the difficulty, "
                                              "Marhoom Janab Abdul Hammed was kind enough to spare a room of his house to convert into a prayer hall for offering prayer. "
                                              "In the same room, a Madrassa for small children was also conducted.",
                                          textAlign: TextAlign.justify,
                                        ),
                                        Space(16),
                                        Text(
                                          "In the meanwhile, the Muslim population has started growing in Depesanpet and Muthialpet area. In specific, "
                                              "many families from the Koonimedu area have started acquiring "
                                              "properties and settled in this area for admitting their children in Pondicherry schools. "
                                              "As the Muslim population started growing, the people coming to attend the prayers has also increased considerably.",
                                          textAlign: TextAlign.justify,
                                        ),
                                        Space(16),
                                        Text(
                                          "In the year 1987, a piece of land measuring 1150 square feet was purchased "
                                              "by collection of donations and a thatched structure was built and named as Masjid-E-Noorania and "
                                              "regular 5 times prayers were conducted by an engaged Imam. Subsequently in the year 1990 with grace of Allah, "
                                              "the almighty, the present structure of Masjid was built with the fund received from various sources including from the "
                                              "people of Kuwait. However there were no toilet facilities available in the main structure of the Masjid. Therefore,"
                                              " another 230 square feet of land behind the Masjid was purchased in the year 1995 and toilet rooms were built. "
                                              "Now a full fledged Masjid is functioning with Jumma and Eid al Fitr and Eid al Adha prayers. A Maktab Madrassa is "
                                              "also functioning with two teachers in the Masjid where around 30 students are studying Islamic Education. "
                                              "The Masjid is also registered with the Puducherry State Waqf Board.",
                                          textAlign: TextAlign.justify,
                                        ),
                                        Space(16),
                                        Text(
                                          "As day by day the Muslim population started growing in and around Muthialpet"
                                              " area such as Viswanathan Nagar, Sentharamarai Nagar, Vasanth Nagar,Kennedy Garden, "
                                              "Sankardoss Nagar etc., the present Mosque could not accommodate all the people in Jummah "
                                              "prayer and other special occasions. Now a days, during Jummah many number of people were made offer"
                                              "their prayer in the road under hot sun due paucity of place in the Masjid. Therefore again with grace of Allah,"
                                              " the almighty, an area of 1080 square feet land behind "
                                              "the was purchased for Rs.6 Lakh in the year 2007 by getting donation from Muslim people.",
                                          textAlign: TextAlign.justify,
                                        ),
                                        Space(16),
                                        Text(
                                          "The total extent of land of our Masjid is given below:-"
                                              " 1. Land purchased in the year 1987 - 1150 Sq.feet-Present Masjid"
                                              " 2.Land purchased in the year 1995 - 230 Sq.feet-Toilet rooms"
                                              " 3: Land purchased in the year 2007 - 1080 Sq.feet-Vacant"
                                              " Total Area of land - 2410 Sq.feet"
                                              " Front entrance of the Masjid is at Depesanpet Street, Small Lane."
                                              " Back of the Masjid is at Visvanathan Nagar, Sekkizhar Street"
                                              " Considering paucity of space in the present Mosque, it was decided to construct a new Mosque of 2410 Sq.feet in the vacant land by demolishing the present mosque. Accordingly construction upto the basement level has been raised in the vacant place. On completion of the structure in the vacant land, the existing mosque will be demolished and the building will be extended to full length."
                                              " Activities of Present Management Committee:-"
                                              " 1. The new management committee took charge in the month of March, 2015."
                                              " 2. NewMaktab Madrassa has been started"
                                              " 3. Qiyamullail prayer conducted in the last ten days of Ramzan month. Free Sahar food was offered to all who attended the Qiyamullail prayer."
                                              " 4. Ramzan and Bakrid prayers were conducted in the Masjid."
                                              " 5. Poor Muslim families (22 families) were identified and food materials worth Rs.2200/- were given to each family and andFitra amount of Rs.800/- were also given to Jamath and other Muslims."
                                              " 6. Cash prizes and gifts received from Kuwait Jamath were distributed to Madrassa students and SSLC and Higher Secondary top rankers."
                                              " 7. Nikkah has been conducted in its own New Nikkah Register. As of now 11 Nikkahs have been registered in our Masjid."
                                              " 9. As of 2016 there are 296 Muslim families residing in the Muthialpet area. An amount of Rs.20,000/- is being received as monthly subscription. The amount is utilized for payment of salary to Imam and Muaddin. Regular monthly account is being submitted every month to the Puducherry State Wakf Board."
                                              " 10. As of October, 2016 an amount of Rs.20 Lakh has been received as donation from the Muslim public and Kuwait Jamath. It is pertinent to mention that a person, who does not want to disclose his name, residing in the Devagi Nagar,Muthialpet, Pondicherry has donated a highest amount of Rs.5 Lakh for construction of Mosque."
                                              " 11. All regular prayers, Maktab Madrassa in both the sessions have been conducted in our Masjid. Alhamdhulillah.",
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: SizedBox(
                                    height: 250.h,
                                    child: Obx(() {
                                      return hiscntrl.isLoadings0.value? loading(context): ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: hiscntrl.getmasjidfacility.value.getMasjidFacilitiesList!.length,
                                          itemBuilder: (context, index) {
                                            var facility = hiscntrl.getmasjidfacility.value.getMasjidFacilitiesList![index];
                                            return Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Container(
                                                  // height: 200.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius
                                                          .circular(8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset: Offset(
                                                                0, 2),
                                                            color: Get.theme
                                                                .shadowColor,
                                                            blurRadius: 2,
                                                            spreadRadius: 3
                                                        )
                                                      ]
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(12),
                                                    child: Column(
                                                        children: [
                                                          Stxt(text: "${facility.facilityTitle}",
                                                            size: f5,
                                                            weight: FontWeight
                                                                .bold,
                                                            color: Get.theme
                                                                .primaryColor,),
                                                          16.verticalSpace,
                                                          SizedBox(
                                                            child: ListView.builder(
                                                              physics: NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: facility.nameList!.length,
                                                              itemBuilder: (context, index){
                                                                var features = facility.nameList![index];
                                                                return Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Container(
                                                                        height: 40.h,
                                                                        width: 40.h,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                50),
                                                                            border: Border
                                                                                .all(
                                                                                color: Theme
                                                                                    .of(
                                                                                    context)
                                                                                    .primaryColor),
                                                                            color: Get
                                                                                .theme
                                                                                .focusColor
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            features.facilityName == "24/7 Surveillance camera (CCTV)"? SvgPicture.asset("assets/svg/surveillance camera (cctv).svg"): SvgPicture
                                                                                .asset(
                                                                              "assets/svg/${features.facilityName!.toLowerCase()}.svg",),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      8.horizontalSpace,
                                                                      Stxt(
                                                                        text: "${features.facilityName}",
                                                                        size: f3,
                                                                        color: Get.theme.primaryColor,),
                                                                    ],
                                                                  ),
                                                                );
                                                              }
                                                            ),
                                                          ),

                                                        ]
                                                    ),
                                                  ),
                                                )
                                            );
                                          }
                                      );
                                    }),
                                  ),
                                ),
                                ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: SizedBox(
                                      height: 250.h,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 200,
                                                    child: Image.asset(
                                                      "assets/images/gal1.png",
                                                      fit: BoxFit.cover,),
                                                  ),
                                                  Space(16),
                                                  Container(
                                                    height: 100,
                                                    width: 125,
                                                    child: Image.asset(
                                                      "assets/images/gal2.png",
                                                      fit: BoxFit.cover,),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      ),
                                    )
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: SizedBox(
                                    height: 250.h,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // height: 200.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 2),
                                                        color: Get.theme
                                                            .shadowColor,
                                                        blurRadius: 2,
                                                        spreadRadius: 3
                                                    )
                                                  ]
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    12),
                                                child: Column(
                                                  children: [
                                                    Stxt(text: "Toilet",
                                                      size: f5,
                                                      weight: FontWeight.bold,
                                                      color: Get.theme
                                                          .primaryColor,),
                                                    16.verticalSpace,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/toi1.png",
                                                          width: 100,),
                                                        Image.asset(
                                                          "assets/images/toi2.png",
                                                          width: 100,),
                                                        Image.asset(
                                                          "assets/images/toi3.png",
                                                          width: 100,),
                                                      ],
                                                    ),
                                                    10.verticalSpace,
                                                    Stxt(
                                                      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                                      size: f2,
                                                      color: Get.theme
                                                          .primaryColor,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: SizedBox(
                                    height: 250.h,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        Space(16),
                                        Container(
                                          // height: 200.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 2),
                                                    color: Get.theme
                                                        .shadowColor,
                                                    blurRadius: 2,
                                                    spreadRadius: 3
                                                )
                                              ]
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/gal8.png"),
                                                22.verticalSpace,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Stxt(text: "6000 sq.feet",
                                                      size: f5,
                                                      color: Get.theme
                                                          .primaryColor,),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Stxt(
                                                      text: "Owned it since 1990",
                                                      size: f2,
                                                      color: Get.theme
                                                          .primaryColor,),
                                                  ],
                                                ),
                                                10.verticalSpace,
                                                Stxt(
                                                  text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                                  size: f2,
                                                  color: Get.theme
                                                      .primaryColor,),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: SizedBox(
                                    height: 250.h,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16,
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Container(
                                              // height: 250.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 2),
                                                        color: Get.theme
                                                            .shadowColor,
                                                        blurRadius: 3,
                                                        spreadRadius: 2
                                                    )
                                                  ]
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    16),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Stxt(text: "2016-2021",
                                                          size: f4,
                                                          weight: FontWeight
                                                              .bold,
                                                          color: Get.theme
                                                              .primaryColor,)
                                                      ],
                                                    ),
                                                    16.verticalSpace,
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 40.h,
                                                          width: 40.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(50),
                                                              border: Border
                                                                  .all(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .primaryColor,
                                                                  width: 2)
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/picdr.png",),
                                                        ),
                                                        Space(16),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Stxt(
                                                              text: "Abdul Jabbar",
                                                              size: f4,
                                                              weight: FontWeight
                                                                  .w500,
                                                              color: Get.theme
                                                                  .primaryColor,),
                                                            Space(3),
                                                            Stxt(
                                                              text: "Chairman",
                                                              size: f1,
                                                              weight: FontWeight
                                                                  .w400,
                                                              color: Get.theme
                                                                  .primaryColor,),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    16.verticalSpace,
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 40.h,
                                                          width: 40.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(50),
                                                              border: Border
                                                                  .all(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .primaryColor,
                                                                  width: 2)
                                                          ),
                                                          child: Image.asset(
                                                            "assets/images/picdr.png",),
                                                        ),
                                                        Space(16),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Stxt(
                                                              text: "Abdul Jabbar",
                                                              size: f4,
                                                              weight: FontWeight
                                                                  .w500,
                                                              color: Get.theme
                                                                  .primaryColor,),
                                                            Space(3),
                                                            Stxt(
                                                              text: "Chairman",
                                                              size: f1,
                                                              weight: FontWeight
                                                                  .w400,
                                                              color: Get.theme
                                                                  .primaryColor,),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: SizedBox(
                                      height: 250.h,
                                      child: ListView(
                                        children: [
                                          Space(16),
                                          Container(
                                            // height: 200.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0, 2),
                                                      color: Get.theme
                                                          .shadowColor,
                                                      blurRadius: 2,
                                                      spreadRadius: 3
                                                  )
                                                ]
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/gal8.png"),
                                                  22.verticalSpace,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Stxt(text: "6000 sq.feet",
                                                        size: f5,
                                                        color: Get.theme
                                                            .primaryColor,),
                                                    ],
                                                  ),
                                                  10.verticalSpace,
                                                  Stxt(
                                                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                                    size: f2,
                                                    color: Get.theme
                                                        .primaryColor,),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )
            ]
        ),
      ),
    );
  }
}

const double borderRadius = 8.0;
final homecntrll = Get.put(HomeController());

Widget menuBar(BuildContext context) {
  return Obx(() {
    return Container(
      //width: double.infinity,
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(0.5),
        border: Border.all(color: Get.theme.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: SingleChildScrollView(
        controller: homecntrll.scrollController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Scrollbar(
          interactive: true,
          thumbVisibility: false,
          thickness: 10,
          controller: homecntrll.scrollController,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onInfo,
                child: Container(
                  width: 50,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 0)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Info",
                    style: (homecntrll.activePageIndex.value == 0) ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold) :
                    TextStyle(color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Space(16),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onFalicilities,
                child: Container(
                  width: 80,
                  //padding: EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 1)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Facilities",
                    style: (homecntrll.activePageIndex.value == 1)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //Space(16),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onGallery,
                child: Container(
                  width: 60,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 2)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Gallery",
                    style: (homecntrll.activePageIndex.value == 2)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onRenovation,
                child: Container(
                  width: 80,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 3)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Renovation",
                    style: (homecntrll.activePageIndex.value == 3)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onProperties,
                child: Container(
                  width: 80,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 4)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Properties",
                    style: (homecntrll.activePageIndex.value == 4)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onBoardMembers,
                child: Container(
                  width: 80,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 5)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Board Members",
                    style: (homecntrll.activePageIndex.value == 5)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: homecntrll.onMaqbara,
                child: Container(
                  width: 90,
                  //padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: (homecntrll.activePageIndex.value == 6)
                      ? BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius)),
                  )
                      : null,
                  child: Text(
                    "Maqbara",
                    style: (homecntrll.activePageIndex.value == 6)
                        ? TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)
                        : TextStyle(
                        color: Get.theme.colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

