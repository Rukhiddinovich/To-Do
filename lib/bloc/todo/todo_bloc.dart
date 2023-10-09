import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_task/data/local/db/local_database.dart';
import 'package:todo_task/data/model/form_status.dart';
import 'package:todo_task/data/model/todo_model.dart';
import 'package:todo_task/utils/constants/constants.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc()
      : super(
          const ToDoState(
            status: FormStatus.pure,
            statusText: "",
            events: [],
          ),
        ) {
    on<AddToDo>(_addToDo);
    on<GeToDo>(_getToDo);
    on<DeleteTodo>(_deleteTodo);
  }


  List<ToDoModel> newEvents=[];
  _addToDo(AddToDo event, Emitter<ToDoState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.todoAdd,
      ),
    );
    await LocalDatabase.insertTodo(event.newEvents);
    emit(
      state.copyWith(
          statusText: StatusTextConstants.todoAdd,
          status: FormStatus.success,
          events: [...state.events, event.newEvents]),
    );
  }

  _getToDo(GeToDo event, Emitter<ToDoState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.getAllTodo,
      ),
    );
   newEvents = await LocalDatabase.getAllTodos();
    emit(
      state.copyWith(
        statusText: StatusTextConstants.getAllTodo,
        status: FormStatus.success,
        events: newEvents,
      ),
    );
  }

  _deleteTodo(DeleteTodo event, Emitter<ToDoState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "Deleting Todo...",
      ),
    );
    LocalDatabase.deleteTodo(event.toDoId);
    newEvents = await LocalDatabase.getAllTodos();
    emit(
      state.copyWith(
        status: FormStatus.success,
        statusText: "Todo deleted !!!",
        events: newEvents
      ),
    );
  }
}
