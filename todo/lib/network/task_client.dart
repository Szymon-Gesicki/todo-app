import 'package:get/get.dart';
import 'package:todo/network/models/task_model.dart';
import 'package:todo/network/todo_api/todo_api.dart';
import 'package:todo/network/todo_client.dart';
import 'package:todo/repositories/user/profile_repository.dart';
import 'package:todo/ui/repositories/task.dart';

class TaskClient {
  late final TodoApi api;

  TaskClient() {
    api = Get.find<TodoClient>().todoApi;
  }

  Future<SimpleResult<List<Task>>> getTask() async {
    try {
      final result = await api.getTasks();
      return SimpleResult.createSuccess(
        result.map((e) => NetworkTaskMapper.fromNetwork(e)).toList(),
      );
    } catch (e, st) {
      print("Failed to get tasks ${e} ${st}");
      return SimpleResult.createFailed("Unknown error");
    }
  }

  Future<SimpleResult<void>> addTask(Task task) async {
    try {
      await api.addTask(NetworkTaskMapper.toNetwork(task));
      return SimpleResult.createEmptySuccess();
    } catch (e, st) {
      print("Failed to get tasks $e $st");
      return SimpleResult.createFailed("Unknown error");
    }
  }

  Future<SimpleResult<void>> update(Task task) async {
    try {
      await api.updateTask(task.pk!, NetworkTaskMapper.toNetwork(task));
      return SimpleResult.createEmptySuccess();
    } catch (e, st) {
      print("Failed to get tasks $e $st");
      return SimpleResult.createFailed("Unknown error");
    }
  }
}

class NetworkTaskMapper {
  NetworkTaskMapper._();

  static Task fromNetwork(TaskModel network) {
    return Task(
        name: network.name,
        createDate: DateTime.parse(network.createDate),
        isDone: network.isDone,
        pk: network.pk);
  }

  static TaskModel toNetwork(Task network) {
    return TaskModel(
      network.name,
      network.createDate.toIso8601String(),
      network.isDone,
      network.pk,
    );
  }
}
