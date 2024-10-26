import 'dart:async';
import 'dart:developer' as developer;
import 'package:taskmanager/data/task_model.dart';

class TaskLocalDatasource {
  final _taskStreamController = StreamController<List<TaskModel>>.broadcast();
  List<TaskModel> _tasks = [];

  Stream<List<TaskModel>> get getTaskList =>
      _taskStreamController.stream.asBroadcastStream();

  Future<void> dispose() async {
    await _taskStreamController.close();
  }

  void syncTaskList(List<TaskModel> remoteTaskList) async {
    developer.log('Syncing task list with remote tasks',
        name: 'TaskLocalDatasource');
    _tasks = remoteTaskList;
    _taskStreamController.add(_tasks);
  }

  Future<void> editTask(TaskModel remoteTask) async {
    final index = _tasks.indexWhere((task) => task.id == remoteTask.id);

    if (index != -1) {
      _tasks[index] = remoteTask;
      _taskStreamController.add(_tasks);
      return;
    }

    developer.log('Task ID not found: ${remoteTask.id}',
        name: 'TaskLocalDatasource', level: 900);
    throw (Exception("ID not found - EditTask localTaskList"));
  }

  Future<void> deleteTask(int taskID) async {
    developer.log('Deleting task: $taskID', name: 'TaskLocalDatasource');

    final index = _tasks.indexWhere((task) => task.id == taskID);

    if (index != -1) {
      _tasks.removeAt(index);
      _taskStreamController.add(_tasks);

      return;
    }
    developer.log('Task ID not found: $taskID',
        name: 'TaskLocalDatasource', level: 900);
    throw (Exception("ID not found - RemoveTask localTaskList"));
  }

  Future<void> createTask(TaskModel taskFromRemote) async {
    developer.log('Creating task: ${taskFromRemote.id}',
        name: 'TaskLocalDatasource');

    final index = _tasks.indexWhere((task) => task.id == taskFromRemote.id);

    if (index == -1) {
      _tasks.add(taskFromRemote);
      developer.log('Task created: ${taskFromRemote.id}',
          name: 'TaskLocalDatasource');
    } else {
      _tasks[index] = taskFromRemote;
      developer.log('Task updated: ${taskFromRemote.id}',
          name: 'TaskLocalDatasource');
    }
    _taskStreamController.add(_tasks);
  }

  List<TaskModel> searchTask(String query) {
    return _tasks.where((task) => task.name.contains(query)).toList();
  }
}
