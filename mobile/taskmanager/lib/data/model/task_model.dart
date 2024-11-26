// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:taskmanager/data/dtos/task.dto.dart';

class TaskModel {
  final int id;
  final String name;
  final String? description;
  final int priority;
  final DateTime createTime;
  final DateTime deadTime;
  bool status;

  TaskModel({
    required this.id,
    required this.name,
    required this.priority,
    this.description,
    required this.createTime,
    required this.deadTime,
    required this.status,
  });

  void editStatus(bool newStatus) {
    status = newStatus;
  }

  TaskDTO toResponse(
      {String? name,
      String? description,
      int? priority,
      DateTime? createTime,
      DateTime? deadTime,
      bool? status}) {
    return TaskDTO(
        name: name ?? this.name,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        createTime: createTime ?? this.createTime,
        deadTime: deadTime ?? this.deadTime,
        status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'priority': priority,
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
      priority: map['priority'] as int,
      description:
          map['description'] != null ? map['description'] as String : null,
      createTime: DateTime.parse(map['createTime']),
      deadTime: DateTime.parse(map['deadTime']),
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  TaskModel copyWith({
    int? id,
    String? name,
    int? priority,
    String? description,
    DateTime? createTime,
    DateTime? deadTime,
    bool? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      createTime: createTime ?? this.createTime,
      deadTime: deadTime ?? this.deadTime,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Task[$name]: $status';
    // return 'TaskModel(id: $id, name: $name, description: $description, createTime: $createTime, deadTime: $deadTime, status: $status)';
  }
}
