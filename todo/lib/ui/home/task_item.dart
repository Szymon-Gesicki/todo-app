import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/repositories/task.dart';
import 'package:todo/ui/repositories/task_repository.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/shrink_tap.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ShrinkTap(
            onTap: () {
              Get.find<TaskRepository>().markAsDone(task);
            },
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: task.isDone ? AppColors.primaryColor : Colors.white,
                  border: Border.all(color: Colors.black, width: 2)),
            ),
          ),
          SizedBox(width: 20),
          Text(
            task.name,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
