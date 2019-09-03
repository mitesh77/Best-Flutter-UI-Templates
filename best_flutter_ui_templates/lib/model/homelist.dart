import 'package:best_flutter_ui_templates/designCourse/homeDesignCourse.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  Widget navigateScreen;
  String imagePath;

  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  static List<HomeList> homeList = [
    HomeList(
      imagePath: "assets/design_course/design_course.png",
      navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
