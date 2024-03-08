import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/authentication/controller/autheratication_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.verticalBlockSize * 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 8,
          ),
          CustomText(
              name: "Forgot password?",
              fontSize: SizeUtils.fSize_30(),
              fontWeight: FontWeight.w600),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomText(
              name:
                  "Enter your email address and we’ll send you confirmation code to reset your password",
              fontSize: SizeUtils.fSize_13(),
              color: AppColor.blackLightColor.withOpacity(0.6),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 3,
          ),
          CustomText(
              name: "Phone Number",
              fontSize: SizeUtils.fSize_14(),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomTextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              counter: const SizedBox.shrink(),
              textEditingController: authController.forgetNumberController,
              hintText: "Enter Your Number"),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.otpScreen);
              },
              child: CustomButton(
                buttonName: "Continue",
              )),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 3,
          ),
        ]),
      ),
    );
  }
}
