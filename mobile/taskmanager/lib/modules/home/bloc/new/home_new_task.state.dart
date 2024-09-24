part of 'home_new_task.bloc.dart';

enum NewHomeStatus { initial, loading, success, failure }

class HomeNewTaskStatus extends Equatable {
  final NewHomeStatus status;
  final DateTime date;
  final TimeOfDay time;
  final String dateLabel;
  final String timeLabel;
  final String? missionName;
  final String? description;

  @override
  List<Object?> get props =>
      [status, date, dateLabel, timeLabel, missionName, description];

  const HomeNewTaskStatus({
    required this.status,
    required this.date,
    required this.time,
    required this.dateLabel,
    required this.timeLabel,
    this.missionName,
    this.description,
  });

  HomeNewTaskStatus.initial()
      : this(
            status: NewHomeStatus.initial,
            date: DateTime.now(),
            time: TimeOfDay.now(),
            dateLabel: "Today",
            timeLabel: TimeOfDay.now().toLabel());

  HomeNewTaskStatus copyWith(
      {NewHomeStatus? status,
      DateTime? date,
      TimeOfDay? time,
      String? dateLabel,
      String? timeLabel,
      String? missionName,
      String? description}) {
    return HomeNewTaskStatus(
        status: status ?? this.status,
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
      createTime: DateTime.now(),
      deadTime: date.at(time),
      status: false,
    );
  }
}
