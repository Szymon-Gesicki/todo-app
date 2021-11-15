import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/network/task_client.dart';
import 'package:todo/ui/repositories/resource.dart';
import 'package:todo/ui/repositories/task.dart';

class TaskRepository {
  late final BehaviorSubject<Resource<List<Task>>> _tasksStream;

  TaskRepository() {
    _tasksStream = BehaviorSubject(
      onListen: _onTasksListen,
    );
  }

  Stream<Resource<List<Task>>> watchTasks() {
    return _tasksStream.stream;
  }

  void _onTasksListen() {
    reloadTasks();
  }

  Future<void> reloadTasks() async {
    final current = _tasksStream.valueOrNull;
    _tasksStream.add(Resource.loading(current?.data));

    final result = await Get.find<TaskClient>().getTask();
    if (result.success) {
      _tasksStream.add(Resource.success(result.result!));
    } else {
      _tasksStream.add(Resource.error(result.error!));
    }
  }

  Future<void> invalidateTask() async {
    _tasksStream.add(Resource.loading(null));
    if (_tasksStream.hasListener) {
      await reloadTasks();
    }
  }

  void close() {
    _tasksStream.close();
  }
}
