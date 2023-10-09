import 'package:flutter/material.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.fieldController,
    required this.labelText,
    required this.onApplyClick,
  });
  final TextEditingController fieldController;
  final String labelText;
  final Function(String) onApplyClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input,
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.black,
                  ),
                ),
                child: child!,
              );
            }).then((selectedTime) {
          if (selectedTime != null) {
            String selectedTimeHour =
                selectedTime.hour.toString().length == 1 ? '0${selectedTime.hour}' : selectedTime.hour.toString();
            String selectedTimeMinute =
                selectedTime.minute.toString().length == 1 ? "0${selectedTime.minute}" : selectedTime.minute.toString();

            onApplyClick('$selectedTimeHour:$selectedTimeMinute');
          }
        });
      },
      child: CustomTextField(
        fieldController: fieldController,
        labelText: labelText,
        suffixIcon: const Icon(Icons.access_time_outlined, color: Colors.black),
        enabled: false,
      ),
    );
  }
}
