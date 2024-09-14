// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:taskmanager/data/dtos/task.dto.dart';

class TaskModel {
  final int id;
  final String name;
  final String? description;
  final DateTime createTime;
  final DateTime deadTime;
  bool status;

  TaskModel({
    required this.id,
    required this.name,
    this.description,
    required this.createTime,
    required this.deadTime,
    required this.status,
  });

  void editStatus(bool newStatus) {
    status = newStatus;
  }

  TaskDTO toResponse() {
    return TaskDTO(
        name: name,
        description: description,
        createTime: createTime,
        deadTime: deadTime,
        status: status);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createTime': createTime.toIso8601String(),
      'deadTime': deadTime.toIso8601String(),
      'status': status,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      createTime: DateTime.parse(map['createTime']),
      deadTime: DateTime.parse(map['deadTime']),
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
