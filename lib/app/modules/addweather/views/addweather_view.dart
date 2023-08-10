import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/views/weatherpage_view.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../controllers/addweather_controller.dart';

class AddweatherView extends GetView<AddweatherController> {
   AddweatherView({Key? key}) : super(key: key);
  final AddweatherController c = Get.put(AddweatherController());

   List<Weather> weatherList = [
     Weather(location: "Pondicherry", temp: "28\u00B0"),
     Weather(location: "Chennai", temp: "30\u00B0"),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 30.0)
              )
          ),
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop(MaterialPageRoute(builder: (_) => WeatherpageView()));
              },
              child: SvgPicture.asset("assets/svg/backnew.svg", fit: BoxFit.scaleDown)),
          title: Text("Manage Cities", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 60,
                // decoration: BoxDecoration(
                //     gradient:LinearGradient(colors: [
                //       hexStringToColor("818F93"),
                //       hexStringToColor("3B555C"),
                //     ]),
                //     borderRadius: BorderRadius.circular(8)
                // ),
                child: TextField(
                  focusNode: c.searchFocusNode,
                  autofocus: false,

                  // textInputAction: TextInputAction.search,
                  controller: c.textEditingController,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                  // textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    // setState(() {
                    //   searchQuery = value;
                    // });
                    // if (value.isEmpty) {
                    //   _textEditingController.clear();
                    //   FocusScope.of(context).unfocus();
                    // }
                  },

                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15),
                    hintText: 'Enter Location',
                    // label: Text("Search by Masjid Name", style: TextStyle(fontSize: 12),),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Change the border color for focused state
                        width: 2.0, // Change the border width for focused state
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 1),
                      child: IconButton(onPressed: (){
                        FocusScope.of(context).requestFocus(c.searchFocusNode);
                      }, icon: Icon(Icons.search, size: 25, ),),
                    ),
                  ),
                  // onSubmitted: (value) {
                  //   if (value.isEmpty) {
                  //     _textEditingController.clear();
                  //     FocusScope.of(context).unfocus();
                  //   }
                  // },
                ),
              ),
              Space(16),
              Expanded(
                child: ListView.builder(
                    itemCount: weatherList.length,
                    itemBuilder: (context, index){
                      Weather weather = weatherList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient:LinearGradient(colors: [
                                  hexStringToColor("2B7087"),
                                  hexStringToColor("53899B"),
                                ]),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            height: 80.h,
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8),
                            //     color: Theme.of(context).primaryColor.withOpacity(0.6)
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Text("${weather.location}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
                                      Icon(Icons.location_on, size: 25, color: Colors.white,),
                                      Spacer(),
                                      Text("${weather.temp}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.white),)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Weather{
  String? location;
  String? temp;

  Weather({
    this.location,
    this.temp,
  });
}