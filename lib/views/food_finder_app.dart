import 'dart:math';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/views/list_tile.dart';
import 'package:provider/provider.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:food_finder/weather_conditions.dart';
import 'dart:async';




class FoodFinderApp extends StatefulWidget {
  final VenuesDB venues;

  const FoodFinderApp({super.key, required this.venues});

  @override
  State<FoodFinderApp> createState() => _FoodFinderAppState();
}



class _FoodFinderAppState extends State<FoodFinderApp> {
  late final Timer _checkerTimer;
  late final WeatherChecker _weatherChecker;

  @override
  initState(){
    super.initState();

    final singleUseWeatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    _weatherChecker = WeatherChecker(singleUseWeatherProvider);
    _checkerTimer = Timer.periodic(Duration(seconds: 60), (_checkerTimer) => _weatherChecker.fetchAndUpdateCurrentSeattleWeather());
  
    // TODO(you): Initialize the _checkerTimer and _weatherChecker here
    // ---> Your code from the Weather app may be helpful to refer to 

    // This way we don't have to wait a minute from after the app starts to first attempt a weather check.
    _weatherChecker.fetchAndUpdateCurrentSeattleWeather();
  }

  @override 
  dispose(){
    // TODO(you):  Cancel our timer when we are no longer needed so we don't leak
    _checkerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: SafeArea(
            child: Scaffold(
              // This is how you can consume from two providers at once without 
              // needing to nest Consumers inside each other 
              body: Consumer2<PositionProvider, WeatherProvider>( 
                builder: (context, positionProvider, weatherProvider, child) {
                  List<Venue> sortedVenues = widget.venues.nearestTo(max: 20, latitude: positionProvider.latitude, longitude: positionProvider.longitude);

                  //Additional Sort
                  if(_weatherChecker.weatherProvider.condition == WeatherCondition.sunny){
                    sortedVenues.sort((venue1, venue2) {
                      if (venue2.hasPatio && !venue1.hasPatio) { //If venue 2 has the patio and venue1 doesn't, return 1
                        return 1;
                      } else if (!venue2.hasPatio && venue1.hasPatio) { //If it's the other way around, return -1
                        return -1;
                      } else { // If hasPatio is the same (both have or don't have), sort by distance
                        double distance1 = venue1.distanceInMeters(latitude: positionProvider.latitude, longitude: positionProvider.longitude);
                        double distance2 = venue2.distanceInMeters(latitude: positionProvider.latitude, longitude: positionProvider.longitude);
                        return distance1.compareTo(distance2);
                      }
                    });
                  }

                  if (positionProvider.positionKnown){
                    _weatherChecker.updateLocation(positionProvider.latitude, positionProvider.longitude);

                    return Container(
                      child: Column(
                        children: [
                          // Header widget goes here
                          Semantics(
                            child: GradientText("Food Finder", 
                              style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.w800),
                              colors: [
                                Color(0xFF40C9FF),
                                Color(0xFFE81CFF)
                              ],
                              ), 
                            label: "Food Finder"),
                          // ListView with sorted venues
                          Expanded(
                            child: ListView(
                              children: sortedVenues.map((venue) {
                                double distance = venue.distanceInMeters(latitude: positionProvider.latitude, longitude: positionProvider.longitude);
                                return ListItemWidget(name: venue.name, distance: distance, cuisine: venue.cuisine, hasPatio: venue.hasPatio);
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.black,
                    );
                  }

                  

                  return Text("Loading");
                  
                  // TODO(you): If position is known, call weatherChecker.updateLocation with our current position

                  // TODO(you): Remove this placeholder, and add your views here.
                  // Keep this as tidy and readable as you can by, relying on custom Widgets you define 
                  // to create the view tree. 
                  // VSCode makes this easy... check out the Extract Widget feature described here: 
                  //  https://medium.com/flutter-community/flutter-visual-studio-code-shortcuts-for-fast-and-efficient-development-7235bc6c3b7d
                  // Please place each custom Widget in their own file in the views/ directory.
                  
                } 
              ),
            ),
          )
    );
  }
}
