import 'dart:convert';

import 'package:food_finder/models/venue.dart';


class VenuesDB{
  final List<Venue> _venues;

  List<Venue> get all{
    return List<Venue>.from(_venues, growable: false);
  }

  List<Venue> nearestTo({int max = 999, required double latitude, required double longitude}){
    _venues.sort(((a, b) => a.distanceFrom(userLatitude: latitude, userLongitude: longitude).compareTo(b.distanceFrom(userLatitude: latitude, userLongitude: longitude))));
    return _venues.take(max).toList(growable: false);
  }

  // topRated({int max = 999, required double rating}){

  // }

  // TODO(you): Add nearestTo method here


  VenuesDB.initializeFromJson(String jsonString) : _venues = _decodeVenueListJson(jsonString);

  static List<Venue> _decodeVenueListJson(String jsonString){
    final listMap = jsonDecode(jsonString);
    final theList = (listMap as List).map( (element) {
      return Venue.fromJson(element);
    }).toList();
    return theList;
  }

}