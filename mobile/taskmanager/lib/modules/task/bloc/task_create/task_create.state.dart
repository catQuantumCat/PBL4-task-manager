part of 'task_create.bloc.dart';

enum NewHomeStatus { initial, loading, success, failure }

class TaskCreateState extends Equatable {
  final NewHomeStatus status;
  final int priority;
  final DateTime date;
  final TimeOfDay time;
  final String dateLabel;
  final String timeLabel;
  final String? missionName;
  final String? description;

  @override
  List<Object?> get props =>
      [status, date, dateLabel, timeLabel, missionName, description, priority];

  const TaskCreateState({
    required this.status,
    this.priority = 0,
    required this.date,
    required this.time,
    required this.dateLabel,
    required this.timeLabel,
    this.missionName,
    this.description,
  });

  TaskCreateState.initial()
      : this(
            status: NewHomeStatus.initial,
            date: DateTime.now(),
            time: TimeOfDay.now(),
            dateLabel: "Today",
            timeLabel: TimeOfDay.now().toLabel());

  TaskCreateState copyWith(
      {NewHomeStatus? status,
      int? priority,
      DateTime? date,
      TimeOfDay? time,
      String? dateLabel,
      String? timeLabel,
      String? missionName,
      String? description}) {
    return TaskCreateState(
        status: status ?? this.status,
        priority: priority ?? this.priority,
        date: date ?? this.date,
        time: time ?? this.time,
        dateLabel: dateLabel ?? this.dateLabel,
        timeLabel: timeLabel ?? this.timeLabel,
        missionName: missionName ?? this.missionName,
        description: description ?? this.description);
  }

  TaskDTO toDTO() {
    if (missionName == null) {
      throw ArgumentError('missionName cannot be null');
    }

    return TaskDTO(
      name: missionName!,
      description: description,
      priority: priority,
      createTime: DateTime.now(),
      deadTime: date.at(time),
      status: false,
    );
  }
}
