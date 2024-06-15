import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class PositionProvider extends ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;

  bool positionKnown = false;
  var _positionTimer;

  PositionProvider() {
    // Setup a timer to periodically check location
    _positionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      updatePosition();
    });
  }

  updatePosition() async{
    _determinePosition()
    .then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
      positionKnown = true;
      notifyListeners();
    })
    .onError((error, stackTrace) {
      positionKnown = false;
      notifyListeners();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

