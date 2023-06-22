import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon/constants/navigation_service.dart';
import 'package:pokemon/viewmodel/cubit/Login/login_cubit.dart';

import '../../../constants/color_manager.dart';
import '../../../constants/fonts.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            final snackBar = SnackBar(
              content: Text(state.error),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          LoginCubit myCubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const CustomText(
                          text: 'Login',
                          fontSize: textFont30,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          name: 'email',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextField(
                            controller: passwordController,
                            hintText: "Password",
                            keyboardType: TextInputType.text,
                            isPassword: myCubit.isPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                myCubit.changePasswordVisibility();
                              },
                              icon: !myCubit.isPassword
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: borderColor,
                                      size: textFont22,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: borderColor,
                                      size: textFont22,
                                    ),
                            ),
                            name: 'password',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Password is required.'),
                              FormBuilderValidators.minLength(8,
                                  errorText:
                                      'Password must be at least 8 characters long.'),
                              FormBuilderValidators.match(
                                r'^(?=.*?[A-Z])',
                                errorText:
                                    'Password must contain at least one uppercase letter.',
                              ),
                              FormBuilderValidators.match(
                                r'^(?=.*?[a-z])',
                                errorText:
                                    'Password must contain at least one lowercase letter.',
                              ),
                              FormBuilderValidators.match(
                                r'^(?=.*?[0-9])',
                                errorText:
                                    'Password must contain at least one digit.',
                              ),
                              FormBuilderValidators.match(
                                r'^(?=.*?[!@#\$&*~])',
                                errorText:
                                    'Password must contain at least one special character.',
                              ),
                            ])),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: borderColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12),
                            ),
                            onPressed: () {
                              NavigationService
                                  .instance.navigationKey!.currentState!
                                  .pushNamed("ForgetPasswordScreen");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 350.w,
                          height: 50.h,
                          child: CustomButton(
                            widget: const CustomText(
                              text: 'Login',
                              fontSize: btnFont16,
                              color: background,
                              fontWeight: FontWeight.w600,
                            ),
                            buttonColor: primaryColor,
                            borderRadius: 7,
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              print("user input is valid $emailController");
                              if (_formkey.currentState!.validate()) {
                                myCubit.login(email, password);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "Don't Have an account? ",
                                ),
                                TextSpan(
                                    text: 'Sign Up',
                                    style: const TextStyle(
                                      color: borderColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        NavigationService.instance
                                            .navigationKey!.currentState!
                                            .pushNamed(
                                          "SignUpScreen",
                                        );
                                      }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
