part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarOpen extends CalendarEvent {
  const CalendarOpen();
}

class CalendarDateSelected extends CalendarEvent {
  final DateTime selectedDate;

  const CalendarDateSelected({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}
