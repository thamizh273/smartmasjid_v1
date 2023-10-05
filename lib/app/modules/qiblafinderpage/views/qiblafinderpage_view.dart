import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/controllers/qiblafinderpage_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math' show pi;

class QiblaFinder extends StatefulWidget {
  const QiblaFinder({Key? key}) : super(key: key);

  @override
  State<QiblaFinder> createState() => _QiblaFinderPageState();
}

class _QiblaFinderPageState extends State<QiblaFinder> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "qibla_finder".tr),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          // image: DecorationImage(
          //     image: AssetImage("assets/svg/qublabg.png"),
          //     fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Space(50),
            FutureBuilder(
              future: _deviceSupport,
              builder: (_, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return LoadingIndicator();
                if (snapshot.hasError)
                  return Center(
                    child: Text("Error: ${snapshot.error.toString()}"),
                  );

                // if (snapshot.data!)
                return QiblahCompass();
                //  else
                // return QiblahMaps();
              },
            ),
            Space(30),
            StreamBuilder<LocationData>(
              stream: Location.instance.onLocationChanged,
              builder: (context, snap){

                if(snap.data == null) return CupertinoActivityIndicator();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                            color: Theme.of(context).primaryColor.withOpacity(0.3)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Latitude :', style: TextStyle(color:  Get.theme.hoverColor, fontWeight: FontWeight.bold),),
                              const Space(8),
                              Text('${snap.data?.latitude}', style: TextStyle( fontWeight: FontWeight.normal),),
                            ],
                          ),
                        ),
                      ).animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                          .shimmer(
                          duration: Duration(
                            seconds: 6,
                          ),color: Colors.white.withOpacity(0.5)),
                    ),
                    //const Space(8),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                            color: Theme.of(context).primaryColor.withOpacity(0.3)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Longitude :', style: TextStyle(color:  Get.theme.hoverColor, fontWeight: FontWeight.bold),),
                              const Space(8),
                              Text('${snap.data?.longitude}', style: TextStyle(fontWeight: FontWeight.normal),),
                            ],
                          ),
                        ),
                      ).animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                          .shimmer(
                          duration: Duration(
                            seconds: 6,
                          ),color: Colors.white.withOpacity(0.5)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

    );
  }

// @override
// Widget build(BuildContext context) {
//   final size = MediaQuery.of(context).size.width * 0.85;
//   return Scaffold(
//     appBar: CustomAppbar(tittle: 'Qibla Finder',),
//     body: Column(
//       children: [
//         Space(50),
//         Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             // image: DecorationImage(
//             //   image: AssetImage('assets/rasters/compass.png')
//             // ),
//               color: Theme.of(context).cardColor,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 5, offset: Offset(0, 4))
//               ]
//           ),
//           alignment: Alignment.center,
//           child: StreamBuilder(
//             stream: FlutterQiblah.qiblahStream,
//             builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CupertinoActivityIndicator();
//               }
//
//               final qiblahDirection = snapshot.data!;
//
//               return Stack(
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   Transform.rotate(
//
//                     angle: (qiblahDirection.direction * (pi / 180) * -1),
//                     // duration: Duration(milliseconds: 1000),
//                     // turns: (qiblahDirection.direction * (pi / (180) ) * -1 ) * 2 *  pi,
//                     child: Image.asset('assets/images/compass.png', width: size, height: size,),
//                   ),
//                   Transform.rotate(
//                     angle: (qiblahDirection.qiblah * (pi / 180) * -1),
//                     alignment: Alignment.center,
//                     child: Image.asset('assets/images/needle.png', height: size * 0.7,),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 500),
//                     child: Center(
//                       child: Text(
//                         "${qiblahDirection.offset.toStringAsFixed(3)}°",
//                         style:  TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontFamily: 'Roboto',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           // child: StreamBuilder<MagnetometerEvent>(
//           //     key: ValueKey('needles'),
//           //   stream: magnetometerEvents,
//           //   builder: (context, snapshot) {
//           //     final data = snapshot.data;
//           //     if(data == null) return CupertinoActivityIndicator();
//           //     final angel = atan2(data.y, data.x);
//           //     //print(angel);
//           //     return  RotationTransition(
//           //         key: ValueKey('needler'),
//           //     turns:  AlwaysStoppedAnimation(-(angel * 0.160)),
//           //         child: Transform.scale(
//           //             key: ValueKey('needle'),
//           //             scaleY: -1,
//           //             child: Image.asset('assets/rasters/needle.png', height: size * 0.7,))
//           //     );
//           //   }
//           // ),
//         ),
//         Spacer(),
//         StreamBuilder<LocationData>(
//           stream: Location.instance.onLocationChanged,
//           builder: (context, snap){
//
//             if(snap.data!.longitude == null) return CupertinoActivityIndicator();
//             return Column(
//               children: [
//                 CustomCard(
//                   margin: EdgeInsets.symmetric(horizontal: 16),
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(
//                     children: [
//                       Text('Latitude :', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
//                       const Space(8),
//                       Text('${snap.data?.latitude}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
//                     ],
//                   ), border: true, shadow: false,),
//                 const Space(16),
//                 CustomCard(
//                   margin: EdgeInsets.symmetric(horizontal: 16),
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Row(
//                     children: [
//                       Text('Longitude :', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
//                       const Space(8),
//                       Text('${snap.data?.longitude}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
//                     ],
//                   ), border: true, shadow: false,),
//               ],
//             );
//           },
//         ),
//
//         Spacer(),
//         const Space(56),
//       ],
//     ),
//   );
// }
//
// @override
// void initState() {
//   super.initState();
// }
}

class QiblahCompass extends StatefulWidget {
  @override
  _QiblahCompassState createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();

  Stream<LocationStatus> get stream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
            // case GeolocationStatus.unknown:
            //   return LocationErrorWidget(
            //     error: "Unknown Location service error",
            //     callback: _checkLocationStatus,
            //   );
              default:
                return const SizedBox();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }
}

class QiblahCompassWidget extends StatefulWidget {
  @override
  State<QiblahCompassWidget> createState() => _QiblahCompassWidgetState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahCompassWidgetState extends State<QiblahCompassWidget> with SingleTickerProviderStateMixin {
  final _compassSvg = Image.asset('assets/images/com.png');

  final _needleSvg = Image.asset(
    "assets/images/finalneedle.png",
    fit: BoxFit.contain,
    height: 200,
    alignment: Alignment.centerRight,
  );

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(alignment: Alignment.center, child: const CircularProgressIndicator(color: Colors.white,));
        }

        final qiblahDirection = snapshot.data;
        animation = Tween(begin: begin, end: (qiblahDirection!.qiblah * (pi / 180) * -1)).animate(_animationController!);
        begin = (qiblahDirection.qiblah * (pi / 180) * -1);
        _animationController!.forward(from: 0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedBuilder(animation: animation!,
                  builder: (context, child) => Transform.rotate(
                      angle: animation!.value,
                      child: _compassSvg),
                ),
                AnimatedBuilder(animation: animation!,
                  builder: (context, child) => Transform.rotate(
                      angle: animation!.value,
                      child: _needleSvg),
                )
              ],
            ),
            10.verticalSpace,
            Stxt(text: "Angle ${qiblahDirection.offset* (pi / 180) * -1}°",
              size: f2,
              weight: FontWeight.w500,),
            // Obx(() {
            //
            //   return Stxt(text: "${qiblahDirection..toStringAsFixed(3)}°",
            //     size: f2,
            //     weight: FontWeight.w500,);
            // }),
            // Obx(() {
            //   return Stxt(text: "${qiblahDirection.long.value.toStringAsFixed(3)}°",
            //     size: f2,
            //     weight: FontWeight.w500,);
            // }),

          ],
        );
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Center(
        child: CircularProgressIndicator.adaptive(),
      );
}

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Color(0xffb00020);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error!,
              style: TextStyle(color: errorColor, fontWeight: FontWeight.bold),
            ),
            box,
            ElevatedButton(
              child: Text("Retry"),
              onPressed: () {
                if (callback != null) callback!();
              },
            )
          ],
        ),
      ),
    );
  }
}

