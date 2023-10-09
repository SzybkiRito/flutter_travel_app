import 'package:flutter/material.dart';
import 'package:travel_planning_app/themes/app_colors.dart';

class TripCreationCircleDays extends StatefulWidget {
  const TripCreationCircleDays({
    super.key,
    required this.tripStartDate,
    required this.tripEndDate,
    required this.onDaySelected,
  });
  final DateTime tripStartDate;
  final DateTime tripEndDate;
  final Function(int) onDaySelected;

  @override
  State<TripCreationCircleDays> createState() => _TripCreationCircleDaysState();
}

class _TripCreationCircleDaysState extends State<TripCreationCircleDays> {
  final List<int> _selectedDays = [1];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.tripEndDate.difference(widget.tripStartDate).inDays,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                widget.onDaySelected(index + 1);
                setState(() {
                  if (_selectedDays.contains(index + 1)) {
                    _selectedDays.remove(index + 1);
                  } else {
                    _selectedDays.add(index + 1);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircleAvatar(
                    backgroundColor: _selectedDays.contains(index + 1)
                        ? AppColors.kDefaultDarkBlueColor
                        : AppColors.kDefaultLightBlueColor,
                    radius: 50,
                    child: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
