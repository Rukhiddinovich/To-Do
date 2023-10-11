import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_task/data/model/todo_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todos.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    // const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${ToDoModelFields.eventTable} (
    ${ToDoModelFields.id} $idType,
    ${ToDoModelFields.eventName} $textType,
    ${ToDoModelFields.eventDescription} $textType,
    ${ToDoModelFields.eventLocation} $textType,
    ${ToDoModelFields.eventColor} $textType,
    ${ToDoModelFields.eventTime} $textType,
    ${ToDoModelFields.day} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<ToDoModel> insertTodo(ToDoModel toDoModel) async {
    final db = await getInstance.database;
    final int id =
        await db.insert(ToDoModelFields.eventTable, toDoModel.toJson());
    return toDoModel.copyWith(id: id);
  }

  static Future<List<ToDoModel>> getAllTodos() async {
    final db = await getInstance.database;
    List<ToDoModel> allToDos = (await db.query(ToDoModelFields.eventTable))
        .map((e) => ToDoModel.fromJson(e))
        .toList();
    return allToDos;
  }

  static updateTodo({required ToDoModel toDoModel}) async {
    final db = await getInstance.database;
    db.update(
      ToDoModelFields.eventTable,
      toDoModel.toJson(),
      where: "${ToDoModelFields.id} = ?",
      whereArgs: [toDoModel.id],
    );
  }

  static Future<int> deleteTodo(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      ToDoModelFields.eventTable,
      where: "${ToDoModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }
}
