import 'dart:async';
import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../model/nearbyplacesmodel.dart';

class CustomMarketInfoWindow extends StatefulWidget {
  const CustomMarketInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarketInfoWindow> createState() => _CustomMarketInfoWindowState();
}

class _CustomMarketInfoWindowState extends State<CustomMarketInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _marker = [];
  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();
  double currentLat = 0.0;
  double currentLng = 0.0;
  String type = 'mosque';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
    navigateToCurrentPosition();
    // getNearbyPlaces();
    // loadData();
  }

  loadData() {
    if (nearbyPlacesResponse.results != null) {
      for (int i = 0; i < nearbyPlacesResponse.results!.length; i++) {
        addMarkers(nearbyPlacesResponse.results![i], i);
      }
    }
  }

  void addMarkers(Results results, int i) {
    _marker.add(Marker(
      markerId: MarkerId(i.toString()),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          results.geometry!.location!.lat!, results.geometry!.location!.lng!),
    ));

    setState(() {});
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      debugPrint('error in getting current location');
      debugPrint(error.toString());
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void navigateToCurrentPosition() {
    getUserCurrentLocation().then((value) async {
      debugPrint('My current location');
      debugPrint(value.latitude.toString() + value.longitude.toString());

      _marker.add(Marker(
          markerId: MarkerId("yeiuwe87"),
          position: LatLng(value.latitude, value.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(
            title: 'My current location',
          )));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {
        currentLat = value.latitude;
        currentLng = value.longitude;
        getNearbyPlaces(type);
      });
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(79.8083, 11.9416),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "Mosque Near me"),
      
      
      // AppBar(
      //   actions: [
      //     PopupMenuButton(
      //         // add icon, by default "3 dot" icon
      //         // icon: Icon(Icons.book)
      //         itemBuilder: (context) {
      //       return [
      //         PopupMenuItem<int>(
      //           value: 0,
      //           child: Text("Restaurant"),
      //         ),
      //         PopupMenuItem<int>(
      //           value: 1,
      //           child: Text("Hospital"),
      //         ),
      //         PopupMenuItem<int>(
      //           value: 2,
      //           child: Text("Mosque"),
      //         ),
      //       ];
      //     }, onSelected: (value) {
      //       if (value == 0) {
      //         type = 'restaurant';
      //         getNearbyPlaces(type);
      //       } else if (value == 1) {
      //         type = 'hospital';
      //         getNearbyPlaces(type);
      //       } else if (value == 2) {
      //         type = 'mosque';
      //         getNearbyPlaces(type);
      //       }
      //     }),
      //   ],
      // ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(_marker),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 0,
            width: 0,
            offset: 0,
          )
        ],
      ),
    );
  }

  void getNearbyPlaces(String type) async {
    _marker.clear();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            currentLat.toString() +
            ',' +
            currentLng.toString() +
            '&radius=1500&type=mosque&key=AIzaSyBwEp25O_n2RkVfTPW8tM0mofplU0tDQtY');

    var response = await http.post(url);

    print("printing latlng");
    print(jsonDecode(response.body));
    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
    print("printing latlng");
    print(jsonDecode(response.body));

    loadData();
    setState(() {});
  }
}
