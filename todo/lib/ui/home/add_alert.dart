import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/home/add_task_controller.dart';
import 'package:todo/ui/style/colors.dart';
import 'package:todo/ui/widgets/input_widget.dart';

class AddAlert extends StatefulWidget {
  @override
  _AddAlertState createState() => _AddAlertState();
}

enum AddAlertState { loading, init }

class _AddAlertState extends State<AddAlert> {
  AddAlertState _state = AddAlertState.loading;

  @override
  void initState() {
    super.initState();
  }

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

class DialogButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isEnable;

  DialogButton({
    this.isEnable = true,
    required this.text,
    required this.textColor,
    required this.onPressed,
  });

  @override
  _DialogButtonState createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  static final PressedColor = AppColors.lightBlue;
  static final ReleasedColor = Colors.transparent;

  Color _backgroundColor = ReleasedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.isEnable) widget.onPressed();
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _backgroundColor = ReleasedColor;
        });
      },
      onTapCancel: () {
        setState(() {
          _backgroundColor = ReleasedColor;
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _backgroundColor = PressedColor;
        });
      },
      child: ColoredBox(
        color: widget.isEnable ? _backgroundColor : PressedColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 50),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
