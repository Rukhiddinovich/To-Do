import 'package:flutter/material.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/ui/home/add_screen.dart';
import 'package:todo_task/ui/home/detail_screen.dart';
import 'package:todo_task/ui/home/home_screen.dart';

class RouteNames {
  static const String homeScreen = "/";
  static const String detailScreen = "/detail_screen";
  static const String addScreen = "/add_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.detailScreen:
        return MaterialPageRoute(builder: (context) =>  DetailScreen(toDoModel: settings.arguments as ToDoModel,));
      case RouteNames.addScreen:
        return MaterialPageRoute(builder: (context) => const AddEventScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not available"),
            ),
          ),
        );
    }
  }
}