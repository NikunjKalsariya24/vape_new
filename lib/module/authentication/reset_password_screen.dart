import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/authentication/controller/autheratication_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_textfield.dart';

import '../../widget/custom_text.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar:CustomAppBar(title:"Reset Password" ,backScreenOnTap: () {
        Get.back();
      },),
      // AppBar(
      //     elevation: 0,
      //     backgroundColor: AppColor.backGroundColor,
      //     leading: Row(
      //       children: [
      //         const SizedBox(
      //           width: 12,
      //         ),
      //         Image.asset(
      //           "asset/images/back_otp.png", width: 40, // Set the desired width
      //           height: 40,
      //         ),
      //       ],
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Center(
      //             child: CustomText(
      //           name: "Reset Password",
      //           fontSize: SizeUtils.fSize_16(),
      //           fontWeight: FontWeight.w600,
      //         )),
      //         SizedBox(
      //           width: SizeUtils.horizontalBlockSize * 12,
      //         )
      //       ],
      //     )),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomText(
              name: "Reset Password",
              fontSize: SizeUtils.fSize_32(),
              fontWeight: FontWeight.w600),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomText(
              name:
                  "Your new password must be different from the previously used password",
              fontSize: SizeUtils.fSize_14(),
              color: AppColor.blackLightColor.withOpacity(0.6),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 4,
          ),
          CustomText(
              name: "New Password",
              fontSize: SizeUtils.fSize_14(),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          Obx(
            () =>
                //  child:
                CustomTextField(
                    obscureText: !authController.newShowPassword.value,
                    counter: const SizedBox.shrink(),
                    textEditingController: authController.newPassWordController,
                    hintText: "Enter Your Password",
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            authController.newShowPassword.value =
                                !authController.newShowPassword.value;
                          },
                          child: authController.newShowPassword.value
                              ? Image.asset(
                                  "asset/images/show_password.png",
                                  height: 1,
                                  width: 1,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  "asset/images/password_hind.png",
                                  height: 1,
                                  width: 1,
                                  fit: BoxFit.fitWidth,
                                ),
                        ))),
          ),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 2,
          ),
          CustomText(
              name: "Confirm Password",
              fontSize: SizeUtils.fSize_14(),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          Obx(
            () =>
                //  child:
                CustomTextField(
                    obscureText: !authController.confirmShowPassword.value,
                    counter: const SizedBox.shrink(),
                    textEditingController:
                        authController.confirmPassWordController,
                    hintText: "Enter Your Password",
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            authController.confirmShowPassword.value =
                                !authController.confirmShowPassword.value;
                          },
                          child: authController.confirmShowPassword.value
                              ? Image.asset(
                                  "asset/images/show_password.png",
                                  height: 1,
                                  width: 1,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  "asset/images/password_hind.png",
                                  height: 1,
                                  width: 1,
                                  fit: BoxFit.fitWidth,
                                ),
                        ))),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: AppColor.backGroundColor,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: SizeUtils.verticalBlockSize * 60,
                      width: SizeUtils.screenWidth,
                      decoration: const BoxDecoration(
                          color: AppColor.backGroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Column(children: [
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),
                        Container(
                          height: 5,
                          width: SizeUtils.horizontalBlockSize * 16,
                          decoration: BoxDecoration(
                              color: AppColor.textFieldColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 3,
                        ),
                        Image.asset(
                          "asset/images/reset_password_icon.png",
                          height: SizeUtils.verticalBlockSize * 25,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 3,
                        ),
                        CustomText(
                            name: "Password Changed",
                            fontSize: SizeUtils.fSize_24(),
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),
                        CustomText(
                            name:
                                "Password changed successfully, you can login again with a new password",
                            fontSize: SizeUtils.fSize_14(),
                            color: AppColor.blackLightColor.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.horizontalBlockSize * 6),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.homeScreen);
                              },
                              child:
                                  CustomButton(buttonName: "Verify Account")),
                        ),
                        // SizedBox(
                        //   height: SizeUtils.verticalBlockSize * 3,
                        // ),
                      ]),
                    );
                  },
                );

                //  Get.toNamed(Routes.otpScreen);
              },
              child: CustomButton(
                buttonName: "Verify Account",
              )),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 3,
          ),
        ]),
      ),
    );
  }
}
