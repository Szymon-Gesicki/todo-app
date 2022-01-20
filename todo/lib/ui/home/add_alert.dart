import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/add_task_controller.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/dialog_button.dart';
import 'package:todo/ui/widgets/input_widget.dart';

class AddAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: ChangeNotifierProvider<AddTaskController>(
        create: (context) => AddTaskController(),
        child: Consumer<AddTaskController>(
          builder: (context, controller, child) {
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Visibility(
                          visible: controller.isLoading,
                          child: Container(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text("Add task"),
                            SizedBox(height: 16),
                            InputWidget(
                              controller: controller.nameController,
                              type: InputWidgetType.name,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.lightBlue,
                      ),
                      DialogButton(
                        isEnable: !controller.isLoading,
                        text: "Save",
                        textColor: AppColors.primaryColor,
                        onPressed: () async {
                          if (await controller.save()) {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
