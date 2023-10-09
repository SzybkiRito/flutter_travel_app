part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SendSignUpRequest extends SignUpEvent {
  SendSignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
