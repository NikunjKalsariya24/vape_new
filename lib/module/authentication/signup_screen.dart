
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vape/model/login_phone_model.dart';
import 'package:vape/module/authentication/controller/autheratication_controller.dart';
import 'package:vape/module/home_page/home_screen.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/app_custom.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_login_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;

  final AuthController authController = Get.put(AuthController());
  SharedPrefService sharedPrefService=SharedPrefService();
  GraphQLService graphQLService=GraphQLService();
  AppCustom     appCustom=    AppCustom();
  bool? isPhoneNumberRegister;

  String? verificationId;
  TextEditingController otp = TextEditingController();

  bool isOtpSend=false;

  String phoneNumber="";

  String notCorrectOtp="";

  bool isVerifyOtp=false;

  Data? logInPhoneModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4),
        child: SingleChildScrollView(
          child: Obx(() =>
            //child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 8,
                ),
                CustomText(
                    name: "Create your new",
                    fontSize: SizeUtils.fSize_32(),
                    fontWeight: FontWeight.w600),
                CustomText(
                    name: "account",
                    fontSize: SizeUtils.fSize_32(),
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 1,
                ),
                CustomText(
                    name:
                        '''Create an account to start looking for the food you like''',
                    color: AppColor.blackLightColor.withOpacity(0.6),
                    fontSize: SizeUtils.fSize_14(),
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(onTap: () {
                //
                //         authController.signUpToEmail.value=false;
                //       },
                //         child: Container(
                //           height: SizeUtils.verticalBlockSize * 6,
                //           decoration: BoxDecoration(
                //               color: AppColor.orangeColor,
                //               borderRadius: BorderRadius.circular(10)),
                //           child: Center(
                //             child: CustomText(
                //                 name: "Phone Number",
                //                 fontSize: SizeUtils.fSize_16(),
                //                 fontWeight: FontWeight.w500,
                //                 color: AppColor.backGroundColor),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: SizeUtils.horizontalBlockSize * 4,
                //     ),
                //     Expanded(
                //       child: GestureDetector(onTap: () {
                //         authController.signUpToEmail.value=true;
                //       },
                //         child: Container(
                //           height: SizeUtils.verticalBlockSize * 6,   decoration: BoxDecoration(
                //             color: AppColor.orangeColor,
                //             borderRadius: BorderRadius.circular(10)),
                //           child: Center(
                //             child: CustomText(
                //                 name: "Email",
                //                 fontSize: SizeUtils.fSize_16(),
                //                 fontWeight: FontWeight.w500,
                //             color: AppColor.backGroundColor),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: SizeUtils.verticalBlockSize * 1,
                // ),

                Visibility(visible:  authController.signUpToEmail.value==false,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

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
                        textEditingController: authController.signUpNumberController,
                        hintText: "Enter Your Number"),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),

                    Align(alignment: Alignment.bottomRight,child: GestureDetector(onTap: ()  {


               //     await  verifyPhone();

                        _sendOTP();
                  //    getLogInDialog();

                     // getOtpDialog();

                    //  await    signInWithPhone();
                      //  bool isContactExist = await graphQLService.getCustomerOtpVerification(authController.numberController.text);
                    //  print('Is Contact Exist: $isContactExist');
                    },child: SizedBox(width: SizeUtils.horizontalBlockSize*30,height: SizeUtils.verticalBlockSize*6,child: CustomButton(childWidget: isOtpSend?CircularProgressIndicator(color: AppColor.backGroundColor,):CustomText(fontSize: SizeUtils.fSize_14(),
                      name: "Send Otp",color: AppColor.backGroundColor,
                    ),)))),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                  ],),
                ),
               //  CustomText(
               //      name: "Phone Number",
               //      fontSize: SizeUtils.fSize_14(),
               //      fontWeight: FontWeight.w500),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 1,
               //  ),
               //  const CustomTextField(
               //      keyboardType: TextInputType.number,
               //      maxLength: 10,
               //      counter: SizedBox.shrink(),
               //     // textEditingController: authController.signUpNumberController,
               //      hintText: "Enter Your Number"),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 1,
               //  ),
               //  CustomText(
               //      name: "User Name",
               //      fontSize: SizeUtils.fSize_14(),
               //      fontWeight: FontWeight.w500),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 1,
               //  ),
               //  CustomTextField(
               //      textEditingController: authController.signUpNumberController,
               //      hintText: "Enter Your UserName"),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 2,
               //  ),
               //  CustomText(
               //      name: "Password",
               //      fontSize: SizeUtils.fSize_14(),
               //      fontWeight: FontWeight.w500),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 1,
               //  ),
               //  Obx(
               //    () =>
               //        //  child:
               //        CustomTextField(
               //            obscureText: !authController.signUpShowPassword.value,
               //            counter: const SizedBox.shrink(),
               //            textEditingController:
               //                authController.signUpPassWordController,
               //            hintText: "Enter Your Password",
               //            suffixIcon: Padding(
               //              padding: const EdgeInsets.all(10.0),
               //              child: GestureDetector(
               //                onTap: () {
               //                  authController.signUpShowPassword.value =
               //                      !authController.signUpShowPassword.value;
               //                },
               //                child: authController.signUpShowPassword.value
               //                    ? Image.asset(
               //                        "asset/images/show_password.png",
               //                        height: 1,
               //                        width: 1,
               //                        fit: BoxFit.fitWidth,
               //                      )
               //                    : Image.asset(
               //                        "asset/images/password_hind.png",
               //                        height: 1,
               //                        width: 1,
               //                        fit: BoxFit.fitWidth,
               //                      ),
               //              ),
               //            )),
               //  ),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 1,
               //  ),
               //  Row(
               //    mainAxisAlignment: MainAxisAlignment.start,
               //    crossAxisAlignment: CrossAxisAlignment.start,
               //    children: [
               //      Obx(
               //        () =>
               //            // child:
               //            GestureDetector(
               //                onTap: () {
               //                  authController.terms.value =
               //                      !authController.terms.value;
               //                },
               //                child: authController.terms.value
               //                    ? Image.asset(
               //                        "asset/images/selected_checkbox.png",
               //                        width: SizeUtils.horizontalBlockSize * 6,
               //                      )
               //                    : Image.asset(
               //                        "asset/images/unselected_checkbox.png",
               //                        width: SizeUtils.horizontalBlockSize * 6,
               //                      )),
               //      )
               //
               //      // Obx(() =>
               //      //   //child:
               //      //   Checkbox(visualDensity: VisualDensity.compact, side: MaterialStateBorderSide.resolveWith(
               //      //         (states) => BorderSide(width: 1.0, color: AppColor.orangeColor),
               //      //
               //      //   ),
               //      //     activeColor: AppColor.orangeColor,
               //      //       checkColor: AppColor.backGroundColor,value: authController.terms.value, onChanged: (value) {
               //      //     authController.terms.value=value!;
               //      //
               //      //     print("value====${value}");
               //      //
               //      //   },
               //      //
               //      //   ),
               //      // ),
               //      ,
               //      const SizedBox(width: 6),
               //      Expanded(
               //        child: Column(
               //          mainAxisAlignment: MainAxisAlignment.start,
               //          crossAxisAlignment: CrossAxisAlignment.start,
               //          children: [
               //            Row(
               //              children: [
               //                CustomText(
               //                    fontSize: SizeUtils.fSize_14(),
               //                    name: "I Agree with",
               //                    fontWeight: FontWeight.w500),
               //                const SizedBox(
               //                  width: 3,
               //                ),
               //                CustomText(
               //                    fontSize: SizeUtils.fSize_14(),
               //                    name: "Terms of Service",
               //                    fontWeight: FontWeight.w600,
               //                    color: AppColor.orangeColor),
               //                const SizedBox(
               //                  width: 4,
               //                ),
               //                CustomText(
               //                    fontSize: SizeUtils.fSize_14(),
               //                    name: "and",
               //                    fontWeight: FontWeight.w500),
               //                const SizedBox(
               //                  width: 4,
               //                ),
               //                CustomText(
               //                    fontSize: SizeUtils.fSize_14(),
               //                    name: "Privacy",
               //                    fontWeight: FontWeight.w600,
               //                    color: AppColor.orangeColor),
               //              ],
               //            ),
               //            CustomText(
               //                fontSize: SizeUtils.fSize_14(),
               //                name: "Policy",
               //                fontWeight: FontWeight.w600,
               //                color: AppColor.orangeColor),
               //          ],
               //        ),
               //      ),
               //
               //      //   CustomText(fontSize: SizeUtils.fSize_13(),name: "Policy",fontWeight: FontWeight.w600,color: AppColor.orangeColor),
               //    ],
               //  ),
               //  const Row(
               //    children: [],
               //  ),
               //  SizedBox(
               //    height: SizeUtils.verticalBlockSize * 4,
               //  ),
               //  CustomButton(
               //    buttonName: "Register",
               //  ),
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
                // CustomLogInButton(boxWidth: SizeUtils.horizontalBlockSize * 10),
                // SizedBox(
                //   height: SizeUtils.verticalBlockSize * 2,
                // ),
                const CustomLogInButton(
                  imageName: "asset/images/google_icon.png",
                  logInButtonName: "Continue With Google",
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                // const CustomLogInButton(
                //   imageName: "asset/images/facebook_icon.png",
                //   logInButtonName: "Continue With Facebook",
                // ),
                // SizedBox(
                //   height: SizeUtils.verticalBlockSize * 3,
                // ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(Routes.logInScreen);
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
                          name: "Sign In",
                          fontSize: SizeUtils.fSize_14(),
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.w600),
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
  }
  String _verificationId = '';

  // Future signInWithPhone() async {
  //   // setState(() {
  //   //   isLoader = true;
  //   // });
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   print("phonwnumbwr=====${'${"+91" + authController.signUpNumberController.text.trim()}'}");
  //   await auth.verifyPhoneNumber(
  //       phoneNumber: '${"+91" + authController.signUpNumberController.text.trim()}',
  //       timeout: Duration(seconds: 15),
  //       codeSent: (String verificationId, int? resendToken) async {
  //         // SharedPreferences pref = await SharedPreferences.getInstance();
  //         //
  //         // pref.setString("userMobileNumber", phoneController.text);
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //       builder: (context) => OtpVerificationScreen(
  //         //         verificationId: verificationId,
  //         //       ),
  //         //     ));
  //       },
  //       verificationFailed: (FirebaseAuthException error) {
  //         // setState(() {
  //         //   CommonWidget().ToastCall(context, "OTP has been Not send");
  //         //   isLoader = false;
  //         // });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationId = verificationId;
  //
  //       },
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // await auth.signInWithCredential(credential);
  //         // setState(() {
  //         //   CommonWidget().ToastCall(context, "OTP has been successfully send");
  //         //   isLoader = false;
  //         // });
  //       });
  //   codeSent:
  //       (String verId, [int? forceCodeResent]) {
  //     verificationId = verId;
  //     print("verificationId=====${verificationId}");
  //     // setState(() {
  //     //   authStatus = "OTP has been successfully send";
  //     //   isLoader = false;
  //     // });
  //   };
  // }


  Future<void> _sendOTP() async {



     phoneNumber = authController.signUpNumberController.text.trim();
    if (phoneNumber.isEmpty) {
      appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "Phone number is empty", snackBarTextColor: AppColor.backGroundColor);
      print('Phone number is empty');
      return;
    }
    else if(phoneNumber.length !=10)
      {
        appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "please enter valid Phone number", snackBarTextColor: AppColor.backGroundColor);
        return ;
      }
    setState(() {
      isOtpSend=true;
    });

   FirebaseAuth auth = FirebaseAuth.instance;
    try {
      print("abc==== ${"+91${phoneNumber}"}");
      await auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
          appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "${e.message}", snackBarTextColor: AppColor.backGroundColor);
          setState(() {
            isOtpSend = false;
          });
        },
        codeSent: (String verificationId, int? resendToken)  {
          setState(() {
            _verificationId = verificationId;
          });
          print("_verificationId===${_verificationId}");

        getCustomerStatus();


        },
        codeAutoRetrievalTimeout: (String verificationId) {



        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      appCustom.showSnackBar(context: context, snackBarColor: AppColor.redBoxColor, snackBarText: "${e}", snackBarTextColor: AppColor.backGroundColor);
      setState(() {
        isOtpSend=false;
      });
    }
  }



  Future<void> getCustomerStatus() async {
    String phoneNumber = authController.signUpNumberController.text.trim();
    if (phoneNumber.isEmpty) {
      print('Phone number is empty');
      return;
    }

    isPhoneNumberRegister=await graphQLService.getCustomerOtpVerification(phoneNumber);
print("isPhoneNumberRegister===${isPhoneNumberRegister}");



if(isPhoneNumberRegister==false)
  {
    print("in if");
    setState(() {
      isOtpSend=false;
    });
    getOtpDialog();
  }
else
  {

    print("in else");
    setState(() {
      isOtpSend=false;
    });
    getLogInDialog();
  }




  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void getOtpDialog() {




    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
                  child: Form(key:_formKey ,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: SizeUtils.verticalBlockSize * 6,
                            width: double.infinity,
                            decoration:
                            const BoxDecoration(color: AppColor.backGroundColor),
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
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                        CustomTextField(textEditingController: authController.signupEmailOtpController,
                    
                          validator: (String? value) {
                    
                            if (value == null || value.isEmpty) {
                              print("Email is required");
                              return 'Email is required';
                            } else if (!EmailValidator.validate(value)) {
                              print("Invalid email format");
                              return 'Invalid email format';
                            }
                            return null;

                    
                    
                          },),
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                    
                        CustomText(
                          name: "Name",
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                         CustomTextField(textEditingController: authController.signupNameOtpController,validator: (value) {
                           if (value == null || value.isEmpty) {

                             return 'Please Enter Your Name';
                           }

                         },),
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                        CustomText(
                          name: "Otp Code",
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
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


                        CustomText(name: notCorrectOtp,color: AppColor.redBoxColor),
                        SizedBox(height: SizeUtils.verticalBlockSize*2,),
                        Row(children: [
                    
                          Expanded(
                            child: GestureDetector(onTap: () {
                              authController.signupEmailOtpController.clear();
                              authController.signupNameOtpController.clear();
                              otp.clear();
                              notCorrectOtp="";
                              setState(() {

                              });
                              Get.back();
                            },
                              child: Container(height: SizeUtils.verticalBlockSize*6,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColor.textFieldColor),
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
                          SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                          Expanded(
                            child: GestureDetector(onTap:() {
                              if (_formKey.currentState!.validate()) {

                                verifyOTP(otp.text,setState,authController.signupEmailOtpController.text.trim(),authController.signupNameOtpController.text.trim(),authController.signUpNumberController.text.trim());


                              }
                            },
                              child: Container(height: SizeUtils.verticalBlockSize*6,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColor.greenColor),
                                child: Center(
                                  child: isVerifyOtp?CircularProgressIndicator(color: AppColor.backGroundColor,):CustomText(
                                    name: "Verify Code",
                                    fontSize: SizeUtils.fSize_16(),
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.backGroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    
                    
                    
                    
                        ],),
                    
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                        Row(
                          children: [
                            Expanded(child: Container(height: 1,decoration: const BoxDecoration(color: AppColor.blackColor),)),const SizedBox(width: 5,),
                            const CustomText(name: "or",),const SizedBox(width: 5,),
                            Expanded(child: Container(height: 1,decoration: const BoxDecoration(color: AppColor.blackColor),)),
                          ],
                        ),
                        SizedBox(height: SizeUtils.verticalBlockSize*1,),
                    
                        GestureDetector(onTap: () {

                          authController.signupEmailOtpController.clear();
                          authController.signupNameOtpController.clear();
                          otp.clear();
                          notCorrectOtp="";
                          setState(() {

                          });
                          Get.back();
                        },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(name: "Back to",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w600,color: AppColor.blackColor,),
                              const SizedBox(width: 5,),
                              CustomText(name: "Log In",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w600,color: AppColor.greenColor,),
                            ],
                          ),
                        ),
                    
                    
                        SizedBox(height: SizeUtils.verticalBlockSize*3,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

        );
      },
    );
  }

  Future<void> verifyOTP(String getOtp, StateSetter setState, String email, String name, String phone,) async {
print("email===${email}");
print("name===${name}");
print("phone===${phone}");

    setState(() {
      isVerifyOtp=true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: getOtp,
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);

      print("OTP verified successfully: $userCredential");


      getVerify(email,name,phone);




    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      // Show error message to the user
      setState(() {

          isVerifyOtp=false;


        notCorrectOtp="Enter Otp is not Valid";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to verify OTP. ${e.message}"),
        ),
      );
    } catch (e) {

      setState(() {
        isVerifyOtp=false;
      });

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


   logInPhoneModel=await graphQLService.otpVerification(name, email, phone);


   print("loginpage=======${logInPhoneModel!.rcustomeotpverification}");
   // print("logInPhoneModel======${logInPhoneModel}");
   // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.role}");
   // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.permissions!.first}");
   // print("logInPhoneModel======${logInPhoneModel!.data!.rcustomeotpverification!.role!}");
   if(logInPhoneModel!.rcustomeotpverification != null )
     {


       print("logInPhoneModel======${logInPhoneModel}");
       authController.signUpNumberController.clear();
       authController.signupEmailOtpController.clear();
       authController.signupNameOtpController.clear();
       otp.clear();
       sharedPrefService.setSkipLogIn(false);
       sharedPrefService.setLogIn(true);
       sharedPrefService.setToken(logInPhoneModel!.rcustomeotpverification !.token!);
       sharedPrefService.setPermission(logInPhoneModel!.rcustomeotpverification !.permissions!.first);
       sharedPrefService.setRole(logInPhoneModel!.rcustomeotpverification!.role!);
       print("token=====${ sharedPrefService.getToken()}");
       print("token=====${ sharedPrefService.getPermission()}");
       print("token=====${ sharedPrefService.getRole()}");


       setState(() {
         isVerifyOtp=false;
       });



       Get.off(HomeScreen());

     }
   else
     {

       setState(() {
         isVerifyOtp=false;
       });
     }


  }

  void getLogInDialog() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: SizeUtils.verticalBlockSize * 6,
                          width: double.infinity,
                          decoration:
                          const BoxDecoration(color: AppColor.backGroundColor),
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
                      SizedBox(height: SizeUtils.verticalBlockSize*1,),
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


                      CustomText(name: notCorrectOtp,color: AppColor.redBoxColor),
                      SizedBox(height: SizeUtils.verticalBlockSize*2,),
                      Row(children: [

                        Expanded(
                          child: GestureDetector(onTap: () {

                            otp.clear();
                            notCorrectOtp="";
                            setState(() {

                            });
                            Get.back();
                          },
                            child: Container(height: SizeUtils.verticalBlockSize*6,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColor.textFieldColor),
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
                        SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                        Expanded(
                          child: GestureDetector(onTap:() {


                              verifyOTP(otp.text,setState,authController.signupEmailOtpController.text.trim(),authController.signupNameOtpController.text.trim(),authController.signUpNumberController.text.trim());



                          },
                            child: Container(height: SizeUtils.verticalBlockSize*6,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppColor.greenColor),
                              child: Center(
                                child: isVerifyOtp?CircularProgressIndicator(color: AppColor.backGroundColor,):CustomText(
                                  name: "Verify Code",
                                  fontSize: SizeUtils.fSize_16(),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.backGroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),




                      ],),

                      SizedBox(height: SizeUtils.verticalBlockSize*1,),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1,decoration: const BoxDecoration(color: AppColor.blackColor),)),const SizedBox(width: 5,),
                          const CustomText(name: "or",),const SizedBox(width: 5,),
                          Expanded(child: Container(height: 1,decoration: const BoxDecoration(color: AppColor.blackColor),)),
                        ],
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize*1,),

                      GestureDetector(onTap: () {

                        authController.signupEmailOtpController.clear();
                        authController.signupNameOtpController.clear();
                        otp.clear();
                        notCorrectOtp="";
                        setState(() {

                        });
                        Get.back();
                      },
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(name: "Back to",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w600,color: AppColor.blackColor,),
                            const SizedBox(width: 5,),
                            CustomText(name: "Log In",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w600,color: AppColor.greenColor,),
                          ],
                        ),
                      ),


                      SizedBox(height: SizeUtils.verticalBlockSize*3,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

        );
      },
    );


  }
}
