import 'dart:async';
import 'dart:developer' as developer;
import 'package:taskmanager/data/model/task_model.dart';

class TaskLocalDatasource {
  late StreamController<List<TaskModel>> _taskStreamController;
  List<TaskModel> _tasks = [];

  Stream<List<TaskModel>> get getTaskStream {
    return _taskStreamController.stream.asBroadcastStream();
  }

  void init() {
    _taskStreamController = StreamController<List<TaskModel>>.broadcast();
  }

  Future<void> dispose() async {
    await _taskStreamController.close();
  }

  void syncTaskList(List<TaskModel> remoteTaskList) async {
    if (_taskStreamController.isClosed) return;

    _tasks = remoteTaskList;
    _taskStreamController.add(_tasks);
  }

  Future<void> editTask(TaskModel remoteTask) async {
    final index = _tasks.indexWhere((task) => task.id == remoteTask.id);
    if (_taskStreamController.isClosed) return;

    if (index != -1) {
      _tasks[index] = remoteTask;
      _taskStreamController.add(_tasks);
      return;
    }

    throw (Exception("ID not found - EditTask localTaskList"));
  }

  Future<void> deleteTask(int taskID) async {
    if (_taskStreamController.isClosed) return;

    final index = _tasks.indexWhere((task) => task.id == taskID);

    if (index != -1) {
      _tasks.removeAt(index);
      _taskStreamController.add(_tasks);

      return;
    }

    throw (Exception("ID not found - RemoveTask localTaskList"));
  }

  Future<void> createTask(TaskModel taskFromRemote) async {
    if (_taskStreamController.isClosed) return;

    final index = _tasks.indexWhere((task) => task.id == taskFromRemote.id);

    if (index == -1) {
      _tasks.add(taskFromRemote);
    } else {
      _tasks[index] = taskFromRemote;
    }
    _taskStreamController.add(_tasks);
  }

  List<TaskModel> searchTask(String query) {
    return _tasks.where((task) => task.name.contains(query)).toList();
  }

  List<TaskModel> getTaskList() {
    return _tasks;
  }

  TaskModel? getTaskById(int taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }
}
