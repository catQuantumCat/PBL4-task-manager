import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taskmanager/common/constants/api_constant.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskRemoteDataSource {
  final Dio _dio;

  TaskRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<TaskModel>> syncTaskList() async {
    try {
      final Response response = await _dio.get(
        ApiConstants.task.value,
      );

      return response.data["data"]
          .map<TaskModel>((task) => TaskModel.fromJson(task))
          .toList();
    } catch (e) {
      log('Error syncing task list: $e');
      rethrow;
    }
  }

  Future<TaskModel> editTask(TaskDTO task, int taskId) async {
    log("${ApiConstants.task.value}/$taskId");
    final response = await _dio.put("${ApiConstants.task.value}/$taskId",
        data: task.toJson());

    return TaskModel.fromJson(response.data);
  }

  Future<void> deleteTask(int taskID) async {
    await _dio.delete("${ApiConstants.task.value}/$taskID");
  }

  Future<TaskModel> createTask(TaskDTO task) async {
    final response =
        await _dio.post(ApiConstants.task.value, data: task.toJson());
    return TaskModel.fromJson(response.data);
  }

  Future<TaskModel> getTaskById(int taskId) async {
    final response = await _dio.get("${ApiConstants.task.value}/$taskId");
    
    return TaskModel.fromJson(response.data);
  }
}
