import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.text,
    this.enableLoading = false,
  });
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final bool enableLoading;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  Text _buildTextButton() {
    return Text(
      widget.text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: widget.textColor,
          ),
    );
  }

  Widget _buildLoadingButton() {
    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.0),
        ),
      ),
      child: widget.enableLoading ? _buildLoadingButton() : _buildTextButton(),
    );
  }
}
