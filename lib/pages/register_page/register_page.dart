import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_planning_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:travel_planning_app/constants/snackbar_types.dart';
import 'package:travel_planning_app/controllers/snackbar_controller.dart';
import 'package:travel_planning_app/custom_widgets/buttons/custom_text_button.dart';
import 'package:travel_planning_app/custom_widgets/fields/custom_text_field.dart';
import 'package:travel_planning_app/custom_widgets/fields/password_text_field.dart';
import 'package:travel_planning_app/default_styles_config.dart';
import 'package:travel_planning_app/pages/login_page/login_page.dart';
import 'package:travel_planning_app/themes/app_colors.dart';
import 'package:travel_planning_app/utility/custom_page_route.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: const RegisterPageContent(),
    );
  }
}

class RegisterPageContent extends StatelessWidget {
  const RegisterPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if (state is SignUpSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                signUpBloc.clearFields();
                Navigator.of(context).push(
                  CustomPageRoute(child: const LoginPage()),
                );
              });
            } else if (state is SignUpError) {
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
                    'Register',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Name',
                    fieldController: signUpBloc.nameController,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Email',
                    fieldController: signUpBloc.emailController,
                  ),
                  const SizedBox(height: 16.0),
                  PasswordTextField(
                    labelText: 'Password',
                    fieldController: signUpBloc.passwordController,
                  ),
                  const SizedBox(height: 16.0),
                  PasswordTextField(
                    labelText: 'Confirm password',
                    fieldController: signUpBloc.confirmPasswordController,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextButton(
                      onPressed: () {
                        signUpBloc.add(
                          SendSignUpRequest(
                            name: signUpBloc.nameController.text,
                            email: signUpBloc.emailController.text,
                            password: signUpBloc.passwordController.text,
                          ),
                        );
                      },
                      enableLoading: signUpBloc.isLoadingEnabled,
                      backgroundColor: AppColors.kDefaultDarkButtonColor,
                      text: 'Register',
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
            );
          },
        ),
      ),
    );
  }
}
