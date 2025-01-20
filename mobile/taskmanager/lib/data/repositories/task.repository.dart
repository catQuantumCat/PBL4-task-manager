import 'package:taskmanager/data/datasources/local/task_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/model/task_model.dart';

class TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  final TaskLocalDatasource _localDatasource;

  TaskRepository(
      {required TaskRemoteDataSource remoteDataSource,
      required TaskLocalDatasource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDatasource = localDataSource;

  void init() {
    _localDatasource.init();
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

  Stream<List<TaskModel>> getTaskStream() => _localDatasource.getTaskStream;

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

  List<TaskModel> getTaskList() {
    return _localDatasource.getTaskList();
  }

  Future<TaskModel?> getTaskById(int taskId) async {
    TaskModel? toReturn = _localDatasource.getTaskById(taskId);
    toReturn ??= await _remoteDataSource.getTaskById(taskId);
    return toReturn;
  }

  Future<void> dispose() async {
    return _localDatasource.dispose();
  }
}
