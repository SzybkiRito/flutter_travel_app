import 'package:flutter/material.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.fieldController,
    required this.labelText,
  });
  final TextEditingController fieldController;
  final String labelText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.fieldController,
      cursorColor: Colors.black,
      obscureText: _isObscured,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: Theme.of(context).textTheme.bodySmall,
        filled: true,
        fillColor: AppColors.kDefaultLightButtonColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
          color: Colors.black,
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
