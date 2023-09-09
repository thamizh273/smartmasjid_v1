import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MasjidnearmeView extends StatefulWidget {
  const MasjidnearmeView({Key? key}) : super(key: key);

  @override
  State<MasjidnearmeView> createState() => _MasjidnearmeViewState();
}

class _MasjidnearmeViewState extends State<MasjidnearmeView> {

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _marker = [];
  List<Marker> _list =  [
    Marker(markerId: MarkerId('1'),
        position: LatLng(79.8083, -122.085749655962),
        infoWindow: InfoWindow(
            title: 'My Position'
        )
    ),

    Marker(markerId: MarkerId('2'),
        position: LatLng(79.8083, -11.9416),
        infoWindow: InfoWindow(
            title: 'Second Position'
        )
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    navigateToCurrentPosition();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(79.8083, 11.9416),
    zoom: 14.4746,
  );

  Future<Position> getUserCurrentLocation() async
  {
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      debugPrint('error in getting current location');
      debugPrint(error.toString());
    });


    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void navigateToCurrentPosition()
  {
    getUserCurrentLocation().then((value)async {
      debugPrint('My current location');
      debugPrint(value.latitude.toString() + value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId("6"),
          position: LatLng(value.latitude,value.longitude),
          infoWindow: InfoWindow(
            title: 'My current location',

          )));

      CameraPosition cameraPosition = CameraPosition(
        target:  LatLng(value.latitude,value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await  _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentLocation().then((value)async {
            debugPrint('My current location');
            debugPrint(value.latitude.toString() + value.longitude.toString());

            _marker.add(Marker(
                markerId: MarkerId("6"),
                position: LatLng(value.latitude,value.longitude),
                infoWindow: InfoWindow(
                  title: 'My current location',

                )));

            CameraPosition cameraPosition = CameraPosition(
              target:  LatLng(value.latitude,value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await  _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {

            });

          });
        },
        child: Icon(Icons.add_location_rounded,size: 30,),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),

      ),
    );
  }
}

