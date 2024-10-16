import 'package:taskmanager/data/datasources/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskRepository {
  final TaskRemoteDataSource _dataSource;

  TaskRepository({required TaskRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  Future<List<TaskModel>> getTaskList() {
    return _dataSource.getTaskList();
  }

  Future<TaskModel> editTask(TaskDTO task, int taskId) {
    return _dataSource.editTask(task, taskId);
  }

  Future<void> deleteTask(int taskID) {
    return _dataSource.deleteTask(taskID);
  }

  Future<TaskModel> createTask(TaskDTO task) {
    return _dataSource.createTask(task);
  }
}
