import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo/ui/home/add_alert.dart';
import 'package:todo/ui/repositories/resource.dart';
import 'package:todo/ui/repositories/task.dart';
import 'package:todo/ui/repositories/task_repository.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/shrink_tap.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray,
            blurRadius: 10,
          )
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Resource<List<Task>>>(
            stream: Get.find<TaskRepository>().watchTasks(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return _buildEmptyLoading();
              }
              final resource = snapshot.data!;
              switch (resource.state) {
                case ResourceState.loading:
                  if ((resource.data ?? []).isNotEmpty)
                    return _body(_buildData(resource.data!), isLoading: true);
                  else
                    return _body(Container(), isLoading: true);
                case ResourceState.error:
                  return _body(_buildError(resource.localizedError));
                case ResourceState.success:
                  return _body(_buildData(resource.successData));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyLoading() {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text("Failed to load tasks.\n$error"),
    );
  }

  Widget _buildData(List<Task> tasks) {
    final widgets = tasks.map((e) => TaskItem(task: e));

    return Column(
      children: [
        if (widgets.isEmpty) Text("No task"),
        ...widgets,
      ],
    );
  }

  Widget _body(Widget child, {bool isLoading = false}) {
    return Stack(
      children: [
        Row(
          children: [
            Visibility(
              visible: isLoading,
              child: Container(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            Spacer(flex: 1),
            ShrinkTap(
              child: Text(
                "+",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColors.primaryColor),
              ),
              onTap: () {
                _presentAddAlert();
              },
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 25),
            Center(child: child),
          ],
        ),
      ],
    );
  }

  void _presentAddAlert() {
    showDialog(
      context: context,
      builder: (context) => AddAlert(),
    );
  }
}

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ShrinkTap(
            onTap: () {
              Get.find<TaskRepository>().markAsDone(widget.task);
            },
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: widget.task.isDone
                      ? AppColors.primaryColor
                      : Colors.white,
                  border: Border.all(color: Colors.black, width: 2)),
            ),
          ),
          SizedBox(width: 20),
          Text(
            widget.task.name,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                decoration: widget.task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
