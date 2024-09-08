class TaskModel {
  final int id;
  final String name;
  final String description;
  final DateTime createTime;
  final DateTime deadTime;
  bool status;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createTime,
    required this.deadTime,
    required this.status,
  });

  void editStatus(bool newStatus) {
    status = newStatus;
  }
}
