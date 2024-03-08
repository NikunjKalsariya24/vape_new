import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final Widget? counter;
  final  String? Function(String?)? validator;
  final Color? fillColor;
 final bool? filled;
  final Widget? suffix;
  final Widget? prefix;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final Color? hintTextColor;
  final Color? textColor;
  final String? initialValue;
  final  void Function(String)? onChanged;
  final  void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.textEditingController,
      this.keyboardType,
      this.obscureText,
      this.suffixIcon,
      this.maxLength,this.initialValue,
      this.counter,this.fillColor,this.suffix,this.prefix,this.focusedBorder,this.enabledBorder,this.border,this.hintTextColor,this.textColor,this.onChanged,this.onSaved,this.textInputAction,
     this.onFieldSubmitted, this.validator, this.filled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:textInputAction,clipBehavior: Clip.hardEdge,
      maxLines: 1,
      maxLength: maxLength,initialValue: initialValue,
      controller: textEditingController,onChanged: onChanged,onSaved: onSaved,onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false, validator: validator,
      style: GoogleFonts.inter(
          fontSize: SizeUtils.fSize_14(), fontWeight: FontWeight.w500,color:textColor?? AppColor.textColor),
      autofocus: false,
      decoration: InputDecoration(    filled: filled??false,
          fillColor: fillColor??Colors.grey[200],
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
              fontSize: SizeUtils.fSize_14(),
              color: hintTextColor??AppColor.blackLightColor.withOpacity(0.6)),suffix: suffix,
          contentPadding:
              const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
          isDense: true,
          suffixIcon: suffixIcon,
          counter: counter,prefix: prefix,
          focusedBorder:focusedBorder?? OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.textFieldColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: enabledBorder??OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.textFieldColor),
              borderRadius: BorderRadius.circular(10)),
          border: border??OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.textFieldColor),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
