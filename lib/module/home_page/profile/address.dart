import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/module/home_page/profile/widget/custom_address.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_text.dart';

class AddressInformation extends StatefulWidget {
  const AddressInformation({super.key});

  @override
  State<AddressInformation> createState() => _AddressInformationState();
}

class _AddressInformationState extends State<AddressInformation> {

  BottomBarController bottomBarController=Get.put(BottomBarController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomBarController.pageNewIndex.value=(-1);
  }
  @override
  Widget build(BuildContext context) {

    print("index=====${ bottomBarController.pageNewIndex.value}");
    return Obx(() =>
     // child:
        Scaffold(
        bottomNavigationBar:AppBottomBar(bottomBar: "4"),
        backgroundColor: AppColor.backGroundColor,

        appBar:  CustomAppBar(

      leadingImage: "asset/images/arrow_back.png",
      backScreenOnTap: () {
      Get.back();
      },
      ),

      body: bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        SizedBox(height: SizeUtils.verticalBlockSize*2,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(name: "Addresses",fontSize: SizeUtils.fSize_18(),fontWeight: FontWeight.w700,),
                GestureDetector(onTap: () {

                  Get.toNamed(Routes.addAddress);
                },
                  child: Container(decoration: BoxDecoration(color: AppColor.greenColor,borderRadius: BorderRadius.circular(4)),child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*4,vertical: SizeUtils.verticalBlockSize*1),
                    child: Row(
                      children: [

                        const Icon(Icons.add,color: AppColor.backGroundColor,),SizedBox(width: SizeUtils.horizontalBlockSize*1,),
                        CustomText(name: "Address",fontSize: SizeUtils.fSize_14(),fontWeight: FontWeight.w500,color: AppColor.backGroundColor,)
                      ],

                    ),
                  ), ),
                )

              ],
            ),
          ),
          SizedBox(height: SizeUtils.verticalBlockSize*3,),
          CustomAddress(addressIcon:"asset/images/home_icon.png", addressType:  "Home", addressDetails: "Lungangen 6, 41722",  popupButtonOnSelect: (selectButton) {
            if(selectButton=="update")
            {
              Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
              // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});

            }
            else
            {

            }
          },
            backScreenOnTapEditAddress: () {
            Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
          },),
          SizedBox(height: SizeUtils.verticalBlockSize*3,),
          GestureDetector(onTap: () {

            Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
          },
            child: CustomAddress(addressIcon:"asset/images/office_icon.png", addressType:  "Office", popupButtonOnSelect: (selectButton) {
              if(selectButton=="update")
              {
                Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
                // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});

              }
              else
              {

              }
            },addressDetails: "Lungangen 6, 41722", backScreenOnTapEditAddress: () {

            },),
          ),


        ]),
      ),),
    );
  }


}
