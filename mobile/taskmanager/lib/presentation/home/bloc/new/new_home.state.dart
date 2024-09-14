part of 'new_home.bloc.dart';

enum NewHomeStatus { initial, editing, loading, success, failure }

class NewHomeState extends Equatable {
  final NewHomeStatus status;
  final DateTime date;
  final TimeOfDay time;
  final String dateLabel;
  final String timeLabel;
  final String? missionName;
  final String? discription;

  @override
  List<Object?> get props =>
      [status, date, dateLabel, timeLabel, missionName, discription];

  const NewHomeState({
    required this.status,
    required this.date,
    required this.time,
    required this.dateLabel,
    required this.timeLabel,
    this.missionName,
    this.discription,
  });

  NewHomeState.initial()
      : this(
            status: NewHomeStatus.initial,
            date: DateTime.now(),
            time: TimeOfDay.now(),
            dateLabel: "Today",
            timeLabel: TimeOfDay.now().toLabel());

  NewHomeState copyWith(
      {NewHomeStatus? status,
      DateTime? date,
      TimeOfDay? time,
      String? dateLabel,
      String? timeLabel,
      String? missionName,
      String? discription}) {
    return NewHomeState(
        status: status ?? this.status,
        date: date ?? this.date,
        time: time ?? this.time,
        dateLabel: dateLabel ?? this.dateLabel,
        timeLabel: timeLabel ?? this.timeLabel,
        missionName: missionName ?? this.missionName,
        discription: discription ?? this.discription);
  }

  TaskDTO toDTO() {
    if (missionName == null) {
      throw ArgumentError('missionName cannot be null');
    }

    return TaskDTO(
        name: missionName!,
        description: discription,
        createTime: DateTime.now(),
        deadTime: date.at(time),
        status: false);
  }
}
