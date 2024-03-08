import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class OngoingOrder extends StatefulWidget {
  const OngoingOrder({super.key});

  @override
  State<OngoingOrder> createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 6),
      child: Column(
        children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 4,
          ),



          Row(
            children: [
              Image.asset("asset/images/calander.png",
                  width: SizeUtils.horizontalBlockSize * 6),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 1,
              ),
              CustomText(
                name: "March 5, 2019",
                color: AppColor.brownAddressColor,
                fontSize: SizeUtils.fSize_18(),
                fontWeight: FontWeight.w700,
              ),
              Spacer(),
              CustomText(
                name: "6:30 pm",
                color: AppColor.orangeBorderColor,
                fontSize: SizeUtils.fSize_14(),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 6,
          ),

          Stack(children: [
            Column(children: [
              Row(children: [
                SizedBox(width: SizeUtils.horizontalBlockSize*3,),
                Column(children: [
                  Container(width: 3,height: SizeUtils.verticalBlockSize*6.5,color: Colors.white),

                  // Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.white),
                  // Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  // Container(width: 3,height: SizeUtils.verticalBlockSize*2,),

                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),

                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,color: Colors.red),
                  Container(width: 3,height: SizeUtils.verticalBlockSize*1.5,),



                ],)
              ],)



            ],),
            Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: SizeUtils.horizontalBlockSize*7,
                    width: SizeUtils.horizontalBlockSize*7,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.greenColor),
                    child: Center(child: Icon(Icons.check,color: AppColor.backGroundColor,)),
                  ),
                  SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                  Image.asset("asset/images/order_packing.png",width: SizeUtils.horizontalBlockSize*15),
                  SizedBox(width: SizeUtils.horizontalBlockSize*2,),
                  CustomText(name: "We are packin your items...",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w400,color: AppColor.brownAddressColor,)
                ],
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 6,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: SizeUtils.horizontalBlockSize*7,
                    width: SizeUtils.horizontalBlockSize*7,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.greenColor),
                    child: Center(child: Icon(Icons.check,color: AppColor.backGroundColor,)),
                  ),
                  SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                  Image.asset("asset/images/scooter_delivery.png",width: SizeUtils.horizontalBlockSize*15),
                  SizedBox(width: SizeUtils.horizontalBlockSize*2,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(name: "Your order is delivering to",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w400,color: AppColor.brownAddressColor,),
                      CustomText(name: "your location...",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w400,color: AppColor.brownAddressColor,),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 6,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: SizeUtils.horizontalBlockSize*7,
                    width: SizeUtils.horizontalBlockSize*7,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.greenColor),
                    child: Center(child: Icon(Icons.check,color: AppColor.backGroundColor,)),
                  ),
                  SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                  Image.asset("asset/images/order_delivered.png",width: SizeUtils.horizontalBlockSize*15),
                  SizedBox(width: SizeUtils.horizontalBlockSize*2,),
                  CustomText(name: "Your order is received.",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w400,color: AppColor.brownAddressColor,)
                ],
              ),
            ],)
          ],

          ),



        ],
      ),
    );
  }
}
