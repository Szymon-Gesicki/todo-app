import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo/ui/repositories/resource.dart';
import 'package:todo/ui/repositories/task.dart';
import 'package:todo/ui/repositories/task_repository.dart';
import 'package:todo/ui/style/colors.dart';

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
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text("+"),
            ),
            StreamBuilder<Resource<List<Task>>>(
              stream: Get.find<TaskRepository>().watchTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return _buildEmptyLoading();
                }

                final resource = snapshot.data!;
                switch (resource.state) {
                  case ResourceState.loading:
                    return _buildData(resource.data ?? [], isLoading: true);
                  case ResourceState.error:
                    return _buildError(resource.localizedError);
                  case ResourceState.success:
                    return _buildData(resource.successData);
                }
              },
            ),
          ]),
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

  Widget _buildData(List<Task> tasks, {bool isLoading = false}) {
    final widgets = tasks.map((e) => Text("${e.name}"));

    return Column(
      children: [
        if (isLoading) CircularProgressIndicator(),
        if (widgets.isEmpty && !isLoading) Text("No task"),
        ...widgets,
      ],
    );
  }
}
