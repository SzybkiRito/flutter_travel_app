import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/bloc/trip_creation/trip_creation_cubit.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/calendar_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/time_field.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';
import 'package:travel_planning_app/models/trip_creation_accomodation.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_circle_days_bar.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_places_page.dart';
import 'package:travel_planning_app/services/trip_creation_service.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class TripCreationAccomodationPage extends StatefulWidget {
  const TripCreationAccomodationPage({
    super.key,
    required this.tripStartDate,
    required this.tripEndDate,
    required this.tripName,
  });
  final String tripName;
  final DateTime tripStartDate;
  final DateTime tripEndDate;

  @override
  State<TripCreationAccomodationPage> createState() => _TripCreationAccomodationPageState();
}

class _TripCreationAccomodationPageState extends State<TripCreationAccomodationPage> {
  final accomodationNameFieldController = TextEditingController();
  final checkInTimeFieldController = TextEditingController();
  final checkOutTimeFieldController = TextEditingController();
  final accomodationAddressFieldController = TextEditingController();

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  TimeOfDay? _checkInTime;
  TimeOfDay? _checkOutTime;

  int selectedDay = 0;

  bool _saveAccomodationData() {
    if (_checkInDate == null ||
        _checkOutDate == null ||
        _checkInTime == null ||
        _checkOutTime == null ||
        accomodationNameFieldController.text.isEmpty ||
        accomodationAddressFieldController.text.isEmpty) {
      SnackbarController().showSnackbar(
        context: context,
        message: 'Please fill in all the fields',
        type: SnackbarTypes.error,
      );

      return false;
    }

    TripCreationAccomodation tripCreationAccomodation = TripCreationAccomodation(
      name: accomodationNameFieldController.text,
      address: accomodationAddressFieldController.text,
      checkInTime: _checkInTime!,
      checkOutTime: _checkOutTime!,
      checkInDate: _checkInDate!,
      checkOutDate: _checkOutDate!,
    );

    TripCreationService().addAccomodation(tripCreationAccomodation);

    return true;
  }

  void _pushToNextStage() {
    Navigator.of(context).push(
      CustomPageRoute(
        child: TripCreationPlacePage(
          tripName: widget.tripName,
          tripStartDate: widget.tripStartDate,
          tripEndDate: widget.tripEndDate,
        ),
      ),
    );
  }

  void _pushToNextDay() {
    if (selectedDay == widget.tripEndDate.difference(widget.tripStartDate).inDays) {
      _pushToNextStage();
      return;
    }

    Navigator.of(context).push(
      CustomPageRoute(
        child: TripCreationAccomodationPage(
          tripName: widget.tripName,
          tripStartDate: context.read<TripCreationCubit>().startDate!,
          tripEndDate: widget.tripEndDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: DefaultStylesConfig.kDefaultPadding,
                left: DefaultStylesConfig.kDefaultPadding,
              ),
              child: TripCreationCircleDays(
                tripStartDate: widget.tripStartDate,
                tripEndDate: widget.tripEndDate,
                onDaySelected: (day) {
                  setState(() {
                    selectedDay = day;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                DefaultStylesConfig.kDefaultPadding,
                0,
                DefaultStylesConfig.kDefaultPadding,
                DefaultStylesConfig.kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('d MMMM y').format(widget.tripStartDate),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    fieldController: accomodationNameFieldController,
                    labelText: 'Accommodation name',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    fieldController: accomodationAddressFieldController,
                    labelText: 'Address',
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: checkInTimeFieldController,
                    labelText: 'Check-in time',
                    onApplyClick: (checkInTime) {
                      _checkInTime = ModelConverter().convertStringHourToTimeOfDay(checkInTime);
                      checkInTimeFieldController.text = checkInTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  CalendarField(
                    labelText: 'Dates of stay',
                    onApplyClick: (checkInDate, checkOutDate) {
                      _checkInDate = checkInDate;
                      _checkOutDate = checkOutDate;
                    },
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: checkOutTimeFieldController,
                    labelText: 'Check-out time',
                    onApplyClick: (checkOutTime) {
                      _checkOutTime = ModelConverter().convertStringHourToTimeOfDay(checkOutTime);
                      checkOutTimeFieldController.text = checkOutTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        if (_saveAccomodationData()) {
                          _pushToNextDay();
                        }
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Add accommodation',
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        if (_saveAccomodationData()) {
                          _pushToNextStage();
                        }
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Save accommodation',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
