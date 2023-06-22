import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon/constants/fonts.dart';
import 'package:pokemon/view/components/custom_text_form_field.dart';
import 'package:pokemon/viewmodel/cubit/SignUp/signup_cubit.dart';

import '../../../constants/color_manager.dart';
import '../../../constants/navigation_service.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignUpFailed) {
            final snackBar = SnackBar(
              content: Text(state.error),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          SignupCubit myCubit = SignupCubit.get(context);
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const CustomText(
                            text: 'Sign Up',
                            fontSize: textFont30,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          CustomTextField(
                            controller: myCubit.emailController,
                            hintText: "email",
                            keyboardType: TextInputType.emailAddress,
                            name: 'email',

                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextField(
                              controller: myCubit.passwordController,
                              hintText: "Password",
                              keyboardType: TextInputType.text,
                              obscureText: true,
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
                          SizedBox(
                            height: 60.h,
                          ),
                          SizedBox(
                            width: 350.w,
                            height: 50.h,
                            child: CustomButton(
                              widget: const CustomText(
                                text: 'Sign Up',
                                fontSize: btnFont16,
                                color: background,
                                fontWeight: FontWeight.w600,
                              ),
                              buttonColor: primaryColor,
                              borderRadius: 7,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  myCubit.signup();
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
                                    text: "Already Have an account? ",
                                  ),
                                  TextSpan(
                                      text: 'Login',
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
                                            "LoginScreen",
                                          );
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
