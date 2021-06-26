import 'package:flutter/widgets.dart';

import '../design_course/home_design_course.dart';
import '../fitness_app/fitness_app_home_screen.dart';
import '../hotel_booking/hotel_home_screen.dart';

class HomeList {
  HomeList({required this.navigateScreen, required this.imagePath});

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = <HomeList>[
    HomeList(
      navigateScreen: const HotelHomeScreen(),
      imagePath: 'assets/hotel/hotel_booking.png',
    ),
    HomeList(
      navigateScreen: const FitnessAppHomeScreen(),
      imagePath: 'assets/fitness_app/fitness_app.png',
    ),
    HomeList(
      navigateScreen: const DesignCourseHomeScreen(),
      imagePath: 'assets/design_course/design_course.png',
    ),
  ];
}
