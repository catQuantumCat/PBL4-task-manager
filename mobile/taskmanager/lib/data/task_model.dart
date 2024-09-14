import 'package:taskmanager/data/dtos/task.dto.dart';

class TaskModel {
  final int id;
  final String missionName;
  final String? discription;
  final DateTime createDate;
  final DateTime deadDate;
  bool status;

  TaskModel({
    required this.id,
    required this.missionName,
    this.discription,
    required this.createDate,
    required this.deadDate,
    required this.status,
  });

  void editStatus(bool newStatus) {
    status = newStatus;
  }

  TaskDTO toResponse() {
    return TaskDTO(
        missionName: missionName,
        discription: discription,
        createDate: createDate,
        deadDate: deadDate,
        status: status);
  }

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        missionName = json['missionName'] as String,
        discription = json['discription'] as String,
        createDate = DateTime.parse(json['createDate'] as String),
        deadDate = DateTime.parse(json['deadDate'] as String),
        status = json['status'] as bool;
}
