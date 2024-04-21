import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.userFieldController,
    required this.text,
    this.icon,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController userFieldController;
  final String text;
  final IconData? icon;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _obscureText : false,
      controller: widget.userFieldController,
      decoration: InputDecoration(
        labelText: widget.text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
