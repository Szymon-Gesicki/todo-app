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
        result.map((e) => NetworkTaskMapper.networkTaskNetwork(e)).toList(),
      );
    } catch (e, st) {
      print("Failed to get tasks ${e} ${st}");
      return SimpleResult.createFailed("Unknown error");
    }
  }
}

class NetworkTaskMapper {
  NetworkTaskMapper._();

  static Task networkTaskNetwork(TaskModel network) {
    return Task(
        name: network.name,
        createDate: network.createDate,
        isDone: network.isDone,
        pk: network.pk);
  }
}
