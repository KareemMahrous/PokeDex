part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignUpChangePassVisibilityState extends SignupState {}
class SignUpSuccess extends SignupState{}
class SignUpFailed extends SignupState{
  String error;
  SignUpFailed(this.error);
}
class SignupLoading extends SignupState{}
