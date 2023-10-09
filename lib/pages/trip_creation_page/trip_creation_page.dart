import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/bloc/trip_creation/trip_creation_cubit.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/calendar_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_transport_type_page.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class TripCreationPage extends StatefulWidget {
  const TripCreationPage({super.key});

  @override
  State<TripCreationPage> createState() => _TripCreationPageState();
}

class _TripCreationPageState extends State<TripCreationPage> {
  final TextEditingController _tripNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DefaultStylesConfig.kDefaultPadding),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Plan your new trip',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 28,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fill in the information below and start planning your trip',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                fieldController: _tripNameController,
                labelText: 'Where to',
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarField(
                labelText: 'Travel dates',
                onApplyClick: (start, end) {
                  context.read<TripCreationCubit>().setTripDates(
                        startDate: start,
                        endDate: end,
                      );
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  onPressed: () async {
                    final startDate = context.read<TripCreationCubit>().startDate;
                    final endDate = context.read<TripCreationCubit>().endDate;

                    if (_tripNameController.text.isEmpty || startDate == null || endDate == null) {
                      SnackbarController().showSnackbar(
                        context: context,
                        message: 'Please enter trip name or dates',
                        type: SnackbarTypes.error,
                      );
                      return;
                    }

                    Navigator.of(context).push(
                      CustomPageRoute(
                        child: TripCreationTransportTypePage(
                          tripName: _tripNameController.text,
                          tripStartDate: startDate,
                          tripEndDate: endDate,
                        ),
                      ),
                    );
                  },
                  text: 'Start planning',
                  backgroundColor: AppColors.kDefaultDarkButtonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
