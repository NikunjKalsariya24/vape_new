import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/splash_screen/controller/splash_controller.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Image.asset("asset/images/splash_screen_image.png",
          height: SizeUtils.screenHeight * 100,
          width: SizeUtils.screenWidth * 100),
    );
  }
}
