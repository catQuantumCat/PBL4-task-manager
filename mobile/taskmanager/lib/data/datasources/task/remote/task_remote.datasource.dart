import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taskmanager/common/api_constant.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskRemoteDataSource {
  final _dio = Dio();

  Future<List<TaskModel>> getTaskList() async {
    final Response response = await _dio.get(ApiConstant.apiCONST);

    return response.data["data"]
        .map<TaskModel>((task) => TaskModel.fromJson(task))
        .toList();
  }

  Future<TaskModel> editTask(TaskDTO task, int taskId) async {
    log("${ApiConstant.apiCONST}/$taskId");
    final response =
        await _dio.put("${ApiConstant.apiCONST}/$taskId", data: task.toJson());

    return TaskModel.fromJson(response.data);
  }

  Future<void> deleteTask(int taskID) async {
    await _dio.delete("${ApiConstant.apiCONST}/$taskID");
  }

  Future<TaskModel> createTask(TaskDTO task) async {
    final response = await _dio.post(ApiConstant.apiCONST, data: task.toJson());
    return TaskModel.fromJson(response.data);
  }
}
