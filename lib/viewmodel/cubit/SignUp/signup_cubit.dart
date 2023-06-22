import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/constants/navigation_service.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;

  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    print("show password");
    emit(SignUpChangePassVisibilityState());
  }

  Future signup() async {
    emit(SignupLoading());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) => {
              NavigationService.instance.navigationKey!.currentState!
                  .pushNamed("BottomNavBar"),
              print(value.user!.refreshToken),
              emit(SignUpSuccess())
            })
        .catchError((error) {
      print(error);

      emit(SignUpFailed(error));
    return error;
        });
  }
}
