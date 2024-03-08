import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
             SizedBox(height: SizeUtils.verticalBlockSize*4,),
            Align(alignment: Alignment.topCenter,
              child: CustomText(name: "Your Payment",fontSize: SizeUtils.fSize_28(),fontWeight: FontWeight.w600,color: AppColor.greenColor,
                         //   textAlign: TextAlign.center,
              ),
            ),
            Align(alignment: Alignment.topCenter,
              child: CustomText(name: "Completed Successfully",fontSize: SizeUtils.fSize_28(),fontWeight: FontWeight.w600,color: AppColor.greenColor,
                //textAlign: TextAlign.center,
                   ),
            ),

SizedBox(height: SizeUtils.verticalBlockSize*6,),
            Image.asset("asset/images/cart_icon.png",height: SizeUtils.verticalBlockSize*25),
            SizedBox(height: SizeUtils.verticalBlockSize*8,),
            GestureDetector(onTap: () {

              Get.toNamed(Routes.orderStatusScreen);

            },child: CustomText(name: "See Order Details",color: AppColor.orangeColor,fontSize: SizeUtils.fSize_24(),fontWeight: FontWeight.w500,)),
            SizedBox(height: SizeUtils.verticalBlockSize*3,),
            GestureDetector(onTap: () {

              Get.offAllNamed(Routes.homeScreen);
            },child: Container(height: SizeUtils.verticalBlockSize*6,width: double.infinity,decoration: BoxDecoration(color: AppColor.orangeColor,borderRadius: BorderRadius.circular(6)),child: Center(child: CustomText(name: "Back to Home",color: AppColor.backGroundColor,fontSize: SizeUtils.fSize_24(),fontWeight: FontWeight.w700,)))),

          ]),
        ),
      
      ),
    );
  }
}
