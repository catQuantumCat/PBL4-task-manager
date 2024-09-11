// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final int id;
  final String missionName;
  final String discription;
  final DateTime createDate;
  final DateTime deadDate;
  bool status;

  TaskModel({
    required this.id,
    required this.missionName,
    this.discription = "No description",
    required this.createDate,
    required this.deadDate,
    required this.status,
  });

  void editStatus(bool newStatus) {
    status = newStatus;
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'missionName': missionName,
  //     'discription': discription,
  //     'createDate': createDate.toIso8601String(),
  //     'deadDate': deadDate.toIso8601String(),
  //     'status': status,
  //   };
  // }

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        missionName = json['missionName'] as String,
        discription = json['discription'] as String,
        createDate = DateTime.parse(json['createDate'] as String),
        deadDate = DateTime.parse(json['deadDate'] as String),
        status = json['status'] as bool;
}
