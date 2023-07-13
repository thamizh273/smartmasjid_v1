import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/addweather/views/addweather_view.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/app/modules/singleweather/views/singleweather_view.dart';
import 'package:smartmasjid_v1/app/modules/sliderdot/views/sliderdot_view.dart';

import '../../weatherlocation/views/weatherlocation_view.dart';
import '../controllers/weatherpage_controller.dart';

class WeatherpageView extends GetView<WeatherpageController> {
  RxInt _currentPage = 0.obs;
  void onPageChanged(int index) {
    _currentPage.value = index;
  }

   WeatherpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(locationList[controller.currentPage].WeatherType == 'Cloudy'){
      controller.bgImg = 'assets/svg/cloudynew.jpg';
    } else if(locationList[controller.currentPage].WeatherType == 'Night') {
      controller.bgImg = 'assets/svg/nightback.jpg';
    }
    else if(locationList[controller.currentPage].WeatherType == 'Rainy') {
      controller.bgImg = 'assets/svg/rainynew.jpg';
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Weather',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
            },
            child: SvgPicture.asset("assets/svg/backnew.svg", fit: BoxFit.scaleDown)),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddweatherView()));
          }, icon: Icon(Icons.add, size: 30, color: Colors.white,))
        ],
      ),
      body: Container(
        child: Stack(
          children:[
            Image.asset(
              controller.bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(top: 140, left: 15),
              child: Row(
                children: [
                  for(int i = 0; i<locationList.length; i++)
                    if(i == controller.currentPage)
                      SliderdotView(true)
                    else
                      SliderdotView(false)
                ],
              ),
            ),
            PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: onPageChanged,
                itemCount: locationList.length,
                itemBuilder: (context, index){
                  return SingleweatherView();
                }
            )

          ],
        ),
      ),
    );
  }
}


