import 'package:flutter/material.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/carousel/carousel.dart';
import 'package:travel_planning_app/custom_widgets/text_logo_row.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/pages/login_page/login_page.dart';
import 'package:travel_planning_app/pages/register_page/register_page.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DefaultStylesConfig.kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextLogoRow(logoPath: 'assets/icons/suitcase.svg', appName: 'Travel Planning App'),
              const Expanded(
                child: Carousel(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Effortles travel',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    'Planning Made Simple',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(child: const RegisterPage()),
                        );
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Get Started',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(child: const LoginPage()),
                        );
                      },
                      backgroundColor: AppColors.kDefaultLightButtonColor,
                      textColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Already have an account? Login',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
