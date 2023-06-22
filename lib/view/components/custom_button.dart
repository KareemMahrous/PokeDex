import 'package:flutter/material.dart';
import 'package:pokemon/constants/color_manager.dart';


class CustomButton extends StatelessWidget {
  Color buttonColor;
  VoidCallback? onPressed;

  CustomButton(
      {this.buttonColor = blueColor,
      this.onPressed,
      this.borderRadius = 10,
      required this.widget});

  double borderRadius;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
