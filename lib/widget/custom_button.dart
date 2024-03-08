import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  String? buttonName;
  double? containerHeight;
  Widget? childWidget;
   CustomButton({super.key,this.buttonName,this.containerHeight,this.childWidget});

  @override
  Widget build(BuildContext context) {
    return  Container(height: containerHeight??SizeUtils.verticalBlockSize*6,decoration: BoxDecoration(color: AppColor.orangeColor,borderRadius: BorderRadius.circular(100)),child: Center(
      child: childWidget??CustomText(fontSize: SizeUtils.fSize_14(),
        name: buttonName,color: AppColor.backGroundColor,
      ),
    ),);
  }
}
