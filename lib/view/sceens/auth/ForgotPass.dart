import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon/constants/navigation_service.dart';
import 'package:pokemon/viewmodel/cubit/Login/login_cubit.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../constants/color_manager.dart';
import '../../../constants/fonts.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => NavigationService
                .instance.navigationKey!.currentState!
                .popAndPushNamed("LoginScreen"),
            icon: const Icon(Icons.arrow_back_ios_new,color: borderColor,)),
      ),
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  const CustomText(
                    text: 'Forget Password',
                    fontSize: textFont30,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 60.h,
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
                  SizedBox(
                    width: 350.w,
                    height: 50.h,
                    child: CustomButton(
                      widget: const CustomText(
                        text: 'Send email',
                        fontSize: btnFont16,
                        color: background,
                        fontWeight: FontWeight.w600,
                      ),
                      buttonColor: primaryColor,
                      borderRadius: 7,
                      onPressed: () {
                        String email = emailController.text;
                        forgetPass(email, context);
                        print("user input is valid $emailController");
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void forgetPass(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => {
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                    });
                    return AlertDialog(
                        alignment: Alignment.center,
                        backgroundColor: background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        content: const Text(
                          'an email has been sent ',
                          style: TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ));
                  },
                ),
                print('email sent'),
              });
    } on FirebaseAuthException catch (e) {
      print("Error ${e}");
    }
  }
}
