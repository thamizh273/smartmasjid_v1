import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/views/weatherpage_view.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../routes/export.dart';
import '../controllers/weatherdetail_controller.dart';

class WeatherdetailView extends GetView<WeatherdetailController> {
   WeatherdetailView({Key? key}) : super(key: key);
  final WeatherdetailController c = Get.put(WeatherdetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 330.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 6,
                        offset: Offset(0,4),
                        color: Colors.grey.shade400
                    )
                  ],
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(32), bottomLeft: Radius.circular(32)),
                  gradient: LinearGradient(colors: [
                    hexStringToColor("53899B"),
                    hexStringToColor("23687F"),
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop(MaterialPageRoute(builder: (_) => WeatherpageView()));
                            },
                              child: SvgPicture.asset("assets/svg/backnew.svg")),
                          Space(16),
                          Stxt(text: "Weather(10 days)", size: f5, weight: FontWeight.w600, color: Colors.white,),
                        ],
                      ),
                      Space(16),
                      Row(
                        children: [
                          Image.asset("assets/images/weather.png", width: 200,),
                          Text("32\u00B0", style: TextStyle(fontSize: 100, color: Colors.white),),
                        ],
                      ),
                      Stxt(text: "Partly Sunny", size: f4 ,color: Colors.white,),
                      Space(4),
                      Stxt(text: "Friday, 14 July (26 Dhuʻl-Hijjah, 1444 AH)", size: f2, color: Colors.white,),
                      Space(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset("assets/svg/wind.svg"),
                              Space(8),
                              Stxt(text: "10 Km/h", size: f3, color: Colors.white,),
                              Space(4),
                              Stxt(text: "Wind", size: f2, color: Colors.white.withOpacity(0.4),),
                            ],
                          ),
                          Column(
                            children: [
                              SvgPicture.asset("assets/svg/rain.svg"),
                              Space(8),
                              Stxt(text: "2%", size: f3, color: Colors.white,),
                              Space(4),
                              Stxt(text: "Chance of Rain", size: f2, color: Colors.white.withOpacity(0.4),),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("assets/images/humidity.png", width: 15,),
                              Space(8),
                              Stxt(text: "10%", size: f3, color: Colors.white,),
                              Space(4),
                              Stxt(text: "Humidity", size: f2, color: Colors.white.withOpacity(0.4),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
            Space(8),
            SizedBox(
              child: GridView.builder(
                controller: c.scrollController,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                      Orientation.landscape ? 3: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: (2 / 1),
                ),
                itemBuilder: (BuildContext context, int index) {
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                color: Colors.grey.shade400
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Stxt(text: "Sat", size: f3),
                                Image.asset("assets/images/thunder.png", width: 40,)
                              ],
                            ),
                            Space(8),
                            Column(
                              children: [
                                Text("23\u00B0", style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),),
                                Stxt(text: "ThunderStorm", size: f2)
                              ],
                            )
                          ],
                        ),
                      ),
                  ),
                   );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
