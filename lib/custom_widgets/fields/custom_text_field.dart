import 'package:flutter/material.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.fieldController,
    required this.labelText,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.enabled = true,
  });
  final TextEditingController fieldController;
  final String labelText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: fieldController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        filled: true,
        fillColor: AppColors.kDefaultLightButtonColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixIconTap,
                icon: suffixIcon!,
              )
            : null,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
