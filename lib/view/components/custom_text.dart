import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
 final String text;
 final double height;
 final int maxLines;
 final Color color;
 final double fontSize;
 final FontWeight fontWeight;
 final String fontFamily;
 final TextDecoration decoration;
 final TextAlign textAlign;
  const CustomText(
      {Key? key,
      required this.text,
      this.decoration = TextDecoration.none,
      this.textAlign = TextAlign.start,
      this.color = Colors.white,
      required this.fontSize,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = '',
        this.maxLines =20,
      this.height = 0})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.vazirmatn(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        decoration: decoration,
        height: height,

      ),
      textAlign: textAlign,
    );
  }
}
