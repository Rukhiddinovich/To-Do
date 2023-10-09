part of 'todo_bloc.dart';

@immutable
abstract class ToDoEvent extends Equatable {}

class AddToDo extends ToDoEvent {
  final ToDoModel newEvents;

  AddToDo({required this.newEvents});

  @override
  List<Object?> get props => [newEvents];
}

class GeToDo extends ToDoEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTodo extends ToDoEvent {
  final int toDoId;

  DeleteTodo({required this.toDoId});

  @override
  List<Object?> get props => [toDoId];
}
