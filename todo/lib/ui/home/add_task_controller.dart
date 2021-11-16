import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/managers/toast_notification.dart';
import 'package:todo/ui/repositories/task.dart';
import 'package:todo/ui/repositories/task_repository.dart';

class AddTaskController extends ChangeNotifier {
  bool _loading = false;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  bool get isLoading => _loading;

  Future<bool> save() async {
    if (isLoading) return false;

    _loading = true;
    notifyListeners();

    if (!_validateInput()) {
      _loading = false;
      notifyListeners();
      return false;
    }
    final result = await Get.find<TaskRepository>().addTask(Task(
      name: _nameController.text,
      createDate: DateTime.now(),
      isDone: false,
    ));

    _loading = false;

    if (!result.success) {
      ToastNotification.fire(result.error!);
    }

    notifyListeners();

    return result.success;
  }

  bool _validateInput() {
    if (nameController.text.isEmpty) {
      ToastNotification.fire("Please enter name");
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
