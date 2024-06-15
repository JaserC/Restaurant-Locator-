import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';

class ListItemWidget extends StatelessWidget {
  final String name;
  final double distance;
  final String cuisine;
  final bool hasPatio;

  const ListItemWidget({
    Key? key,
    required this.name,
    required this.distance,
    required this.cuisine,
    required this.hasPatio
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double km = distance / 1000.0;
    String iconFilePath = findIcon(cuisine);
    if (hasPatio){
      return Card(
        // ignore: sort_child_properties_last
        child: ListTile(
          leading: Semantics(
            child: ClipOval(
              child: Image.asset(
                iconFilePath, 
                width: 48, 
                height: 48, 
              ),
            ),
            label: cuisine,
          ),
          title: Semantics(
            child: Text(
              name, 
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
            label: name,
          ), // Display name
          subtitle: Semantics(
            child: Text(
              '${km.toStringAsFixed(1)} km',
              style: TextStyle(color: Color(0xFF9E9E9E)),
            ),
            label: '${km} kilometers',
          ), // Display distance
          trailing: Semantics(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
              child: Image.asset(
                'assets/patio.png', // Replace 'my_image.png' with the path to your image
                width: 48, // Adjust width as needed
                height: 48, // Adjust height as needed
              ),
            ),
            label: "Patio",
          ),
        ),
        color: Color(0xFF323232),
      );
    }
    else{
      return Card(
        // ignore: sort_child_properties_last
        child: ListTile(
          leading: Semantics(
            child: ClipOval(
              child: Image.asset(
                iconFilePath, 
                width: 48, 
                height: 48,
              ),
            ),
            label: cuisine,
          ),
          title: Semantics(
            child: Text(
              name, 
              style: TextStyle(color: Colors.white),
            ),
            label: name,
          ), // Display name
          subtitle: Semantics(
            child: Text(
              '${km.toStringAsFixed(1)} km',
              style: TextStyle(color: Colors.grey),
            ),
            label: '${km} kilometers',
          ), // Display distance
        ),
        color: Color.fromARGB(255, 50, 50, 50),
      );
    }
  }

  String findIcon(String cuisine){
    return switch(cuisine){
      "Japanese" => 'assets/japanese.png',
      "Vietnamese" => 'assets/asian.png',
      "Chinese" => 'assets/asian.png',
      "Thai" => 'assets/asian.png',

      "Bakery" => 'assets/bakery.png',
      "Cafe" => 'assets/cafe.png',
      "Burger" => 'assets/burger.png',
  
      "Pizza" => 'assets/pizza.png',
      "Mexican" => 'assets/mexican.png',
      "Italian" => 'assets/pasta.png',
      "Chicken" => 'assets/chicken.png',
      "Bar" => 'assets/bar.png',
      "Breakfast" => 'assets/breakfast.png',
      _ => ''
    };
  }
}
