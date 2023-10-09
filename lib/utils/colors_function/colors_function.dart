import 'package:todo_task/data/local/db/local_database.dart';
import 'package:todo_task/data/model/todo_model.dart';

Future<List<ToDoModel>> getEventFromLocalDatabase() async {
  return await LocalDatabase.getAllTodos();
}

bool blue(String day, List<ToDoModel> events) {
  for (int i = 0; i < events.length; i++) {
    if (day == events[i].day && events[i].eventColor == "Blue") {
      return true;
    }
  }
  return false;
}

bool red(String day, List<ToDoModel> events) {
  for (int i = 0; i < events.length; i++) {
    if (day == events[i].day && events[i].eventColor == "Red") {
      return true;
    }
  }
  return false;
}

bool orange(String day, List<ToDoModel> events) {
  for (int i = 0; i < events.length; i++) {
    if (day == events[i].day && events[i].eventColor == "Orange") {
      return true;
    }
  }
  return false;
}
