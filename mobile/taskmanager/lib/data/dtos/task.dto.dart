import 'dart:convert';

class TaskDTO {
  final String name;
  final String? description;
  final int priority;
  final DateTime createTime;
  final DateTime deadTime;
  final bool status;

  TaskDTO({
    required this.name,
    this.description,
    required this.priority,
    required this.createTime,
    required this.deadTime,
    required this.status,
  });

  TaskDTO copyWith({
    int? id,
    String? name,
    String? description,
    int? priority,
    DateTime? createTime,
    DateTime? deadTime,
    bool? status,
  }) {
    return TaskDTO(
      name: name ?? this.name,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      createTime: createTime ?? this.createTime,
      deadTime: deadTime ?? this.deadTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'priority': priority,
      'createTime': createTime.toIso8601String(),
      'deadTime': deadTime.toIso8601String(),
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TaskResponseDTO(missionName: $name, description: $description, createDate: $createTime, deadDate: $deadTime, status: $status)';
  }
}
