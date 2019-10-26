import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// The widget has to be stateful
// So that the input in the textfield won't be cleared when it is unfocused

class UserInputTextField extends StatefulWidget {
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final Function(String) onChange;

  UserInputTextField({this.prefixIcon, this.hintText, this.obscureText = false, this.onChange});

  @override
  _UserInputTextFieldState createState() => _UserInputTextFieldState();
}

class _UserInputTextFieldState extends State<UserInputTextField> {
  final TextEditingController _txtController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _txtController,
      onChanged: (value) {
        widget.onChange(value);
      },
      style: Styles.pStyle,
      cursorColor: Styles.midnightBlue,
      cursorWidth: 5,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          prefix: widget.prefixIcon == null ? Padding(padding: EdgeInsets.only(left: 30)) : null,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(left: 25, right: 20),
                  child: Icon(widget.prefixIcon),
                )
              : null,
          suffix: GestureDetector(
            onTap: () {
              Future.delayed(Duration(milliseconds: 50)).then((_) {
                _txtController.clear();
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25, left: 10),
              child: Icon(
                FontAwesomeIcons.times,
                color: Styles.midnightBlue,
                size: Styles.iconSize,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Styles.grey, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Styles.midnightBlue, width: 3),
          ),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 20)),
    );
  }
}
