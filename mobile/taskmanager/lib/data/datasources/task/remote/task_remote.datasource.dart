import 'package:dio/dio.dart';
import 'package:taskmanager/common/api_constant.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskRemoteDataSource {
  final _dio = Dio();

  Future<List<TaskModel>> getTaskList() async {
    final Response response = await _dio.get(ApiConstant.api_const);

    return response.data["data"]
        .map<TaskModel>((task) => TaskModel.fromJson(task))
        .toList();
  }

  Future<TaskModel> editTask(TaskDTO task, int taskId) async {
    final response =
        await _dio.put("${ApiConstant.api_const}/$taskId", data: task.toJson());
    return TaskModel.fromJson(response.data);
  }
}
