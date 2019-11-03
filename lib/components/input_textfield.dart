import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// The widget has to be stateful
// So that the input in the textfield won't be cleared when it is unfocused

class UserInputTextField extends StatefulWidget {
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final bool highlightRed;
  final Function(String) onChange;
  final TextInputType keyboardType;
  final bool autoFocus;

  UserInputTextField({
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.highlightRed = false,
    this.onChange,
    this.keyboardType,
    this.autoFocus = false,
  });

  @override
  _UserInputTextFieldState createState() => _UserInputTextFieldState();
}

class _UserInputTextFieldState extends State<UserInputTextField> {
  final TextEditingController _txtController = new TextEditingController();
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  double _getTextFieldWidth() {
    if (widget.prefixIcon != null) {
      return MediaQuery.of(context).size.width - (Styles.spacing * 2) - ((Styles.iconPadding + Styles.iconPaddingPadding + Styles.iconSize) * 3);
    } else {
      return MediaQuery.of(context).size.width - (Styles.spacing * 2) - ((Styles.iconPadding + Styles.iconPaddingPadding + Styles.iconSize) * 2.25);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _focus.hasFocus ? Styles.yellow : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Styles.grey,
            blurRadius: 3,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        // direction: Axis.horizontal,
        children: <Widget>[
          Container(
            child: widget.prefixIcon != null
                ? DghaIcon(
                    icon: widget.prefixIcon,
                    iconColor: _focus.hasFocus ? Styles.midnightBlue : Styles.mediumGrey,
                  )
                : SizedBox(width: 30),
          ),
          Container(
            width: _getTextFieldWidth(),
            child: TextField(
              keyboardType: widget.keyboardType,
              controller: _txtController,
              focusNode: _focus,
              autofocus: widget.autoFocus,
              onChanged: (value) {
                widget.onChange(value);
              },
              style: Styles.pStyle,
              cursorColor: Styles.midnightBlue,
              cursorWidth: 5,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                if (_focus.hasFocus) {
                  Future.delayed(Duration(milliseconds: 50)).then((_) {
                    _txtController.clear();
                  });
                }
              },
              child: Container(
                child: DghaIcon(
                  icon: FontAwesomeIcons.times,
                  iconColor: _focus.hasFocus ? Styles.midnightBlue : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
