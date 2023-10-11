class ToDoModelFields {
  static const String id = "_id";
  static const String eventColor = "event_color";
  static const String eventName = "event_name";
  static const String eventDescription = "event_description";
  static const String eventLocation = "event_location";
  static const String eventTime = "event_time";
  static const String eventTable = "event_table";
  static const String day = "day";
}

class ToDoModel {
  int? id;
  final String eventName;
  final String eventDescription;
  final String eventLocation;
  final String eventColor;
  final String eventTime;
  final String? day;

  ToDoModel(
      {this.id, this.day,
      required this.eventColor,
      required this.eventDescription,
      required this.eventLocation,
      required this.eventName,
      required this.eventTime});

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json[ToDoModelFields.id] as int? ?? 0,
      day: json[ToDoModelFields.day] as String? ?? "",
      eventColor: json[ToDoModelFields.eventColor] as String? ?? "",
      eventDescription: json[ToDoModelFields.eventDescription] as String? ?? "",
      eventLocation: json[ToDoModelFields.eventLocation] as String? ?? "",
      eventName: json[ToDoModelFields.eventName] as String? ?? "",
      eventTime: json[ToDoModelFields.eventTime] as String? ?? "",
    );
  }

  ToDoModel copyWith({
    int? id,
    String? day,
    String? eventDescription,
    String? eventLocation,
    String? eventName,
    String? eventTime,
    String? eventColor,
  }) =>
      ToDoModel(
          id: id ?? this.id,
          day: day ?? this.day,
          eventColor: eventColor ?? this.eventColor,
          eventDescription: eventDescription ?? this.eventDescription,
          eventLocation: eventLocation ?? this.eventLocation,
          eventName: eventName ?? this.eventName,
          eventTime: eventTime ?? this.eventTime);

  @override
  String toString() {
    return """
    day: $day,
      eventColor: $eventColor,
      eventTime: $eventTime,
      eventName: $eventName,
      eventLocation: $eventLocation,
      eventDescription: $eventDescription,
    """;
  }

  Map<String, dynamic> toJson() {
    return {
      ToDoModelFields.eventDescription: eventDescription,
      ToDoModelFields.eventLocation: eventLocation,
      ToDoModelFields.eventName: eventName,
      ToDoModelFields.eventTime: eventTime,
      ToDoModelFields.eventColor: eventColor,
      ToDoModelFields.day: day
    };
  }

  List<Object?> get props => [
        eventTime,
        eventColor,
        eventLocation,
        eventDescription,
        eventName,
        day,
        id,
      ];
}
