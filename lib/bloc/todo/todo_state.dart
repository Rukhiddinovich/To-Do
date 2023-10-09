part of 'todo_bloc.dart';

class ToDoState extends Equatable {
  final FormStatus status;
  final List<ToDoModel> events;
  final String statusText;

  const ToDoState(
      {required this.status, required this.events, required this.statusText});

  ToDoState copyWith({
    FormStatus? status,
    List<ToDoModel>? events,
    String? statusText,
  }) =>
      ToDoState(
          status: status ?? this.status,
          events: events ?? this.events,
          statusText: statusText ?? this.statusText);

  @override
  List<Object?> get props => [status, events, statusText];
}
