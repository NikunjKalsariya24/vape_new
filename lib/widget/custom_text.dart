import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vape/utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String? name;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final  Color? decorationColor;
  final  int? maxLines;

  const CustomText(
      {super.key,
      this.name,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign,this.decoration,this.decorationColor,this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,maxLines: maxLines,overflow: TextOverflow.ellipsis,
      name ?? "",
      style: GoogleFonts.inter(decoration: decoration,decorationColor: decorationColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? AppColor.textColor),
    );
  }
}
