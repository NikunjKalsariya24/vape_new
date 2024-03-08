import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

  BottomBarController bottomBarController=Get.put(BottomBarController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    bottomBarController.pageNewIndex.value=(-1);
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      //child:
      Scaffold(
        backgroundColor: AppColor.backGroundColor,
        bottomNavigationBar:AppBottomBar(bottomBar: "4"),
        appBar: CustomAppBar(
          backScreenOnTap: () {
            Get.back();
          },

        ),
        body:  bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

            Align(
                alignment: Alignment.topCenter,
                child: CustomText(
                  name: "New Card",
                  fontSize: SizeUtils.fSize_24(),
                  fontWeight: FontWeight.w700,
                  color: AppColor.orangeColor,
                )),
            SizedBox(height: SizeUtils.verticalBlockSize*6,),
          CustomText(name: "Card number",color: AppColor.brownAddressColor,fontSize: SizeUtils.fSize_18(),fontWeight: FontWeight.w700,),
            SizedBox(height: SizeUtils.verticalBlockSize*1,),
            const CustomTextField(keyboardType: TextInputType.number,filled: true,fillColor: AppColor.blackAddressColor, hintText: "xxxx xxxx xxxx xxxx",hintTextColor: AppColor.brownAddressColor,textColor: AppColor.brownAddressColor,border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
              enabledBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),
              focusedBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),),

            SizedBox(height: SizeUtils.verticalBlockSize*4,),
            CustomText(name: "Expiry Date",color: AppColor.brownAddressColor,fontSize: SizeUtils.fSize_18(),fontWeight: FontWeight.w700,),
            const CustomTextField(keyboardType: TextInputType.number,filled: true,fillColor: AppColor.blackAddressColor, hintText: "MM/YY",hintTextColor: AppColor.brownAddressColor,textColor: AppColor.brownAddressColor,border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
              enabledBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),
              focusedBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),),

            SizedBox(height: SizeUtils.verticalBlockSize*4,),
            CustomText(name: "CVV",color: AppColor.brownAddressColor,fontSize: SizeUtils.fSize_18(),fontWeight: FontWeight.w700,),
            const CustomTextField(keyboardType: TextInputType.number,filled: true,fillColor: AppColor.blackAddressColor, hintText: "***",hintTextColor: AppColor.brownAddressColor,textColor: AppColor.brownAddressColor,border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
              enabledBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),
              focusedBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),),
            Spacer(),
            Padding(
              padding:EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize*1),
              child: GestureDetector(onTap: () {

                Get.back();
              },child: CustomButton(buttonName: "Add Card",)),
            )
          ]),
        ),

      ),
    );
  }
}