// class QiblahMaps extends StatefulWidget {
//   static final meccaLatLong = const LatLng(21.422487, 39.826206);
//   static final meccaMarker = Marker(
//     markerId: MarkerId("mecca"),
//     position: meccaLatLong,
//     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//     draggable: false,
//   );
//
//   @override
//   _QiblahMapsState createState() => _QiblahMapsState();
// }
//
// class _QiblahMapsState extends State<QiblahMaps> {
//   final Completer<GoogleMapController> _controller = Completer();
//   LatLng position = LatLng(36.800636, 10.180358);
//
//   late final _future = _checkLocationStatus();
//   final _positionStream = StreamController<LatLng>.broadcast();
//
//   @override
//   void dispose() {
//     _positionStream.close();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder(
//         future: _future,
//         builder: (_, AsyncSnapshot<Position?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return LoadingIndicator();
//           if (snapshot.hasError)
//             return LocationErrorWidget(
//               error: snapshot.error.toString(),
//             );
//
//           if (snapshot.data != null) {
//             final loc =
//             LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
//             position = loc;
//
//             setState(() {
//             });
//           } else
//             _positionStream.sink.add(position);
//
//           return StreamBuilder(
//             stream: _positionStream.stream,
//             builder: (_, AsyncSnapshot<LatLng> snapshot) =>
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   zoomGesturesEnabled: true,
//                   compassEnabled: true,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: true,
//                   initialCameraPosition: CameraPosition(
//                     target: position,
//                     zoom: 11,
//                   ),
//                   markers: Set<Marker>.of(
//                     <Marker>[
//                       QiblahMaps.meccaMarker,
//                       Marker(
//                         draggable: true,
//                         markerId: MarkerId('Marker'),
//                         position: position,
//                         icon: BitmapDescriptor.defaultMarker,
//                         onTap: _updateCamera,
//                         onDragEnd: (LatLng value) {
//                           position = value;
//                           _positionStream.sink.add(value);
//                         },
//                         zIndex: 5,
//                       ),
//                     ],
//                   ),
//                   circles: Set<Circle>.of(
//                     [
//                       Circle(
//                         circleId: CircleId("Circle"),
//                         radius: 10,
//                         center: position,
//                         fillColor:
//                         Theme
//                             .of(context)
//                             .primaryColorLight
//                             .withAlpha(100),
//                         strokeWidth: 1,
//                         strokeColor:
//                         Theme
//                             .of(context)
//                             .primaryColorDark
//                             .withAlpha(100),
//                         zIndex: 3,
//                       )
//                     ],
//                   ),
//                   polylines: Set<Polyline>.of(
//                     [
//                       Polyline(
//                         polylineId: PolylineId("Line"),
//                         points: [position, QiblahMaps.meccaLatLong],
//                         color: Theme
//                             .of(context)
//                             .primaryColor,
//                         width: 5,
//                         zIndex: 4,
//                       )
//                     ],
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<Position?> _checkLocationStatus() async {
//     final locationStatus = await FlutterQiblah.checkLocationStatus();
//     if (locationStatus.enabled) {
//       return await Geolocator.getCurrentPosition();
//     }
//     return null;
//   }
//
//   void _updateCamera() async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newLatLngZoom(position, 20));
//   }
// }
