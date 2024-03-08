import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/authentication/controller/autheratication_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/app_validation.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_login_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class LogInScreen extends StatelessWidget {



  LogInScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  SharedPrefService sharedPrefService=SharedPrefService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4),
        child: SingleChildScrollView(
          child:


            //child:
            Form(
              key: _formKey,
              child:



                      Obx(() =>
                       // child:
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 8,
                                    ),
                                    CustomText(
                        name: "Login to your ",
                        fontSize: SizeUtils.fSize_32(),
                        fontWeight: FontWeight.w600),
                                    CustomText(
                        name: "account.",
                        fontSize: SizeUtils.fSize_32(),
                        fontWeight: FontWeight.w600),
                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 1,
                                    ),
                                    CustomText(
                        name: "Please sign in to your account",
                        color: AppColor.blackLightColor.withOpacity(0.6),
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w600),
                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 5,
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
                        validator: (value) {
                          return AppValidation.validateMobile(value!);
                        },
                        textEditingController: authController.numberController,
                        hintText: "Enter Your Number"),
                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 1,
                                    ),

                         // child:
                            GestureDetector(onTap: () async {

                           await authController.sendOTP(context);

                          },
                            child:

                            Align(alignment: Alignment.topRight,
                              child: SizedBox(width: SizeUtils.horizontalBlockSize*30,height: SizeUtils.verticalBlockSize*6,child: CustomButton(childWidget: authController.isOtpSendLogin.value?const CircularProgressIndicator(color: AppColor.backGroundColor,):CustomText(fontSize: SizeUtils.fSize_14(),
                                name: "Send Otp",color: AppColor.backGroundColor,
                              ),))
                            ),
                          ),

                                    // CustomText(
                                    //     name: "Password",
                                    //     fontSize: SizeUtils.fSize_14(),
                                    //     fontWeight: FontWeight.w500),
                                    // SizedBox(
                                    //   height: SizeUtils.verticalBlockSize * 1,
                                    // ),
                                    //
                                    // Obx(
                                    //   () =>
                                    //       //  child:
                                    //       CustomTextField(
                                    //           obscureText: !authController.showPassword.value,
                                    //           counter: const SizedBox.shrink(),
                                    //           textEditingController:
                                    //               authController.passWordController,
                                    //           hintText: "Enter Your Password",
                                    //           suffixIcon: Padding(
                                    //               padding: const EdgeInsets.all(10.0),
                                    //               child: GestureDetector(
                                    //                 onTap: () {
                                    //                   authController.showPassword.value =
                                    //                       !authController.showPassword.value;
                                    //                 },
                                    //                 child: authController.showPassword.value
                                    //                     ? Image.asset(
                                    //                         "asset/images/show_password.png",
                                    //                         height: 1,
                                    //                         width: 1,
                                    //                         fit: BoxFit.fitWidth,
                                    //                       )
                                    //                     : Image.asset(
                                    //                         "asset/images/password_hind.png",
                                    //                         height: 1,
                                    //                         width: 1,
                                    //                         fit: BoxFit.fitWidth,
                                    //                       ),
                                    //               ))),
                                    // ),

                                    // SizedBox(
                                    //   height: SizeUtils.verticalBlockSize * 1,
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //       vertical: SizeUtils.verticalBlockSize * 2),
                                    //   child: Align(
                                    //     alignment: Alignment.centerRight,
                                    //     child: GestureDetector(
                                    //       onTap: () {
                                    //         Get.toNamed(Routes.forgetPasswordScreen);
                                    //       },
                                    //       child: CustomText(
                                    //           name: "Forget password",
                                    //           fontSize: SizeUtils.fSize_14(),
                                    //           color: AppColor.orangeColor,
                                    //           fontWeight: FontWeight.w500),
                                    //     ),
                                    //   ),
                                    // ),

                                    // SizedBox(
                                    //   height: SizeUtils.verticalBlockSize * 1,
                                    // ),

                                    // GestureDetector(
                                    //   onTap: () {
                                    //     if (_formKey.currentState!.validate()) {
                                    //       // Form is valid, perform your actions here
                                    //       print('Mobile number is valid');
                                    //       // You can access the validated value using _mobileController.text
                                    //     }
                                    //     else
                                    //       {
                                    //
                                    //         Get.toNamed(Routes.homeScreen);
                                    //       }
                                    //   },
                                    //   child: CustomButton(
                                    //     buttonName: "Sign in",
                                    //   ),
                                    // ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 4,
                        ),

                        GestureDetector(
                          onTap: () {

                            sharedPrefService.setSkipLogIn(true);
                            Get.offAndToNamed(Routes.homeScreen);
                            //Get.off(Routes.homeScreen);
                          },
                          child: CustomButton(
                            buttonName: "Skip",
                          ),
                        ),

                                    Padding(
                                            padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.verticalBlockSize * 3),
                                            child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: AppColor.blackLightColor.withOpacity(0.6),
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.horizontalBlockSize * 4),
                            child: CustomText(
                                name: "Or sign in with",
                                fontSize: SizeUtils.fSize_14(),
                                color: AppColor.blackLightColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: AppColor.blackLightColor.withOpacity(0.6),
                          )),
                        ],
                                            ),
                                    ),

                                  //  CustomLogInButton(boxWidth: SizeUtils.horizontalBlockSize * 10),
                                  //   SizedBox(
                                  //     height: SizeUtils.verticalBlockSize * 2,
                                  //   ),
                                    GestureDetector(onTap: () async {

                                    await  authController.signInWithGoogle();

                                    },
                                      child:authController.isGoogleLogin.value? Container(
                                          height: SizeUtils.verticalBlockSize * 6, decoration: BoxDecoration(
                                        color: AppColor.buttonColor,
                                        borderRadius: BorderRadius.circular(100),
                                      ),child: const Center(child: CircularProgressIndicator(backgroundColor: AppColor.blackColor,))): const CustomLogInButton(
                                              imageName: "asset/images/google_icon.png",
                                              logInButtonName: "Continue With Google",
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: SizeUtils.verticalBlockSize * 2,
                                    // ),
                                    // const CustomLogInButton(
                                    //   imageName: "asset/images/facebook_icon.png",
                                    //   logInButtonName: "Continue With Facebook",
                                    // ),

                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 3,
                                    ),
                                    GestureDetector(
                                            onTap: () {
                        Get.toNamed(Routes.signUpScreen);
                                            },
                                            child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              name: "Don't have an account?",
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            width: 3,
                          ),
                          CustomText(
                              name: "Register",
                              fontSize: SizeUtils.fSize_14(),
                              color: AppColor.orangeColor,
                              fontWeight: FontWeight.w600),
                        ],
                                            ),
                                    ),
                                    SizedBox(
                                            height: SizeUtils.verticalBlockSize * 3,
                                    ),
                                  ]),
                      ),

            ),

        ),
      ),
    );
  }
}
