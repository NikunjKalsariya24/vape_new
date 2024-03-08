import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:vape/model/email_logIn_model.dart';
import 'package:vape/model/login_phone_model.dart';
import 'package:vape/module/home_page/home_screen.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/app_custom.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class AuthController extends GetxController {
  GraphQLService graphQLService = GraphQLService();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController forgetNumberController = TextEditingController();
  TextEditingController signUpNumberController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController signUpPassWordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  TextEditingController signupEmailOtpController = TextEditingController();
  TextEditingController signupNameOtpController = TextEditingController();
  AppCustom appCustom = AppCustom();
  RxBool showPassword = false.obs;
  RxBool newShowPassword = false.obs;
  RxBool confirmShowPassword = false.obs;
  RxBool signUpShowPassword = false.obs;
  RxBool terms = false.obs;
  RxBool signUpToEmail = false.obs;

  RxString phoneNumber = "".obs;

  RxBool isOtpSendLogin = false.obs;

  RxString _verificationId = "".obs;

  RxBool isPhoneNumberRegister = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  RxString notCorrectOtp = "".obs;

  RxBool isVerifyOtp = false.obs;

  Data? logInPhoneModel;

  SharedPrefService sharedPrefService = SharedPrefService();

  RxBool isGoogleLogin = false.obs;
  EmailLogInData? emailLogInModel;

  // RxString _verificationId = ''.obs;
  //
  // Future<void> _sendOTP({required void Function(String, int?) codeSent}) async {
  //
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: numberController.text,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       print('Verification failed: ${e.message}');
  //     },
  //     codeSent:codeSent,
  //
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //
  //     },
  //
  //   );

  Future<void> _sendOTP(BuildContext context) async {
    phoneNumber.value = numberController.text.trim();
    if (phoneNumber.value.isEmpty) {
      appCustom.showSnackBar(
          context: context,
          snackBarColor: AppColor.redBoxColor,
          snackBarText: "Phone number is empty",
          snackBarTextColor: AppColor.backGroundColor);
      print('Phone number is empty');
      return;
    } else if (phoneNumber.value.length != 10) {
      appCustom.showSnackBar(
          context: context,
          snackBarColor: AppColor.redBoxColor,
          snackBarText: "please enter valid Phone number",
          snackBarTextColor: AppColor.backGroundColor);
      return;
    }

    isOtpSendLogin = true.obs;

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      print("abc==== ${"+91${phoneNumber}"}");
      await auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          appCustom.showSnackBar(
              context: context,
              snackBarColor: AppColor.redBoxColor,
              snackBarText: "${e.message}",
              snackBarTextColor: AppColor.backGroundColor);

          isOtpSendLogin = false.obs;
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId.value = verificationId;

          print("_verificationId===${_verificationId}");

          getCustomerStatus(context);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error sending OTP: $e');
      appCustom.showSnackBar(
          context: context,
          snackBarColor: AppColor.redBoxColor,
          snackBarText: "${e}",
          snackBarTextColor: AppColor.backGroundColor);

      isOtpSendLogin = false.obs;
    }
  }

  Future<void> getCustomerStatus(context) async {
    phoneNumber.value = numberController.text.trim();
    if (phoneNumber.value.isEmpty) {
      print('Phone number is empty');
      return;
    }

    isPhoneNumberRegister?.value =
        await graphQLService.getCustomerOtpVerification(phoneNumber.value);
    print("isPhoneNumberRegister===${isPhoneNumberRegister}");

    if (isPhoneNumberRegister!.value == false) {
      print("in if");

      isOtpSendLogin.value = false;
      getOtpDialog(context);

    } else {
      print("in else");

      isOtpSendLogin.value = false;

      getLogInDialog(context);
    }
  }

  void getOtpDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 3),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: SizeUtils.verticalBlockSize * 6,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColor.backGroundColor),
                          child: Center(
                              child: CustomText(
                            name: "Verify Your Otp",
                            fontSize: SizeUtils.fSize_20(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ))),
                      CustomText(
                        name: "Email",
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomTextField(
                        textEditingController: signupEmailOtpController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            print("Email is required");
                            return 'Email is required';
                          } else if (!EmailValidator.validate(value)) {
                            print("Invalid email format");
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomText(
                        name: "Name",
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomTextField(
                        textEditingController: signupNameOtpController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                        },
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomText(
                        name: "Otp Code",
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Pinput(
                          controller: otp,
                          onChanged: (value) {
                            if (otp.text.length == 6) {
                              // print("phoneController=====${authController.phoneController.text}");
                              // print("otp=========${otp.text}");
                              // authController.Verify_OTP(authController.phoneController.text,otp.text,"ok");
                            } else {
                              // showCustomSnackBar("OTP is invalid !", isError: true);
                            }
                          },
                          defaultPinTheme: PinTheme(
                              height: 43,
                              width: 47,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              )),
                          length: 6,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        ),
                      ),
                      CustomText(
                          name: notCorrectOtp.value,
                          color: AppColor.redBoxColor),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                signupEmailOtpController.clear();
                                signupNameOtpController.clear();
                                otp.clear();
                                notCorrectOtp.value = "";

                                Get.back();
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.textFieldColor),
                                child: Center(
                                  child: CustomText(
                                    name: "cancle",
                                    fontSize: SizeUtils.fSize_16(),
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.backGroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 4,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {


                                  print("log in user");
                                  print("${otp.text}");
                                  print("${signupEmailOtpController.text}");
                                  print("${signupNameOtpController.text}");
                                  print("${numberController.text}");
                                  verifyOTP(
                                      otp.text,
                                      signupEmailOtpController.text.trim(),
                                      signupNameOtpController.text.trim(),
                                      numberController.text.trim(),
                                      context);
                                }
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.greenColor),
                                child: Center(
                                  child: isVerifyOtp.value
                                      ? const CircularProgressIndicator(
                                          color: AppColor.backGroundColor,
                                        )
                                      : CustomText(
                                          name: "Verify Code",
                                          fontSize: SizeUtils.fSize_16(),
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.backGroundColor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            decoration:
                                const BoxDecoration(color: AppColor.blackColor),
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          const CustomText(
                            name: "or",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            decoration:
                                const BoxDecoration(color: AppColor.blackColor),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          signupEmailOtpController.clear();
                          signupNameOtpController.clear();
                          otp.clear();
                          notCorrectOtp = "".obs;

                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              name: "Back to",
                              fontSize: SizeUtils.fSize_20(),
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              name: "Log In",
                              fontSize: SizeUtils.fSize_20(),
                              fontWeight: FontWeight.w600,
                              color: AppColor.greenColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getLogInDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: SizeUtils.verticalBlockSize * 6,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColor.backGroundColor),
                        child: Center(
                            child: CustomText(
                          name: "Verify Your Otp",
                          fontSize: SizeUtils.fSize_20(),
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackColor,
                        ))),
                    CustomText(
                      name: "Otp Code",
                      fontSize: SizeUtils.fSize_16(),
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Pinput(
                        controller: otp,
                        onChanged: (value) {
                          if (otp.text.length == 6) {
                            // print("phoneController=====${authController.phoneController.text}");
                            // print("otp=========${otp.text}");
                            // authController.Verify_OTP(authController.phoneController.text,otp.text,"ok");
                          } else {
                            // showCustomSnackBar("OTP is invalid !", isError: true);
                          }
                        },
                        defaultPinTheme: PinTheme(
                            height: 43,
                            width: 47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            )),
                        length: 6,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                    ),
                    CustomText(
                        name: notCorrectOtp.value, color: AppColor.redBoxColor),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              otp.clear();
                              notCorrectOtp.value = "";

                              Get.back();
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.textFieldColor),
                              child: Center(
                                child: CustomText(
                                  name: "cancle",
                                  fontSize: SizeUtils.fSize_16(),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.backGroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 4,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              verifyOTP(
                                  otp.text,
                                  signupEmailOtpController.text.trim(),
                                  signupNameOtpController.text.trim(),
                                  numberController.text.trim(),
                                  context);
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.greenColor),
                              child: Center(
                                child: isVerifyOtp.value
                                    ? const CircularProgressIndicator(
                                        color: AppColor.backGroundColor,
                                      )
                                    : CustomText(
                                        name: "Verify Code",
                                        fontSize: SizeUtils.fSize_16(),
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.backGroundColor,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          decoration:
                              const BoxDecoration(color: AppColor.blackColor),
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        const CustomText(
                          name: "or",
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Container(
                          height: 1,
                          decoration:
                              const BoxDecoration(color: AppColor.blackColor),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        signupEmailOtpController.clear();
                        signupNameOtpController.clear();
                        otp.clear();
                        notCorrectOtp.value = "";

                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            name: "Back to",
                            fontSize: SizeUtils.fSize_20(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            name: "Log In",
                            fontSize: SizeUtils.fSize_20(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.greenColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> verifyOTP(
      String getOtp, String email, String name, String phone, context) async {
    print("email===${email}");
    print("name===${name}");
    print("phone===${phone}");

    isVerifyOtp.value = true;

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId.value,
        smsCode: getOtp,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      print("OTP verified successfully: $userCredential");

      getVerify(email, name, phone);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      // Show error message to the user

      isVerifyOtp.value = false;

      notCorrectOtp.value = "Enter Otp is not Valid";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to verify OTP. ${e.message}"),
        ),
      );
    } catch (e) {
      isVerifyOtp.value = false;

      // Handle other exceptions
      print("Error verifying OTP: $e");
      // Show generic error message to the user
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Failed to verify OTP. Please try again later."),
      //   ),
      // );
    }
  }

  Future<void> getVerify(String email, String name, String phone) async {
    logInPhoneModel = await graphQLService.otpVerification(name, email, phone);

    print("loginpage=======${logInPhoneModel!.rcustomeotpverification}");
    // print("logInPhoneModel======${logInPhoneModel}");
    // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.role}");
    // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.permissions!.first}");
    // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.role!}");
    if (logInPhoneModel!.rcustomeotpverification != null) {
      print("logInPhoneModel======${logInPhoneModel!.rcustomeotpverification!.token}");
      numberController.clear();
      signupEmailOtpController.clear();
      signupNameOtpController.clear();
      otp.clear();
      sharedPrefService.setSkipLogIn(false);
      sharedPrefService.setLogIn(true);
      sharedPrefService
          .setToken(logInPhoneModel!.rcustomeotpverification!.token!);
      sharedPrefService.setPermission(
          logInPhoneModel!.rcustomeotpverification!.permissions!.first);
      sharedPrefService
          .setRole(logInPhoneModel!.rcustomeotpverification!.role!);
      print("token=====${sharedPrefService.getToken()}");
      print("token=====${sharedPrefService.getPermission()}");
      print("token=====${sharedPrefService.getRole()}");

      isVerifyOtp.value = false;

      Get.off(const HomeScreen());
    } else {
      isVerifyOtp.value = false;
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    phoneNumber.value = numberController.text.trim();
    if (phoneNumber.value.isEmpty) {
      //appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "Phone number is empty", snackBarTextColor: AppColor.backGroundColor);
      print('Phone number is empty');
      return;
    } else if (phoneNumber.value.length != 10) {
      //  appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "please enter valid Phone number", snackBarTextColor: AppColor.backGroundColor);
      return;
    }

    isOtpSendLogin.value = true;
    print("isOtpSendLogin===========${isOtpSendLogin}");

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      print("abc==== ${"+91${phoneNumber}"}");
      await auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          isOtpSendLogin.value = false;
          appCustom.showSnackBar(
              context: context,
              snackBarColor: AppColor.redBoxColor,
              snackBarText: "${e.message}",
              snackBarTextColor: AppColor.backGroundColor);


        },
        codeSent: (String verificationId, int? resendToken) {

          isOtpSendLogin.value = false;
          _verificationId.value = verificationId;

          print("_verificationId===${_verificationId}");
          getCustomerStatus(context);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error sending OTP: $e');

      isOtpSendLogin.value = false;
      appCustom.showSnackBar(
          context: context,
          snackBarColor: AppColor.redBoxColor,
          snackBarText: "${e}",
          snackBarTextColor: AppColor.backGroundColor);

    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    isGoogleLogin.value = true;
    try {
      _googleSignIn.signOut();

      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = authResult.user;
        var uid=user!.uid;

        String googleLoginToken = "${await user?.getIdToken()}";
        String googleLoginTokenget = "${await user!.getIdTokenResult()}";
        List<int> bytes = utf8.encode(googleLoginToken);
        print("googleLoginToken=====${googleLoginToken}");
        bool appEmailVerify=await graphQLService.appEmailCheck(user.email!);

        print("appEmailVerify====${appEmailVerify}");
        print("user.displayName!====${user.displayName!}");

            emailLogInModel=await graphQLService.appEmailLogIn(user.email!,user.displayName!,appEmailVerify);
        print("emailLogInModel====${emailLogInModel!.appemaillogin!.token}");
        print("emailLogInModel====${emailLogInModel!.appemaillogin!.role}");
        print("emailLogInModel====${emailLogInModel!.appemaillogin!.permissions}");
        print("emailLogInModel====${emailLogInModel!.appemaillogin!.token}");
        sharedPrefService.setSkipLogIn(false);
        sharedPrefService.setLogIn(true);
        sharedPrefService.setToken(emailLogInModel!.appemaillogin!.token!);
        sharedPrefService.setPermission(emailLogInModel!.appemaillogin!.permissions!.first);
        sharedPrefService.setRole(emailLogInModel!.appemaillogin!.role!);
        print("googleLoginToken=====${googleLoginToken}");
        Get.off(const HomeScreen());
        print("googleLoginToken=====${googleLoginToken}");
        String base64Token = base64.encode(bytes);

        print(base64Token);
        print("googleLoginToken=====${googleLoginToken}");
        print("googleLoginToken=====${base64Token}");
        isGoogleLogin.value = false;
        //  isGoogleLogin.value = false;
      }
        // sharedPrefService.setSkipLogIn(false);
        // sharedPrefService.setLogIn(true);
        // sharedPrefService
        //     .setToken(logInPhoneModel!.rcustomeotpverification!.token!);
        // sharedPrefService.setPermission(
        //     logInPhoneModel!.rcustomeotpverification!.permissions!.first);
        // sharedPrefService
        //     .setRole(logInPhoneModel!.rcustomeotpverification!.role!);

print("in to screen pass");
        //
        // Get.off(const HomeScreen());
        //
        //
        // String base64Token = base64.encode(bytes);
        //
        // print(base64Token);
        // print("googleLoginToken=====${googleLoginToken}");
        // print("googleLoginToken=====${base64Token}");
      //  isGoogleLogin.value = false;
     // }
    } catch (error) {

      print("error======${error}");
    //  isGoogleLogin.value = false;
    } finally {
      print("finally======");
     //  isGoogleLogin.value = false;
    }
    print("finallynull======");
    return null;
  }
}
//
// Future<GoogleSignInAccount?> signInWithGoogle() async {
//
//     isGoogleLogin.value = true;
//
//   try {
//     _googleSignIn.signOut();
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//     final GoogleSignInAccount? googleSignInAccount =
//     await GoogleSignIn().signIn();
//
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       final UserCredential authResult =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//
//       final User? user = authResult.user;
//       bool isNew = authResult.additionalUserInfo!.isNewUser;
//       if (isNew) {
//         // await FirebaseFirestore.instance
//         //     .collection('user')
//         //     .doc(user!.uid)
//         //     .set({
//         //   'emailID': user.email,
//         //   'password': "",
//         //   'is_Email': false,
//         //   'is_google': true,
//         //   "profile_setup": false,
//         //   "interest_fill": false,
//         //   "u_id": user.uid,
//         // });
//       }
//       print('Google Sign-In ID Token: ${user?.getIdToken()}');
//     }
//
//     isGoogleLogin.value = false;
//
//     print("accesstoken==${googleAuth?.accessToken}");
//     print("idtoken==${googleAuth?.idToken}");
//     print("email==${_googleSignIn.currentUser?.email}");
//     print("displayname==${_googleSignIn.currentUser?.displayName}");
//
//     //  final UserCredential userCredential = await _auth.signInWithCredential(credential);
//     //
//     // final countryCode = await FlutterSimCountryCode.simCountryCode;
//     // print('Country Code: $countryCode');
//     //
//     // print("tokensignin===${SharedPref.get_token}");
//     // setState(() {
//     isGoogleLogin.value = true;
//     // });
//     // try {
//     //   final response = await http.post(
//     //       Uri.parse("${ApiUrl.url}${ApiUrl.version}/loginWithGoogle"),
//     //       body: {
//     //         'email': _googleSignIn.currentUser?.email,
//     //         'device_id': SharedPref.get_deviceid,
//     //         'device_type': SharedPref.get_devidetype,
//     //         'device_token': SharedPref.get_devidetoken,
//     //         'google_id': googleAuth?.idToken,
//     //         'name': _googleSignIn.currentUser?.displayName,
//     //         'country_id': "1",
//     //         'country_code': "+91",
//     //       });
//     //
//     //   if (response.statusCode == 200) {
//     //     var bodyresponceee = jsonDecode(response.body);
//     //
//     //     if (bodyresponceee["message"] == "Your account is deleted") {
//     //       // errormessage = bodyresponceee["message"].toString();
//     //       // _popup();
//     //     } else {
//     //  //     datalogin = GoogleModel.fromJson(bodyresponceee).data;
//     //
//     //       // SharedPref.set_token(GoogleModel.fromJson(bodyresponceee).token!);
//     //       // SharedPref.set_name(_googleSignIn.currentUser!.displayName.toString());
//     //       //
//     //       // SharedPref.set_designation(GoogleModel.fromJson(bodyresponceee).data!.designation!);
//     //       //
//     //       // SharedPref.set_leftimage(GoogleModel.fromJson(bodyresponceee).data!.profileImage!);
//     //       // SharedPref.set_email(GoogleModel.fromJson(bodyresponceee).data!.email!);
//     //       // SharedPref.set_phone(GoogleModel.fromJson(bodyresponceee).data!.mobile!);
//     //       // // SharedPref.set_language(true);
//     //       // //  SharedPref.set_setlanguage_name( GoogleModel.fromJson(bodyresponceee).data.userLanguage);
//     //       //
//     //       // if(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!=null){
//     //       //   SharedPref.set_partyid('${GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.id}');
//     //       //   SharedPref.set_customimmage(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.leader![0].toString());
//     //       //   SharedPref.set_partyColor1(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.color1!);
//     //       //   SharedPref.set_partyColor2(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.color2!);
//     //       //   SharedPref.set_party_name_color(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.nameTextColor!);
//     //       //   SharedPref.set_party_designation_color(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.designationColor!);
//     //       //   SharedPref.set_party_ledger(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyData!.leader!.join(','));
//     //       // }
//     //       //
//     //       // SharedPref.set_login(true);
//     //       //
//     //       // print('===${bodyresponceee}');
//     //       //
//     //       // if(GoogleModel.fromJson(bodyresponceee).data!.userLanguage!.toString().isEmpty){
//     //       //   print('11111');
//     //       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //       //     builder: (context) => SelectLanguageScreen(true, false),
//     //       //   ));
//     //       // }
//     //       // else if(GoogleModel.fromJson(bodyresponceee).data!.designation!.isEmpty){
//     //       //   SharedPref.set_language(true);
//     //       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //       //     builder: (context) => const AddProfileScreen(),
//     //       //   ));
//     //       // }
//     //       // else if(GoogleModel.fromJson(bodyresponceee).data!.politicalPartyId == '0'){
//     //       //   SharedPref.set_profile_added(true);
//     //       //   SharedPref.set_language(true);
//     //       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //       //     builder: (context) => const SelectPartyScreen(false),
//     //       //   ));
//     //       // }
//     //       // else{
//     //       //   SharedPref.set_profile_added(true);
//     //       //   SharedPref.set_language(true);
//     //       //   SharedPref.set_party_added(true);
//     //       //   print('33333');
//     //       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //       //     builder: (context) => const DashBoard(),
//     //       //   ));
//     //       // }
//     //     }
//     //
//     //       isGoogleLogin.value = false;
//     //
//     //   }
//     //
//     //     isGoogleLogin.value = false;
//     //
//     // } catch (e) {
//     //
//     //     isGoogleLogin.value = false;
//     //
//     //   debugPrint(e.toString());
//     // }
//   } catch (error) {
//     print(error);
//     return null;
//   }
//   return await _googleSignIn.signOut();
// }
