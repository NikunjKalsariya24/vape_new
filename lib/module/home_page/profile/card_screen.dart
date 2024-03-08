import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_text.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  BottomBarController bottomBarController=Get.put(BottomBarController());


  List card=["5342"];
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
          actions: [
            GestureDetector(onTap: () {
                  Get.toNamed(Routes.addCard);
            },child: const Icon(Icons.add, color: AppColor.orangeColor, size: 30)),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 6,
            )
          ],
        ),
        body: bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:card.isNotEmpty?Column(children: [
          Align(
              alignment: Alignment.topCenter,
              child: CustomText(
                name: "My Cards",
                fontSize: SizeUtils.fSize_24(),
                fontWeight: FontWeight.w700,
                color: AppColor.orangeColor,
              )),
          SizedBox(height: SizeUtils.verticalBlockSize*4,),

          ListView.builder(itemCount: 2,shrinkWrap: true,itemBuilder: (context, index) {
            return     Column(
              children: [

                SizedBox(height: SizeUtils.verticalBlockSize*2,),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
                  child: Row(children: [

                    Image.asset("asset/images/card_icon.png",width: SizeUtils.horizontalBlockSize*16),
                    SizedBox(width: SizeUtils.horizontalBlockSize*6,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      SizedBox(height: SizeUtils.verticalBlockSize*1,),
                      CustomText(
                        name: "My Card",
                        fontSize: SizeUtils.fSize_18(),
                        fontWeight: FontWeight.w700,
                        color: AppColor.brownAddressColor,
                      ),
                      SizedBox(height: SizeUtils.verticalBlockSize*1,),
                      CustomText(
                        name: "5342 **** **** 6745",
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w400,
                        color: AppColor.brownAddressColor,
                      ),



                    ],),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_sharp,color: AppColor.brownAddressColor,)

                  ],),

                ),
                SizedBox(height: SizeUtils.verticalBlockSize*2,),
                Container(height: 1,color: AppColor.dividerBrownColor.withOpacity(0.10),)
              ],
            );
          },),

          SizedBox(height: SizeUtils.verticalBlockSize*3,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
            child: Row(children: [

              Image.asset("asset/images/apple_pay.png",width: SizeUtils.horizontalBlockSize*16),
              SizedBox(width: SizeUtils.horizontalBlockSize*6,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                CustomText(
                  name: "Apple Pay",
                  fontSize: SizeUtils.fSize_18(),
                  fontWeight: FontWeight.w700,
                  color: AppColor.brownAddressColor,
                ),



              ],),
              const Spacer(),
              const Icon(Icons.check,color: AppColor.greenColor,)

            ],),

          ),
          SizedBox(height: SizeUtils.verticalBlockSize*3,),
          Container(height: 1,color: AppColor.dividerBrownColor.withOpacity(0.10),)


        ],):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: CustomText(
                    name: "My Cards",
                    fontSize: SizeUtils.fSize_24(),
                    fontWeight: FontWeight.w700,
                    color: AppColor.orangeColor,
                  )),
              Image.asset("asset/images/creditcard_image.png"),
              Align(
                  alignment: Alignment.topCenter,
                  child: CustomText(
                    name: "No Saved Card",
                    fontSize: SizeUtils.fSize_20(),
                    fontWeight: FontWeight.w700,
                    color: AppColor.brownAddressColor,
                  )),
              Align(
                  alignment: Alignment.topCenter,
                  child: CustomText(
                    name:
                        "You can save your card info to",

                    fontSize: SizeUtils.fSize_16(),
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownAddressColor,
                  )),   Align(
                  alignment: Alignment.topCenter,
                  child: CustomText(
                    name:
                        "make purchase easier, faster.",

                    fontSize: SizeUtils.fSize_16(),
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownAddressColor,
                  )),
            ]),
      ),
    );
  }
}
