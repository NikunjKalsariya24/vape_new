import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CustomLogInButton extends StatelessWidget {
  final String? imageName;
  final String? logInButtonName;
  final double? boxWidth;


  const CustomLogInButton(
      {super.key, this.imageName, this.logInButtonName, this.boxWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.verticalBlockSize * 6,
      decoration: BoxDecoration(
        color: AppColor.buttonColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(children: [
        SizedBox(
          width: SizeUtils.verticalBlockSize * 2,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(imageName ?? "asset/images/apple_icon.png"),
        ),
        SizedBox(
          width: boxWidth ?? SizeUtils.verticalBlockSize * 4,
        ),
        CustomText(
            fontSize: SizeUtils.fSize_14(),
            name: logInButtonName ?? "Continue With Apple",
            color: AppColor.buttonTextColor,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center)
      ]),
    );
  }
}
