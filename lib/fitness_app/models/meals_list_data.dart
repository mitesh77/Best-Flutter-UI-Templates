import 'package:flutter/material.dart';

class MealsListData {
  MealsListData({
    required this.meals,
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = Colors.grey,
    this.endColor = Colors.grey,
    this.kcal = 0,
  });

  String imagePath;
  String titleTxt;
  Color startColor;
  Color endColor;
  List<String> meals;
  int kcal;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Breakfast',
      kcal: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: const Color(0xFFFA7D82),
      endColor: const Color(0xFFFFB295),
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Lunch',
      kcal: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: const Color(0xFF738AE6),
      endColor: const Color(0xFF5C5EDD),
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Snack',
      meals: <String>['Recommend:', '800 kcal'],
      startColor: const Color(0xFFFE95B6),
      endColor: const Color(0xFFFF5287),
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      meals: <String>['Recommend:', '703 kcal'],
      startColor: const Color(0xFF6F72CA),
      endColor: const Color(0xFF1E1466),
    ),
  ];
}
