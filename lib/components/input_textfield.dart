import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/misc/styles.dart';
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
  final Function prefixOnTap;
  final Function(String) onSubmit;
  final bool changeFocusColour;

  UserInputTextField(
      {this.prefixIcon,
      this.hintText,
      this.obscureText = false,
      this.highlightRed = false,
      this.onChange,
      this.keyboardType,
      this.autoFocus = false,
      this.prefixOnTap,
      this.onSubmit,
      this.changeFocusColour = true});

  @override
  _UserInputTextFieldState createState() => _UserInputTextFieldState();
}

class _UserInputTextFieldState extends State<UserInputTextField> {
  final TextEditingController _txtController = new TextEditingController();
  FocusNode _focus = new FocusNode();

  Color focusColor = Styles.yellow;
  Color unfocusedColor = Colors.white;

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

  Color _setTextFieldColour() {
    Color textfieldColour = Styles.yellow;
    if (widget.changeFocusColour) {
      if (widget.highlightRed) {
        textfieldColour = Styles.red;
      } else {
        textfieldColour = _focus.hasFocus ? Styles.yellow : Colors.white;
      }
    }
    return textfieldColour;
  }

  Color _setPrefixColour() {
    Color prefixColour = Styles.midnightBlue;
    if (widget.changeFocusColour) {
      prefixColour = _focus.hasFocus ? Styles.midnightBlue : Styles.mediumGrey;
    }
    return prefixColour;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _setTextFieldColour(),
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
        children: <Widget>[
          Container(
            child: widget.prefixIcon != null
                ? GestureDetector(
                    onTap: () {
                      widget.prefixOnTap();
                    },
                    child: DghaIcon(
                      icon: widget.prefixIcon,
                      iconColor: _setPrefixColour(),
                    ),
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
              onSubmitted: (value) {
                widget.onSubmit(value);
              },
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
