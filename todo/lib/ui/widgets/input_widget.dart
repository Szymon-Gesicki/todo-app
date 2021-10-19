import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';

enum InputWidgetType { email, login, password }

extension InputWidgetTypeExtension on InputWidgetType {
  TextInputType inputType() {
    switch (this) {
      case InputWidgetType.email:
        return TextInputType.emailAddress;
      case InputWidgetType.login:
        return TextInputType.name;
      case InputWidgetType.password:
        return TextInputType.name;
    }
  }

  String hintText() {
    switch (this) {
      case InputWidgetType.email:
        return "Email";
      case InputWidgetType.login:
        return "Login";
      case InputWidgetType.password:
        return "Password";
    }
  }
}

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final InputWidgetType type;

  InputWidget({required this.controller, required this.type});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray,
            blurRadius: 10,
          )
        ],
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.type.inputType(),
        textInputAction: TextInputAction.next,
        obscureText: widget.type == InputWidgetType.password,
        enableSuggestions: widget.type != InputWidgetType.password,
        autocorrect: widget.type != InputWidgetType.password,
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: widget.type.hintText()),
      ),
    );
  }
}
