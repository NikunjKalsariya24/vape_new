import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
// bottomNavigationBar: Align(alignment:Alignment.bottomCenter ,
//   child: Column(children: [
//   CustomButton(),
//     SizedBox(
//       height: SizeUtils.verticalBlockSize * 3,
//     ),
//
//   ]),
// ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.backGroundColor,
          leading: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Image.asset(
                "asset/images/back_otp.png", width: 40, // Set the desired width
                height: 40,
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: CustomText(
                name: "OTP",
                fontSize: SizeUtils.fSize_16(),
                fontWeight: FontWeight.w600,
              )),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 12,
              )
            ],
          )),

      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomText(
              name: "Email verification",
              fontSize: SizeUtils.fSize_32(),
              fontWeight: FontWeight.w600),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 1,
          ),
          CustomText(
              name: "Enter the verification code we send you on:",
              fontSize: SizeUtils.fSize_14(),
              color: AppColor.blackLightColor.withOpacity(0.6),
              fontWeight: FontWeight.w500),
          CustomText(
              name: "+91 9998880000",
              fontSize: SizeUtils.fSize_14(),
              color: AppColor.blackLightColor.withOpacity(0.6),
              fontWeight: FontWeight.w500),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 4,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Pinput(
              //   controller: otp,
              onChanged: (value) {
                // if (otp.text.length == 6) {
                //
                //   print("phoneController=====${authController.phoneController.text}");
                //   print("otp=========${otp.text}");
                //   authController.Verify_OTP(authController.phoneController.text,otp.text,"ok");
                //
                // } else {
                //   // showCustomSnackBar("OTP is invalid !", isError: true);
                // }
              },
              defaultPinTheme: PinTheme(
                  height: SizeUtils.verticalBlockSize * 10,
                  width: SizeUtils.horizontalBlockSize * 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.textFieldColor),
                  )),
              length: 4,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
          ),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  name: "Didn’t receive code?",
                  fontSize: SizeUtils.fSize_14(),
                  color: AppColor.blackLightColor.withOpacity(0.6),
                  fontWeight: FontWeight.w500),
              CustomText(
                  name: "Resend",
                  fontSize: SizeUtils.fSize_14(),
                  color: AppColor.orangeColor,
                  fontWeight: FontWeight.w600),
            ],
          ),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/images/clock.png",
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 6,
              ),
              CustomText(
                  name: "09:00",
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w500),
            ],
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.resetPasswordScreen);
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
