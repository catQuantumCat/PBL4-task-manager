import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/task_model.dart';

import '../dtos/task.dto.dart';

class TaskRepository {
  final TaskRemoteDataSource _dataSource;

  TaskRepository({required TaskRemoteDataSource dataSource})
      : _dataSource = dataSource;

  Future<List<TaskModel>> getTaskList() {
    return _dataSource.getTaskList();
  }

  Future<TaskModel> editTask(TaskDTO task, int taskId) {
    return _dataSource.editTask(task, taskId);
  }
}
