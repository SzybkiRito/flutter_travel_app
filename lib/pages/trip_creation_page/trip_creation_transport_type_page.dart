import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_planning_app/bloc/trip_creation/trip_creation_cubit.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/constants/transport_type.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_select_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/time_field.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/helpers/model_converter.dart';
import 'package:travel_planning_app/models/trip_creation_travel.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_accomodation_page.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_circle_days_bar.dart';
import 'package:travel_planning_app/services/trip_creation_service.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class TripCreationTransportTypePage extends StatefulWidget {
  const TripCreationTransportTypePage({
    super.key,
    required this.tripName,
    required this.tripStartDate,
    required this.tripEndDate,
  });
  final String tripName;
  final DateTime tripStartDate;
  final DateTime tripEndDate;

  @override
  State<TripCreationTransportTypePage> createState() => _TripCreationTransportTypePageState();
}

class _TripCreationTransportTypePageState extends State<TripCreationTransportTypePage> {
  final TextEditingController fileFieldController = TextEditingController();
  final TextEditingController departureTimeFieldController = TextEditingController();
  final TextEditingController arrivalTimeFieldController = TextEditingController();
  final TextEditingController currentCityFieldController = TextEditingController();
  final TextEditingController destinationCityFieldController = TextEditingController();
  late TimeOfDay? _departureTime;
  late TimeOfDay? _arrivalTime;
  String _fileFieldLabel = 'Add PDF transport ticket (optional)';
  String _filePath = '';
  String _flightType = '';
  int _selectedDay = 0;

  bool _saveTransportData() {
    if (_flightType == '' ||
        _departureTime == null ||
        _arrivalTime == null ||
        currentCityFieldController.text == '' ||
        destinationCityFieldController.text == '') {
      SnackbarController().showSnackbar(
        context: context,
        message: 'Please fill in all the fields',
        type: SnackbarTypes.error,
      );

      return false;
    }

    Transport transport = Transport(
      id: _selectedDay,
      date: widget.tripStartDate,
      type: TransportType.values.byName(_flightType.toLowerCase()),
      departureTime: _departureTime!,
      arrivalTime: _arrivalTime!,
      filePath: _filePath,
      currentCity: currentCityFieldController.text,
      destinationCity: destinationCityFieldController.text,
    );

    TripCreationService().addTransport(transport);

    return true;
  }

  void _pushToNextStage() {
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

  void _pushToAddAnotherTransport() {
    Navigator.of(context).push(
      CustomPageRoute(
        child: TripCreationTransportTypePage(
          tripName: widget.tripName,
          tripStartDate: widget.tripStartDate,
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
                    _selectedDay = day;
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
                  CustomSelectField(
                    options: const ['Flight', 'Train', 'Bus', 'Car'],
                    onOptionSelected: (option) {
                      if (option != null) {
                        setState(() {
                          _flightType = option;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    fieldController: currentCityFieldController,
                    labelText: 'Current city',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    fieldController: destinationCityFieldController,
                    labelText: 'Destination city',
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: departureTimeFieldController,
                    labelText: 'Departure time',
                    onApplyClick: (deperatureTime) {
                      setState(() {
                        _departureTime = ModelConverter().convertStringHourToTimeOfDay(deperatureTime);
                      });

                      departureTimeFieldController.text = deperatureTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  TimeField(
                    fieldController: arrivalTimeFieldController,
                    labelText: 'Estimated arrival',
                    onApplyClick: (arrivalTime) {
                      setState(() {
                        _arrivalTime = ModelConverter().convertStringHourToTimeOfDay(arrivalTime);
                      });

                      arrivalTimeFieldController.text = arrivalTime;
                    },
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      FilePicker.platform
                          .pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                        allowMultiple: false,
                      )
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _fileFieldLabel = value.files.single.name;
                            _filePath = value.files.single.path!;
                          });
                        }
                      });
                    },
                    child: CustomTextField(
                      fieldController: fileFieldController,
                      labelText: _fileFieldLabel,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomTextButton(
                        onPressed: () {
                          if (_saveTransportData()) {
                            _pushToAddAnotherTransport();
                          }
                        },
                        backgroundColor: AppColors.kDefaultDarkButtonColor,
                        text: 'Add another transport',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomTextButton(
                        onPressed: () {
                          if (_saveTransportData()) {
                            _pushToNextStage();
                          }
                        },
                        backgroundColor: AppColors.kDefaultDarkButtonColor,
                        text: 'Save transport',
                      ),
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
