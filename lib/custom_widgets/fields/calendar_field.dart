import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';

class CalendarField extends StatelessWidget {
  CalendarField({
    super.key,
    required this.labelText,
    required this.onApplyClick,
  });
  final String labelText;
  final Function(DateTime, DateTime) onApplyClick;

  final TextEditingController _fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomDateRangePicker(
          context,
          dismissible: true,
          minimumDate: DateTime.now(),
          maximumDate: DateTime(2050, 10, 1),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
          backgroundColor: Colors.white,
          primaryColor: Colors.black,
          onApplyClick: (start, end) {
            _fieldController.text = '${start.day} - ${end.day} ${DateFormat.MMM().format(end)} ${end.year}';
            onApplyClick(start, end);
          },
          onCancelClick: () {
            _fieldController.clear();
          },
        );
      },
      child: CustomTextField(
        fieldController: _fieldController,
        labelText: labelText,
        suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.black),
        enabled: false,
      ),
    );
  }
}
