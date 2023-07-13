import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../weatherlocation/views/weatherlocation_view.dart';



class SingleweatherView extends StatelessWidget {

  SingleweatherView();
  @override
  Widget build(BuildContext context) {
    var index=0;
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150,),
                    Text(locationList[index].city,style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    ),
                    SizedBox(height: 5,),
                    Text(locationList[index].dateTime,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locationList[index].temperature,style: TextStyle(
                      fontSize: 85,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          locationList[index].iconUrl,
                          width: 34,
                          height: 34,
                          color: Colors.white,
                        ),
                        Text(locationList[index].WeatherType,style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Wind',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text(locationList[index].wind.toString(),style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text('Km/h',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: Colors.white60,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            color: Colors.greenAccent,
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Rain',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text(locationList[index].rain.toString(),style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text('%',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: Colors.white60,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            color: Colors.redAccent,
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Humidity',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text(locationList[index].humidity.toString(),style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Text('%',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 5,
                            width: 50,
                            color: Colors.white60,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            color: Colors.redAccent,
                          )
                        ],
                      )
                    ],
                  ),

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
