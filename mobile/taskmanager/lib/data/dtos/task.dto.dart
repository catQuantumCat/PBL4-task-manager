import 'dart:convert';

class TaskDTO {
  final String missionName;
  final String? discription;
  final DateTime createDate;
  final DateTime deadDate;
  final bool status;

  TaskDTO({
    required this.missionName,
    this.discription,
    required this.createDate,
    required this.deadDate,
    required this.status,
  });

  TaskDTO copyWith({
    int? id,
    String? missionName,
    String? discription,
    DateTime? createDate,
    DateTime? deadDate,
    bool? status,
  }) {
    return TaskDTO(
      missionName: missionName ?? this.missionName,
      discription: discription ?? this.discription,
      createDate: createDate ?? this.createDate,
      deadDate: deadDate ?? this.deadDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'missionName': missionName,
      'discription': discription,
      'createDate': createDate.toIso8601String(),
      'deadDate': deadDate.toIso8601String(),
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'TaskResponseDTO(missionName: $missionName, discription: $discription, createDate: $createDate, deadDate: $deadDate, status: $status)';
  }
}
