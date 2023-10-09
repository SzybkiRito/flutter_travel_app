import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_planning_app/controllers/user_controller.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoadingEnabled = false;

  bool get isLoadingEnabled => _isLoadingEnabled;

  SignUpBloc() : super(SignUpInitial()) {
    on<SendSignUpRequest>((event, emit) async {
      if (_validateFields()) {
        _isLoadingEnabled = true;
        await _sendSignUpRequest(event, emit);
      } else {
        emit(SignUpError(errorMessage: 'Please fill in all fields.'));
      }
    });
  }

  Future<void> _sendSignUpRequest(SendSignUpRequest event, Emitter<SignUpState> emit) async {
    try {
      await UserController.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      _isLoadingEnabled = false;
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _isLoadingEnabled = false;
        emit(SignUpError(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        _isLoadingEnabled = false;
        emit(SignUpError(errorMessage: 'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        _isLoadingEnabled = false;
        emit(SignUpError(errorMessage: 'The email address is not valid.'));
      } else {
        _isLoadingEnabled = false;
        emit(SignUpError(errorMessage: 'An error occurred. Please try again later.'));
      }
    } finally {
      _isLoadingEnabled = false;
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.close();
  }

  bool _isNameFieldValid() {
    return nameController.text.isNotEmpty;
  }

  bool _isEmailFieldValid() {
    return emailController.text.isNotEmpty;
  }

  bool _isPasswordFieldValid() {
    return passwordController.text.isNotEmpty;
  }

  bool _isConfirmPasswordFieldValid() {
    return confirmPasswordController.text.isNotEmpty;
  }

  bool _isPasswordMatch() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool _validateFields() {
    return _isNameFieldValid() &&
        _isEmailFieldValid() &&
        _isPasswordFieldValid() &&
        _isConfirmPasswordFieldValid() &&
        _isPasswordMatch();
  }
}
