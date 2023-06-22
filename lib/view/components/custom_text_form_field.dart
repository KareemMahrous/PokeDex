import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/color_manager.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final bool isPassword;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    required this.name,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    this.obscureText = false,
    this.isEmail = false,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: key,
      name: name,
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: textFieldBackGround,
        filled: true,
        isDense: true,
        suffixIcon: suffixIcon,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: greyText2Color,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 16,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: validator,
    );
  }
}
