import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/user_address_model.dart';
import 'package:vape/model/user_profile_model.dart';
import 'package:vape/module/home_page/profile/controller/profile_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

import 'widget/custom_address.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  int selectPayment = -1;
  ProfileController profileController = Get.put(ProfileController());
  SharedPrefService sharedPrefService = SharedPrefService();

  GraphQLService graphQLService = GraphQLService();
  bool isUserDetails=false;
  UserProfileData? userProfileModel ;
  String token="";
  UserAddressData? userAddressModel;

  String? newUserId;

  String? removeAddressId;

  String? updateUserId;

  bool? isSkipLogIn;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();


    isSkipLogIn    =sharedPrefService.getSkipLogIn();
    isSkipLogIn!=true? getUserDetails():SizedBox();
  }
  getUserDetails() async {
    token=sharedPrefService.getToken();
    profileController.isUserDetails.value=true;

    userProfileModel=await graphQLService.getUserProfile(token);

    profileController.nameController.text=userProfileModel!.me!.name!;

   profileController.phoneController.text=userProfileModel!.me!.profile!.contact.toString();
    profileController.emailController.text=userProfileModel!.me!.email!;
    userAddressModel=await graphQLService.getUserAddress(token);
    print("userAddressModel====${userAddressModel!.me!.address!.length}");
    print("userProfileModel====${userProfileModel!.me!.profile!.bio}");
    profileController.isUserDetails.value=false;


  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Obx(() =>
        //child:
        Scaffold(
          backgroundColor: AppColor.backGroundColor,
          body:profileController. isUserDetails.value?Center(child: CircularProgressIndicator()): Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 3),
            child: SingleChildScrollView(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



                    isSkipLogIn!=true?      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Image.asset("asset/images/profile_icon.png",
                                  width: SizeUtils.horizontalBlockSize * 24),
                              Image.asset(
                                "asset/images/camera.png",
                                width: SizeUtils.horizontalBlockSize * 8,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                name: "${userProfileModel!.me!.name}",
                                fontSize: SizeUtils.fSize_16(),
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 1,
                              ),
                              CustomText(
                                  name: "${userProfileModel!.me!.profile!.contact==null?"":userProfileModel!.me!.profile!.contact}",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 1,
                              ),
                              CustomText(
                                  name: "${userProfileModel!.me!.email}",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor),
                            ],
                          ),
                          GestureDetector(onTap: () {
                            editProfile();
                          },
                            child: Image.asset(
                              "asset/images/profile_forword.png",
                              width: SizeUtils.horizontalBlockSize * 10,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 4,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeUtils.horizontalBlockSize * 3),
                        child: Column(  crossAxisAlignment: CrossAxisAlignment.start,children: [
                          CustomText(
                            name: "Profile",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackLightColor,
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              editProfile();
                              // Get.toNamed(Routes.editProfile);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "asset/images/profile_icons.png",
                                  width: SizeUtils.horizontalBlockSize * 10,
                                  //    height: SizeUtils.verticalBlockSize*6
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 10,
                                ),
                                CustomText(
                                  name: "Personal Data",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                Image.asset(
                                  "asset/images/arrow_forward_icon.png",
                                  width: SizeUtils.horizontalBlockSize * 8,
                                  height: SizeUtils.verticalBlockSize * 2.5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              getAddressInformation(userAddressModel,context);

                              // Get.toNamed(Routes.addressInformation);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "asset/images/address.png",
                                  width: SizeUtils.horizontalBlockSize * 10,
                                  //    height: SizeUtils.verticalBlockSize*6
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 10,
                                ),
                                CustomText(
                                  name: "Address Information",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                Image.asset(
                                  "asset/images/arrow_forward_icon.png",
                                  width: SizeUtils.horizontalBlockSize * 8,
                                  height: SizeUtils.verticalBlockSize * 2.5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(Routes.cardScreen);
                              getOrderBottomSheet();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "asset/images/card.png",
                                  width: SizeUtils.horizontalBlockSize * 10,
                                  //    height: SizeUtils.verticalBlockSize*6
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 10,
                                ),
                                CustomText(
                                  name: "Extra Card",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                Image.asset(
                                  "asset/images/arrow_forward_icon.png",
                                  width: SizeUtils.horizontalBlockSize * 8,
                                  height: SizeUtils.verticalBlockSize * 2.5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 4,
                          ),
                        ],),
                      )
                    ],):SizedBox(),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 1),
                            child: CustomText(
                                name: "My Orders",
                                fontSize: SizeUtils.fSize_18(),
                                fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.viewAllOrder);
                            },
                            child: CustomText(
                                name: "See All",
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.orangeColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: SizeUtils.verticalBlockSize * 8,
                                    width: SizeUtils.horizontalBlockSize * 16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Image.asset("asset/images/burger.png"),
                                  ),
                                  SizedBox(
                                    width: SizeUtils.horizontalBlockSize * 6,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        name: "Burger With Meat",
                                        fontSize: SizeUtils.fSize_14(),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                            name: "Order ID",
                                            fontSize: SizeUtils.fSize_14(),
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackLightColor,
                                          ),
                                          CustomText(
                                              name: "888333777",
                                              fontSize: SizeUtils.fSize_12(),
                                              fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                          name: "\$ 12,230",
                                          fontSize: SizeUtils.fSize_14(),
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.orangeColor),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: index == 1
                                                  ? AppColor.greenBoxColor
                                                  : index == 2
                                                      ? AppColor.redBoxColor
                                                      : AppColor.orangeColor,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            child: CustomText(
                                              name: index == 1
                                                  ? "Delivered"
                                                  : index == 2
                                                      ? "canceled"
                                                      : "In Delivery",
                                              color: AppColor.backGroundColor,
                                              fontSize: SizeUtils.fSize_10(),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                      SizedBox(
                                        height: SizeUtils.verticalBlockSize * 1,
                                      ),
                                      CustomText(
                                        name: "14 Items",
                                        color: AppColor.blackColor,
                                        fontSize: SizeUtils.fSize_10(),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 1,
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 2,
                      ),
                      CustomText(
                          name: "PROFILE",
                          fontSize: SizeUtils.fSize_12(),
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackLightColor),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            name: "Push Notification",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w500,
                          ),
                          Switch(
                            value: isSwitched,
                            trackOutlineWidth: MaterialStateProperty.all(0),
                            onChanged: (value) {
                              // Called when the user toggles the switch
                              setState(() {
                                isSwitched = value;
                              });
                            },
                          )
                          // Switch(activeColor: AppColor.backGroundColor,activeTrackColor: AppColor.switchActiveColor,inactiveTrackColor: AppColor.switchActiveColor,inactiveThumbColor: AppColor.backGroundColor,
                          //  inactiveThumbImage: AssetImage("asset/images/burger.png"), value: isSwitched,hoverColor: AppColor.backGroundColor,trackOutlineWidth: MaterialStatePropertyAll(0), trackOutlineColor: MaterialStateProperty.all<Color>(AppColor.backGroundColor),
                          //   onChanged: (value) {
                          //     // Called when the user toggles the switch
                          //     setState(() {
                          //       isSwitched = value;
                          //     });
                          //   },
                          // )
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 2,
                      ),
                      CustomText(
                        name: "Message | chats",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectLanguage();
                        },
                        child: Row(
                          children: [
                            CustomText(
                              name: "Language",
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            CustomText(
                              name: "English",
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.w500,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeUtils.horizontalBlockSize * 3),
                              child: Image.asset(
                                "asset/images/arrow_forward_icon.png",
                                width: SizeUtils.horizontalBlockSize * 8,
                                height: SizeUtils.verticalBlockSize * 2.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 4,
                      ),
                      CustomText(
                          name: "OTHER",
                          fontSize: SizeUtils.fSize_12(),
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackLightColor),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 2,
                      ),
                      Row(
                        children: [
                          CustomText(
                            name: "About Ticket ",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 3),
                            child: Image.asset(
                              "asset/images/arrow_forward_icon.png",
                              width: SizeUtils.horizontalBlockSize * 8,
                              height: SizeUtils.verticalBlockSize * 2.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                      Row(
                        children: [
                          CustomText(
                            name: "Privacy Policy",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 3),
                            child: Image.asset(
                              "asset/images/arrow_forward_icon.png",
                              width: SizeUtils.horizontalBlockSize * 8,
                              height: SizeUtils.verticalBlockSize * 2.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                      Row(
                        children: [
                          CustomText(
                            name: "Terms and Conditions",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeUtils.horizontalBlockSize * 3),
                            child: Image.asset(
                              "asset/images/arrow_forward_icon.png",
                              width: SizeUtils.horizontalBlockSize * 8,
                              height: SizeUtils.verticalBlockSize * 2.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 4,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "asset/images/help.png",
                            width: SizeUtils.horizontalBlockSize * 7,
                            //    height: SizeUtils.verticalBlockSize*6
                          ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 10,
                          ),
                          CustomText(
                            name: "Help Center",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Image.asset(
                            "asset/images/arrow_forward_icon.png",
                            width: SizeUtils.horizontalBlockSize * 8,
                            height: SizeUtils.verticalBlockSize * 2.5,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize * 4),
                      GestureDetector(
                          onTap: () {
                            if (profileController.isSkip! == true) {
                              Get.toNamed(Routes.logInScreen);
                              // Get.offAndToNamed(Routes.logInScreen);
                            } else {
                              _showLogoutDialog(context);
                            }
                          },
                          child: CustomButton(
                            buttonName:
                                profileController.isSkip! ? "Log In" : "Log Out",
                          )),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  bool isLogOut = false;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Obx(() =>
          //child:
          AlertDialog(
            backgroundColor: AppColor.backGroundColor,
            content: SizedBox(
              height: SizeUtils.verticalBlockSize * 22,
              width: SizeUtils.horizontalBlockSize * 96,

              // constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width),

              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: SizeUtils.verticalBlockSize * 6,
                        width: SizeUtils.horizontalBlockSize * 12,
                        decoration: BoxDecoration(border: Border.all(color: AppColor.textFieldColor), borderRadius: BorderRadius.circular(12)),
                        child: Padding(padding: const EdgeInsets.all(16.0), child: Image.asset("asset/images/exit.png",),),),
                  ),
                  Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          name: "Sign Out",
                          fontSize: SizeUtils.fSize_24(),
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 4,
                        ),
                        CustomText(
                          name: "Do you want to log out?",
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackLightColor,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 4,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: SizeUtils.verticalBlockSize * 6,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.textFieldColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: CustomText(
                                      name: "Cancel",
                                      fontSize: SizeUtils.fSize_14(),
                                      fontWeight: FontWeight.w600,
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
                                onTap: () async {

                                  profileController.isLogOut.value=true;
                                  isLogOut = await graphQLService.logOut();

                                  if (isLogOut == true) {
                                    sharedPrefService.logOutProfile();
                                    sharedPrefService.nonVariationRemove();


                                    Get.back();
                                    Get.offAndToNamed(Routes.logInScreen);
                                  }
                                  profileController.isLogOut.value=false;
                                },
                                child: Container(
                                  height: SizeUtils.verticalBlockSize * 6,
                                  decoration: BoxDecoration(
                                      color: AppColor.orangeColor,
                                      border: Border.all(
                                          color: AppColor.orangeColor, width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: profileController.isLogOut.value==true?const Center(child: CircularProgressIndicator()): CustomText(
                                      name: "Log Out",
                                      fontSize: SizeUtils.fSize_14(),
                                      color: AppColor.backGroundColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int selectLanguageType = 0;

  void selectLanguage() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: SizeUtils.verticalBlockSize * 70,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        name: "Select Language",
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectLanguageType = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: selectLanguageType == index
                                              ? AppColor.orangeBorderColor
                                              : AppColor.blackLanguageColor),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeUtils.horizontalBlockSize * 4,
                                          vertical:
                                              SizeUtils.verticalBlockSize * 2),
                                      child: Row(children: [
                                        Image.asset("asset/images/flag.png",
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    12),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 4,
                                        ),
                                        CustomText(
                                          name: "Indonesia",
                                          fontSize: SizeUtils.fSize_14(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        const Spacer(),
                                        selectLanguageType == index
                                            ? Image.asset(
                                                "asset/images/select_language.png",
                                                width: SizeUtils
                                                        .horizontalBlockSize *
                                                    6)
                                            : const SizedBox()
                                      ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 2,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 6),
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CustomButton(
                        buttonName: "Select",
                      )),
                )
              ]),
            );
          },
        );
      },
    );
  }

  void editProfile() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child:
                //child:
                Container(
              // height:MediaQuery.of(context).size.height,
              // SizeUtils.verticalBlockSize * 70,

              width: SizeUtils.screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  color: AppColor.backGroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize * 3),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset("asset/images/profile_icon.png",
                            width: SizeUtils.horizontalBlockSize * 24),
                        Image.asset(
                          "asset/images/camera.png",
                          width: SizeUtils.horizontalBlockSize * 8,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeUtils.verticalBlockSize * 3),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          name: "Full Name",
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1,
                        ),
                         CustomTextField(textEditingController: profileController.nameController,),
                        // SizedBox(
                        //   height: SizeUtils.verticalBlockSize * 2,
                        // ),
                        // CustomText(
                        //   name: "Date of birth",
                        //   fontSize: SizeUtils.fSize_14(),
                        //   fontWeight: FontWeight.w500,
                        // ),
                        // SizedBox(
                        //   height: SizeUtils.verticalBlockSize * 1,
                        // ),
                        //
                        // //child:
                        // GestureDetector(
                        //   onTap: () async {
                        //     profileController.selectBirthDate =
                        //         await profileController.selectDate(context);
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //         border:
                        //             Border.all(color: AppColor.textFieldColor)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 25, top: 15, bottom: 15),
                        //       child: Row(
                        //         children: [
                        //           CustomText(
                        //               name: profileController
                        //                       .selectBirthDate?.value ??
                        //                   "",
                        //               fontSize: SizeUtils.fSize_14(),
                        //               fontWeight: FontWeight.w500),
                        //           const Spacer()
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        //
                        // SizedBox(
                        //   height: SizeUtils.verticalBlockSize * 2,
                        // ),
                        // CustomText(
                        //   name: "Gender",
                        //   fontSize: SizeUtils.fSize_14(),
                        //   fontWeight: FontWeight.w500,
                        // ),
                        // SizedBox(
                        //   height: SizeUtils.verticalBlockSize * 1,
                        // ),
                        // Container(
                        //   height: SizeUtils.verticalBlockSize * 7,
                        //   decoration: BoxDecoration(
                        //       border:
                        //           Border.all(color: AppColor.textFieldColor),
                        //       borderRadius: BorderRadius.circular(8)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 14, right: 8),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton<String>(
                        //         dropdownColor: AppColor.backGroundColor,
                        //         isExpanded: true,
                        //         hint: CustomText(
                        //           name: profileController
                        //                       .selectedGender.value ==
                        //                   ""
                        //               ? "Select Gender"
                        //               : profileController.selectedGender.value,
                        //           fontSize: SizeUtils.fSize_14(),
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //         items: profileController.genderType
                        //             .map((String genderType) {
                        //           return DropdownMenuItem<String>(
                        //               value: genderType,
                        //               child: CustomText(
                        //                 name: genderType,
                        //                 fontSize: SizeUtils.fSize_14(),
                        //                 fontWeight: FontWeight.w500,
                        //               ));
                        //         }).toList(),
                        //         onChanged: (String? newValue) async {
                        //           profileController.selectedGender.value =
                        //               newValue!;
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),
                        CustomText(
                          name: "Phone",
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1,
                        ),
                         CustomTextField(
                          keyboardType: TextInputType.number,textEditingController: profileController.phoneController,
                        ),

                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),
                        CustomText(
                          name: "Email",
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 1,
                        ),
                         CustomTextField(textEditingController: profileController.emailController,),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 2,
                        ),

                        Container(
                          height: SizeUtils.verticalBlockSize * 6,
                          decoration: BoxDecoration(
                              color: AppColor.orangeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: CustomText(
                              fontSize: SizeUtils.fSize_14(),
                              name: "Edit Profile",
                              color: AppColor.backGroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

        );
      },
    );
  }

  void getAddressInformation(UserAddressData? userAddressModel,  BuildContext context) {

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setBottomState) {

          return SingleChildScrollView(
            child:
            //Obx(() =>
            //child:
            Container(
              // height:MediaQuery.of(context).size.height,
              // SizeUtils.verticalBlockSize * 70,

              width: SizeUtils.screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  color: AppColor.backGroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(children: [
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        name: "Addresses",
                        fontSize: SizeUtils.fSize_18(),
                        fontWeight: FontWeight.w700,
                      ),
                      GestureDetector(
                        onTap: () {
                          getEditAddress(getAddressType: "addAddress",context: context,setBottomState: setBottomState);
                          //Get.toNamed(Routes.addAddress);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.horizontalBlockSize * 4,
                                vertical: SizeUtils.verticalBlockSize * 1),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: AppColor.backGroundColor,
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 1,
                                ),
                                CustomText(
                                  name: "Address",
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.backGroundColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                ListView.builder(shrinkWrap: true,itemCount:
                //profileController.userAddressModel.value.me!.address!.length,

                   userAddressModel!.me!.address!.length,
                  itemBuilder: (context, index) {
                  print("length========${userAddressModel!.me!.address!.length}");
                    return   CustomAddress(
                      addressIcon: userAddressModel!.me!.address![index].title=="Home" ?
                      "asset/images/home_icon.png":"asset/images/office_icon.png",
                      addressType: userAddressModel!.me!.address![index].title!,
                      addressDetails: userAddressModel!.me!.address![index].address!.streetAddress!,
                      popupButtonOnSelect: (selectButton) async {
                        if(selectButton=="update")
                        {
                          getEditAddress(
                              getAddressType: "editAddress",addressElement:
                              userAddressModel!.me!.address![index],context: context,setBottomState: setBottomState);
                          // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});

                        }
                        else
                        {


                          removeAddressId=await graphQLService.removeAddress(token, userAddressModel!.me!.address![index].id.toString());
                          print("removeAddressId======${removeAddressId}");
                          print("removeAddressId======${userAddressModel!.me!.address![index].id.toString()}");
                          if(removeAddressId.toString()==userAddressModel!.me!.address![index].id.toString())
                          {

                            print("in to if");
                            userAddressModel=await graphQLService.getUserAddress(token);
                            print("userAddressModel====${userAddressModel!.me!.address!.length}");
                            setBottomState(() {

                                 });
                            //  await getUserAddress();

                      //      Get.back();


                          }
                        }
                      },
                      // backScreenOnTapEditAddress: () {
                      //   getEditAddress(getAddressType: "editAddress");
                      //   // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
                      // },
                    );

                  },),

              ]),
            ),
            // ),
          );
        },

        );
      },
    );
  }

  void getEditAddress(
      { AddressElement? addressElement, required String getAddressType, required BuildContext context,required void Function(void Function()) setBottomState}
      //required String getAddressType, {required String getAddressType}
      ) {
    if(addressElement!=null)
      {

        profileController.streetAddressController.text=addressElement.address!.streetAddress!;
        profileController.cityController.text=addressElement.address!.city!;
        profileController.stateController.text=addressElement.address!.state!;
        profileController.countryController.text=addressElement.address!.country!;
        profileController.zipCodeController.text=addressElement.address!.zip!;
      }
    else
      {
        profileController.streetAddressController.clear();
        profileController.cityController.clear();
        profileController.stateController.clear();
        profileController.countryController.clear();
        profileController.zipCodeController.clear();

      }


    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Obx(
            () =>
                //child:
                Container(
              // height:MediaQuery.of(context).size.height,
              // SizeUtils.verticalBlockSize * 70,

              width: SizeUtils.screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                  color: AppColor.backGroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: CustomText(
                      name: getAddressType == "editAddress"
                          ? "Edit Addresses"
                          : "New Addresses",
                      fontSize: SizeUtils.fSize_24(),
                      fontWeight: FontWeight.w600,
                      color: AppColor.orangeAddressColor,
                    )),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                Container(
                  height: SizeUtils.verticalBlockSize * 7,
                  decoration: BoxDecoration(
                      color: AppColor.blackAddressColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: AppColor.backGroundColor,
                        isExpanded: true,
                        hint: CustomText(
                          name: profileController.addressSelect.value == ""
                              ? "Home"
                              : profileController.addressSelect.value,
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                          // color: AppColor.brownAddressColor,
                        ),
                        items: profileController.addressList
                            .map((String addressList) {
                          return DropdownMenuItem<String>(
                              value: addressList,
                              child: CustomText(
                                name: addressList,
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w500,
                              ));
                        }).toList(),
                        onChanged: (String? newValue) async {
                          setState(() {
                            profileController.addressSelect.value = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                 CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,
                  hintText: "Enter Street Address",textEditingController: profileController.streetAddressController,
                  //  hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                 CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,textEditingController: profileController.cityController,
                  hintText: "Enter city",
                  // hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                 CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,textEditingController:profileController.stateController ,
                  hintText: "Enter State",
                  // hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,textEditingController:profileController.countryController ,
                  hintText: "Enter Country",
                  // hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,textEditingController:profileController.zipCodeController,
                  hintText: "Enter Zip",
                  // hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                GestureDetector(
                    onTap: () async {


                      if( getAddressType == "editAddress")
                        {
                          profileController. updateAddress.value=true;
                           updateUserId=await graphQLService.updateAddress(token, userProfileModel!.me!.id.toString(), addressElement!.id.toString(),
                               profileController.addressSelect.value ,  profileController.streetAddressController.text,
                               profileController.cityController.text,  profileController.stateController.text,  profileController.countryController.text,  profileController.zipCodeController.text);
print("newUserId===${updateUserId}");
print("newUserId===${userProfileModel!.me!.id.toString()}");
                        if(updateUserId== userProfileModel!.me!.id.toString())
                        {
                          print("in to if");

                          userAddressModel=await graphQLService.getUserAddress(token);


                          Get.back();
                          profileController. updateAddress.value=false;
                        }
                          profileController. updateAddress.value=false;
                        }
                      else{
                        newUserId  =await graphQLService.addAddress(token,  profileController.addressSelect.value, userProfileModel!.me!.id.toString(), profileController.streetAddressController.text,
                            profileController.cityController.text,  profileController.stateController.text,  profileController.countryController.text,  profileController.zipCodeController.text);
                        if(newUserId== userProfileModel!.me!.id.toString())
                        {



                          await getUserAddress();
                            setState(() {
                          });

                          Get.back();





                        }
                      }




                    },
                    child: profileController. updateAddress.value?CircularProgressIndicator():CustomButton(
                        buttonName: getAddressType == "editAddress"
                            ? "Update Address"
                            : "Add")),
                // const Spacer(),
              ]),
            ),
          ),
        );
      },
    ).whenComplete(() async {

    //  userAddressModel=await graphQLService.getUserAddress(token);

      print("userAddressModel====${userAddressModel!.me!.address![0].address!.streetAddress}");
      userAddressModel!.me!.address![0].address!.streetAddress="nishant";
      print("userAddressModel====${userAddressModel!.me!.address![0].address!.streetAddress}");
      setBottomState(() {

      });

    });
  }

  bool isCardView = false;

  void getOrderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return SingleChildScrollView(
              child: Container(
                // height: isCardView
                //     ? SizeUtils.verticalBlockSize * 45
                //     : SizeUtils.verticalBlockSize * 30,
                width: SizeUtils.screenWidth,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.backGroundColor.withOpacity(0.90),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.9),
                      offset: const Offset(0, 0),
                      blurRadius: 33,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            name: "CHOOSE PAYMENT",
                            fontSize: SizeUtils.fSize_18(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          GestureDetector(
                              onTap: () {
                                // Get.back();
                                getCardBottomSheet();
                              },
                              child: CustomText(
                                name: "Add Card",
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w500,
                                color: AppColor.blueColor,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setStateBottomSheet(() {
                            selectPayment = 0;
                            isCardView = !isCardView;
                          });
                          //
                          // if (index == 1) {
                          //   Get.toNamed(Routes.orderScreen);
                          // } else if (index == 0) {
                          //   print("intap");
                          //   setStateBottomSheet(() {
                          //     isCardView =! isCardView;
                          //     print("isCardView=====${isCardView}");
                          //   });
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectPayment == 0
                                      ? AppColor.blackBorderColor
                                      : AppColor.backGroundColor),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.backGroundColor,
                                  offset: Offset(0, 1),
                                  blurRadius: 25,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: AppColor.backGroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            child: Row(
                              children: [
                                Image.asset("asset/images/card_pay.png",
                                    height: SizeUtils.verticalBlockSize * 6,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 10,
                                ),
                                CustomText(
                                  name: "ONLINE PAYMENT",
                                  fontSize: SizeUtils.fSize_18(),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.horizontalBlockSize * 4),
                                  child: selectPayment == 0 && isCardView
                                      ? const Icon(Icons.keyboard_arrow_up)
                                      : const Icon(Icons.keyboard_arrow_down),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      isCardView
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.textFieldColor),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColor.backGroundColor,
                                              offset: Offset(0, 1),
                                              blurRadius: 25,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          color: AppColor.backGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 4),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Get.toNamed(Routes.orderScreen);
                                          },
                                          child: Row(children: [
                                            Image.asset(
                                                "asset/images/card_show.png",
                                                height: SizeUtils
                                                        .verticalBlockSize *
                                                    6,
                                                fit: BoxFit.fill),
                                            SizedBox(
                                              width: SizeUtils
                                                      .horizontalBlockSize *
                                                  10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  name: "SBI CARD ",
                                                  fontSize:
                                                      SizeUtils.fSize_16(),
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.blackColor,
                                                ),
                                                CustomText(
                                                  name: "5282 **** **** 8342",
                                                  fontSize:
                                                      SizeUtils.fSize_12(),
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColor.couponDateColor,
                                                ),
                                              ],
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeUtils.verticalBlockSize * 1,
                                    ),
                                  ],
                                );
                              },
                            )
                          : const SizedBox(),
                      GestureDetector(
                        onTap: () {
                          setStateBottomSheet(() {
                            selectPayment = 1;

                            //   isCardView=!isCardView;
                          });
                          //  Get.toNamed(Routes.orderScreen);
                          //
                          // if (index == 1) {
                          //   Get.toNamed(Routes.orderScreen);
                          // } else if (index == 0) {
                          //   print("intap");
                          //   setStateBottomSheet(() {
                          //     isCardView =! isCardView;
                          //     print("isCardView=====${isCardView}");
                          //   });
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectPayment == 1
                                      ? AppColor.blackBorderColor
                                      : AppColor.backGroundColor),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColor.backGroundColor,
                                  offset: Offset(0, 1),
                                  blurRadius: 25,
                                  spreadRadius: 0,
                                ),
                              ],
                              color: AppColor.backGroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            child: Row(
                              children: [
                                Image.asset("asset/images/card_pay.png",
                                    height: SizeUtils.verticalBlockSize * 6,
                                    fit: BoxFit.fill),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 10,
                                ),
                                CustomText(
                                  name: "CASH ON DELIVERY",
                                  fontSize: SizeUtils.fSize_18(),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.horizontalBlockSize * 4),
                                  child: const Icon(Icons.keyboard_arrow_down),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void getCardBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColor.backGroundColor,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: SizeUtils.verticalBlockSize * 55,
                width: SizeUtils.screenWidth,
                decoration: BoxDecoration(
                  color: AppColor.backGroundColor.withOpacity(0.90),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.9),
                      offset: const Offset(0, 0),
                      blurRadius: 33,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 3,
                      ),
                      CustomText(
                        name: "CARD NUMBER",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      const CustomTextField(
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColor.blackAddressColor,
                        hintText: "xxxx xxxx xxxx xxxx",
                        hintTextColor: AppColor.textColor,
                        textColor: AppColor.textColor,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor), //
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomText(
                        name: "CARD HOLDER NAME ",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      const CustomTextField(
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColor.blackAddressColor,
                        hintText: "Enter Your Card Holder Name",
                        hintTextColor: AppColor.textColor,
                        textColor: AppColor.textColor,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor), //
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomText(
                        name: "EXPIRY DATE",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      const CustomTextField(
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColor.blackAddressColor,
                        hintText: "MM/YYYY",
                        hintTextColor: AppColor.textColor,
                        textColor: AppColor.textColor,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor), //
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      CustomText(
                        name: "CVV",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      const CustomTextField(
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColor.blackAddressColor,
                        hintText: "CVV",
                        hintTextColor: AppColor.textColor,
                        textColor: AppColor.textColor,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor), //
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.textFieldColor),
                        ),
                      ),
                      const Spacer(),
                      // SizedBox(
                      //   height: SizeUtils.verticalBlockSize * 1,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: SizeUtils.verticalBlockSize * 6,
                            decoration: BoxDecoration(
                                color: AppColor.orangeColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: CustomText(
                              name: "SAVE CARD",
                              fontSize: SizeUtils.fSize_18(),
                              fontWeight: FontWeight.w700,
                              color: AppColor.backGroundColor,
                            ))),
                      ),

                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> getUserAddress() async {


    userAddressModel=await graphQLService.getUserAddress(token);
    setState(() {

    });
  }
}
