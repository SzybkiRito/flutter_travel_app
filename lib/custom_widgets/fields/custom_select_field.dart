import 'package:flutter/material.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class CustomSelectField extends StatefulWidget {
  const CustomSelectField({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });
  final List<String> options;
  final Function(String?) onOptionSelected;

  @override
  State<CustomSelectField> createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: AppColors.kDefaultLightButtonColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          onChanged: widget.onOptionSelected,
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                setState(() {
                  _selectedOption = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
