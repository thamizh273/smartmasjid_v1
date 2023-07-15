import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import '../../../../widgets/custom_card.dart';
import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';


class QiblaFinder extends StatefulWidget {
  const QiblaFinder({Key? key}) : super(key: key);

  @override
  State<QiblaFinder> createState() => _QiblaFinderState();
}

class _QiblaFinderState extends State<QiblaFinder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.85;
    return Scaffold(
      appBar: CustomAppbar(tittle: 'Qibla Finder',),

      body: Column(
        children: [
          const Space(56),
          const Spacer(),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/rasters/compass.png')
              // ),
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 5, offset: Offset(0, 4))
                ]
            ),
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: FlutterQiblah.qiblahStream,
              builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }

                final qiblahDirection = snapshot.data!;

                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Transform.rotate(

                      angle: (qiblahDirection.direction * (pi / 180) * -1),
                      // duration: Duration(milliseconds: 1000),
                      // turns: (qiblahDirection.direction * (pi / (180) ) * -1 ) * 2 *  pi,
                      child: Image.asset('assets/images/compass.png', width: size, height: size, ),
                    ),
                    Transform.rotate(
                      angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/needle.png', height: size * 0.7,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 500),
                      child: Center(
                        child: Text(
                          "${qiblahDirection.offset.toStringAsFixed(3)}°",
                          style:  TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            // child: StreamBuilder<MagnetometerEvent>(
            //     key: ValueKey('needles'),
            //   stream: magnetometerEvents,
            //   builder: (context, snapshot) {
            //     final data = snapshot.data;
            //     if(data == null) return CupertinoActivityIndicator();
            //     final angel = atan2(data.y, data.x);
            //     //print(angel);
            //     return  RotationTransition(
            //         key: ValueKey('needler'),
            //     turns:  AlwaysStoppedAnimation(-(angel * 0.160)),
            //         child: Transform.scale(
            //             key: ValueKey('needle'),
            //             scaleY: -1,
            //             child: Image.asset('assets/rasters/needle.png', height: size * 0.7,))
            //     );
            //   }
            // ),
          ),
          Spacer(),
          StreamBuilder<LocationData>(
            stream: Location.instance.onLocationChanged,
            builder: (context, snap){

              if(snap.data?.longitude == null) return CupertinoActivityIndicator();
              return Column(
                children: [
                  CustomCard(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: true, shadow: false,
                    child: Row(
                      children: [
                         Text('Latitude :', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                        const Space(8),
                        Text('${snap.data?.latitude}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                      ],
                    ),),
                  const Space(16),
                  CustomCard(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: true, shadow: false,
                    child: Row(
                      children: [
                        Text('Longitude :', style: TextStyle(color:Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                        const Space(8),
                        Text('${snap.data?.longitude}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                      ],
                    ),),
                ],
              );
            },
          ),

          const Spacer(),
          const Space(56),
        ],
      ),
    );
  }
}
