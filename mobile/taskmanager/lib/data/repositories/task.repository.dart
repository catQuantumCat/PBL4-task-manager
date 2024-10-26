import 'package:taskmanager/data/datasources/local/task_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';

class TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  final TaskLocalDatasource _localDatasource;

  TaskRepository(
      {required TaskRemoteDataSource remoteDataSource,
      required TaskLocalDatasource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDatasource = localDataSource {
    syncFromRemote();
  }

  void syncFromRemote() async {
    try {
      final newTaskList = await _remoteDataSource.syncTaskList();
      _localDatasource.syncTaskList(newTaskList);
    } catch (e) {
      return;
    }
  }

  Stream<List<TaskModel>> getTaskList() => _localDatasource.getTaskList;

  Future<TaskModel> editTask(TaskDTO task, int taskId) async {
    final editedTask = await _remoteDataSource.editTask(task, taskId);
    _localDatasource.editTask(editedTask);
    return editedTask;
  }

  Future<void> deleteTask(int taskID) async {
    await _remoteDataSource.deleteTask(taskID);
    _localDatasource.deleteTask(taskID);
  }

  Future<TaskModel> createTask(TaskDTO task) async {
    final newTask = await _remoteDataSource.createTask(task);
    _localDatasource.createTask(newTask);
    return newTask;
  }

  List<TaskModel> searchTask(String query) {
    return _localDatasource.searchTask(query);
  }

  Future<void> dispose() async {
    return _localDatasource.dispose();
  }
}
