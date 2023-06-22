import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/constants/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon/viewmodel/database/local/cache_helper.dart';
import 'package:pokemon/viewmodel/database/local/keys.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool isPassword = true;

  static LoginCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    print("show password");
    emit(LoginChangePassVisibilityState());
  }

  Future login(String email, String password) async {
    emit(LoginLoading());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              print(value.user!.refreshToken),
              NavigationService.instance.navigationKey!.currentState!
                  .pushNamed("BottomNavBar"),
              CacheHelper.set(
                  key: Keys.userToken, value: value.user!.refreshToken),
              emit(LoginSuccess())
            })
        .catchError((error) =>
            {
              if (error is FirebaseAuthException){
              print(error),
              emit(LoginFailed(error.message!.toString().trim()))
            }});
  }
}
