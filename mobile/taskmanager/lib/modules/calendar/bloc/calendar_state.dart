part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  const CalendarState(
      {required this.selectedDate,
      this.filteredTask = const [],
      this.fullTask = const {}});

  final DateTime selectedDate;
  final List<TaskModel> filteredTask;
  final Set<DateTime> fullTask;

  @override
  List<Object> get props => [selectedDate, filteredTask, fullTask];

  CalendarState copyWith({
    DateTime? selectedDate,
    List<TaskModel>? filteredTask,
    Set<DateTime>? fullTask,
  }) {
    return CalendarState(
        selectedDate: selectedDate ?? this.selectedDate,
        filteredTask: filteredTask ?? this.filteredTask,
        fullTask: fullTask ?? this.fullTask);
  }
}

class CalendarInitial extends CalendarState {
  CalendarInitial({DateTime? selectedDate})
      : super(selectedDate: selectedDate ?? DateTime.now());
}

class CalendarFailed extends CalendarState {
  final String errorMessage;

  CalendarFailed({required this.errorMessage})
      : super(selectedDate: DateTime.now());

  @override
  List<Object> get props => [errorMessage];
}
