import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/constants/fonts.dart';
import 'package:pokemon/view/components/custom_text.dart';

import '../../../constants/color_manager.dart';

Widget PokemonCard(
    {required String pokemonName,
    required VoidCallback onPressed,
    required Icon icon}) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.h),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.h),
        side: const BorderSide(
            width: 2, style: BorderStyle.solid, color: borderColor)),
    shadowColor: borderColor,
    elevation: 5,
    color: primaryColor,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: pokemonName,
            fontSize: textFont20,
            color: greyText2Color,
          ),
          IconButton(onPressed: onPressed, icon: icon)
        ],
      ),
    ),
  );
}
