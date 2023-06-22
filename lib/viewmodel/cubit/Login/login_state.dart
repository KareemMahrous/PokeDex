part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginChangePassVisibilityState extends LoginState{}
class LoginSuccess extends LoginState{}
class LoginFailed extends LoginState{
  String error;
  LoginFailed(this.error);
}
class LoginLoading extends LoginState{}
