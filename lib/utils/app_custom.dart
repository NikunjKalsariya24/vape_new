import 'package:flutter/material.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class AppCustom{

  void showSnackBar({required BuildContext context, required Color snackBarColor,required String snackBarText,required Color snackBarTextColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackBarColor, // Change background color
        content: CustomText(

          name: snackBarText,color:snackBarTextColor ,fontWeight: FontWeight.w500,fontSize: SizeUtils.fSize_16(),
        ),


        duration: const Duration(seconds: 3), // Set duration here
      ),
    );
  }

}