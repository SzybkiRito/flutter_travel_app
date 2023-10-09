part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SendSignInRequest extends SignInEvent {
  SendSignInRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
