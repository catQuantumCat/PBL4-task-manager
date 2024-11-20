part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  const CalendarState({required this.selectedDate, required this.filteredTask});

  final DateTime selectedDate;
  final List<TaskModel> filteredTask;

  @override
  List<Object> get props => [selectedDate, filteredTask];

  CalendarState copyWith({
    DateTime? selectedDate,
    List<TaskModel>? filteredTask,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      filteredTask: filteredTask ?? this.filteredTask,
    );
  }
}

class CalendarInitial extends CalendarState {
  CalendarInitial({DateTime? selectedDate})
      : super(selectedDate: selectedDate ?? DateTime.now(), filteredTask: []);
}

class CalendarFailed extends CalendarState {
  final String errorMessage;

  CalendarFailed({required this.errorMessage})
      : super(selectedDate: DateTime.now(), filteredTask: []);

  @override
  List<Object> get props => [errorMessage];
}
