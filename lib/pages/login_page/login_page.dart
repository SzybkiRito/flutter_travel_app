import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/password_text_field.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/pages/main_page/main_page.dart';
import 'package:travel_planning_app/pages/register_page/register_page.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: const LoginPageContent(),
    );
  }
}

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<SignInBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            if (state is SignInSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(
                  CustomPageRoute(child: const MainPage()),
                );
              });
            } else if (state is SignInError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                SnackbarController().showSnackbar(
                  context: context,
                  message: state.errorMessage,
                  type: SnackbarTypes.error,
                );
              });
            }

            return Padding(
              padding: EdgeInsets.all(DefaultStylesConfig.kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Your email',
                    fieldController: signInBloc.emailController,
                  ),
                  const SizedBox(height: 16.0),
                  PasswordTextField(
                    labelText: 'Password',
                    fieldController: signInBloc.passwordController,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        signInBloc.add(SendSignInRequest(
                          email: signInBloc.emailController.text,
                          password: signInBloc.passwordController.text,
                        ));
                      },
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Login',
                    ),
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
                      backgroundColor: AppColors.kDefaultLightButtonColor,
                      textColor: AppColors.kDefaultDarkButtonColor,
                      enableLoading: signInBloc.isLoadingEnabled,
                      text: 'Don\'t have an account? Sign up',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
