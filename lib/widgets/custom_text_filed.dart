import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color baseColor;
  final Color hintColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function validator;
  final Function onChanged;

  CustomTextField(
      {required this.hint,
      required this.controller,
      required this.baseColor,
      required this.hintColor,
      required this.borderColor,
      required this.errorColor,
      required this.inputType,
      required this.obscureText,
      required this.validator,
      required this.onChanged});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 1.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        obscureText: widget.obscureText,
        onChanged: (text) {
          widget.onChanged(text);
          setState(() {
            if (!widget.validator(text) || text.length == 0) {
              currentColor = widget.errorColor;
            } else {
              currentColor = widget.baseColor;
            }
          });
        },
        controller: widget.controller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              color: widget.hintColor,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: widget.hint),
      ),
    );
  }
}
