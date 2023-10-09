import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/bloc/trip_creation/trip_creation_cubit.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/time_field.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';
import 'package:travel_planning_app/models/trip_creation_place.dart';
import 'package:travel_planning_app/pages/main_page/main_page.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_circle_days_bar.dart';
import 'package:travel_planning_app/services/trip_creation_service.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class TripCreationPlacePage extends StatefulWidget {
  const TripCreationPlacePage({
    super.key,
    required this.tripStartDate,
    required this.tripEndDate,
    required this.tripName,
  });
  final String tripName;
  final DateTime tripStartDate;
  final DateTime tripEndDate;

  @override
  State<TripCreationPlacePage> createState() => _TripCreationPlacePageState();
}

class _TripCreationPlacePageState extends State<TripCreationPlacePage> {
  final accomodationNameFieldController = TextEditingController();
  final checkInTimeFieldController = TextEditingController();
  final checkOutTimeFieldController = TextEditingController();
  final addressFieldController = TextEditingController();

  TimeOfDay? _checkInTime;
  TimeOfDay? _checkOutTime;

  int selectedDay = 0;

  bool _savePlacesData() {
    if (_checkInTime == null ||
        _checkOutTime == null ||
        accomodationNameFieldController.text == '' ||
        addressFieldController.text == '') {
      SnackbarController().showSnackbar(
        context: context,
        message: 'Please fill in all the fields',
        type: SnackbarTypes.error,
      );

      return false;
    }

    TripCreationPlace tripCreationPlace = TripCreationPlace(
      name: accomodationNameFieldController.text,
      address: addressFieldController.text,
      date: widget.tripStartDate.add(Duration(days: selectedDay)),
      checkInTime: _checkInTime!,
      checkOutTime: _checkOutTime!,
    );

    TripCreationService().addPlace(tripCreationPlace);

    return true;
  }

  void _pushToNextDay() {
    Navigator.of(context).push(
      CustomPageRoute(
        child: TripCreationPlacePage(
          tripName: widget.tripName,
          tripStartDate: widget.tripStartDate.add(const Duration(days: 1)),
          tripEndDate: widget.tripEndDate,
        ),
      ),
    );
  }

  void _addAnotherPlaceSameDay() {
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

  void _handleSubmitButton() async {
    bool isTravelSaved = await context.read<TripCreationCubit>().saveNewTrip(
          tripName: widget.tripName,
          tripData: TripCreationService().toJson(),
        );

    if (isTravelSaved) {
      if (mounted) {
        SnackbarController().showSnackbar(
          context: context,
          message: 'Your trip has been saved',
          type: SnackbarTypes.success,
        );

        TripCreationService().clearAll();
      }
    } else {
      if (mounted) {
        SnackbarController().showSnackbar(
          context: context,
          message: 'An error occurred. Please try again later',
          type: SnackbarTypes.error,
        );
      }
    }

    if (mounted) {
      Navigator.of(context).push(
        CustomPageRoute(
          child: const MainPage(),
        ),
      );
    }
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
                    labelText: 'Place to visit',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    fieldController: addressFieldController,
                    labelText: 'Address',
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: checkInTimeFieldController,
                    labelText: 'Check-in time',
                    onApplyClick: (checkInTime) {
                      setState(() {
                        _checkInTime = ModelConverter().convertStringHourToTimeOfDay(checkInTime);
                      });

                      checkInTimeFieldController.text = checkInTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: checkOutTimeFieldController,
                    labelText: 'Check-out time',
                    onApplyClick: (checkOutTime) {
                      setState(() {
                        _checkOutTime = ModelConverter().convertStringHourToTimeOfDay(checkOutTime);
                      });

                      checkOutTimeFieldController.text = checkOutTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        if (_savePlacesData()) {
                          _pushToNextDay();
                        }
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Add place to visit in next day',
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        if (_savePlacesData()) {
                          _addAnotherPlaceSameDay();
                        }
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Add place to visit in the same day',
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () async {
                        if (_savePlacesData()) {
                          _handleSubmitButton();
                        }
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Save trip',
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
