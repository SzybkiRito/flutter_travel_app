import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_planning_app/controllers/user_controller.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoadingEnabled = false;
  bool get isLoadingEnabled => _isLoadingEnabled;

  SignInBloc() : super(SignInInitial()) {
    on<SendSignInRequest>((event, emit) async {
      if (_validateFields(event, emit)) {
        _isLoadingEnabled = true;
        await _sendSignInRequest(event, emit);
      }
    });
  }

  Future<void> _sendSignInRequest(SendSignInRequest event, Emitter<SignInState> emit) async {
    try {
      await UserController.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      _isLoadingEnabled = false;
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _isLoadingEnabled = false;
        emit(SignInError(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        _isLoadingEnabled = false;
        emit(SignInError(errorMessage: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        _isLoadingEnabled = false;
        emit(SignInError(errorMessage: 'The email address is not valid.'));
      } else {
        _isLoadingEnabled = false;
        emit(SignInError(errorMessage: 'An error occurred. Please try again later.'));
      }
    } finally {
      _isLoadingEnabled = false;
    }
  }

  bool _validateFields(SendSignInRequest event, Emitter<SignInState> emit) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      emit(SignInError(errorMessage: 'Please fill in all fields'));
      return false;
    }
    return true;
  }
}
