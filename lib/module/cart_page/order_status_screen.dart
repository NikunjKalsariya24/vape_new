import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_paint.dart';
import 'package:vape/widget/custom_text.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  bool isSuccess=true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: CustomAppBar(
          title: "Order ",
          titleFontSize: SizeUtils.fSize_24(),
          backgroundColor: AppColor.backGroundColor.withOpacity(0.10),
          backScreenOnTap: () {
            Get.back();
          },
          actions: [
            Row(
              children: [
                CustomText(
                  name: "20230854-3268623",
                  fontSize: SizeUtils.fSize_14(),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 3,
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: SizeUtils.verticalBlockSize * 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.verticalBlockSize * 3),
              child: Image.asset("asset/images/order_status_image.png"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.verticalBlockSize * 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        name: "Order Placed",
                        fontSize: SizeUtils.fSize_12(),
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                      CustomText(
                        name: "confirm Order",
                        fontSize: SizeUtils.fSize_12(),
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                      CustomText(
                        name: "On The Way",
                        fontSize: SizeUtils.fSize_12(),
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                      CustomText(
                        name: "Delivered",
                        fontSize: SizeUtils.fSize_12(),
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.verticalBlockSize * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("asset/images/select_icon.png",
                            width: SizeUtils.horizontalBlockSize * 6),
                        Image.asset("asset/images/select_icon.png",
                            width: SizeUtils.horizontalBlockSize * 6),
                        Image.asset("asset/images/select_icon.png",
                            width: SizeUtils.horizontalBlockSize * 6),
                        Image.asset("asset/images/select_icon.png",
                            width: SizeUtils.horizontalBlockSize * 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 3),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          name: "Shipping Information",
                          fontSize: SizeUtils.fSize_18(),
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor),
                      CustomText(
                          name: "23, Aug-2023",
                          fontSize: SizeUtils.fSize_15(),
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackLightColor),
                    ],
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Name: ",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              CustomText(
                                name: "Mr Customer",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Email:",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              CustomText(
                                name: "user@gmail.com",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Address: :",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 35,
                                  child: CustomText(
                                    maxLines: 2,
                                    name: "369 the ocean street New Road...",
                                    fontSize: SizeUtils.fSize_12(),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "City :: :",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              Container(
                                  child: CustomText(
                                name: "Surat",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ))
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Country :",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 35,
                                  child: CustomText(
                                    maxLines: 2,
                                    name: "India",
                                    fontSize: SizeUtils.fSize_12(),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blackColor,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "State :",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              CustomText(
                                name: "Gujarat",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Phone No:",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              CustomText(
                                name: "+91 9998220731",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 18,
                                  child: CustomText(
                                      name: "Zip Code :",
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackLightColor)),
                              CustomText(
                                name: "395009",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            name: "Shipping Methods",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          CustomText(
                            name: "Home Delivery",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          CustomText(
                            name: "Payment Methods",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          CustomText(
                            name: "Razor Pay",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          CustomText(
                            name: "Delivery Status",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          CustomText(
                            name: "Panding",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          CustomText(
                            name: "Payment Status",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(isSuccess?"asset/images/order_success.png":"asset/images/panding_payment.png",
                                  width: SizeUtils.horizontalBlockSize * 10),
                              CustomText(
                                name: isSuccess?"Paid":"Panding",
                                fontSize: SizeUtils.fSize_12(),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  CustomText(
                    name: "All Order Items",
                    fontSize: SizeUtils.fSize_18(),
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor,
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 2,
                  ),
          
                  ListView.builder(itemCount: 2,shrinkWrap: true,physics: const BouncingScrollPhysics(),itemBuilder: (context, index) {
                    return  Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.orderColor),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1), // X, Y
                                blurRadius: 25, // Blur
                                spreadRadius: 0, // Spread
                                color: AppColor.backGroundColor
                                    .withOpacity(0.08), // Color with Opacity
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeUtils.verticalBlockSize * 2),
                                child: Image.asset(
                                  "asset/images/shoes.png",
                                  width: SizeUtils.verticalBlockSize * 12,
                                  //height: SizeUtils.verticalBlockSize*17
                                ),
                              ),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeUtils.verticalBlockSize * 1,
                                  ),
                                  SizedBox(
                                    width: SizeUtils.horizontalBlockSize * 58,
                                    child: CustomText(
                                        name: "Bourge Mens Vega-m1 Running Shoes",
                                        fontSize: SizeUtils.fSize_13(),
                                        maxLines: 2,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.blackColor),
                                  ),
                                  SizedBox(height: SizeUtils.verticalBlockSize * 1),
                                  CustomText(
                                    name: "Rs 1025.0",
                                    fontSize: SizeUtils.fSize_12(),
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(height: SizeUtils.verticalBlockSize * 1),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                              name: "QTY:",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackReviewColor),
                                          CustomText(
                                              name: "05",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackColor),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeUtils.horizontalBlockSize * 2,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                              name: "Color:",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackReviewColor),
                                          CustomText(
                                              name: "Gray",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackColor),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeUtils.horizontalBlockSize * 4,
                                      ),
                                      Row(
                                        children: [
                                          CustomText(
                                              name: "Size:",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackReviewColor),
                                          CustomText(
                                              name: " L",
                                              fontSize: SizeUtils.fSize_11(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.blackColor),
                                        ],
                                      ),
          
                                    ],
                                  ),
                                  SizedBox(height: SizeUtils.verticalBlockSize * 1),
                                  isSuccess?Row(children: [
                                    GestureDetector(onTap: () {
                                      Get.toNamed(Routes.productReviewScreen);
                                    },
                                      child: Container(
                                          height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*26,
                                          decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xFFB5B5B5), // Your shadow color
                                                  offset: Offset(0, 0), // X and Y offset
                                                  blurRadius: 4, // Blur radius
                                                  spreadRadius: 0, // Spread radius
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(3),
                                              border: Border.all(
                                                  color:
                                                  AppColor.greenBorderColor)),
                                          child: Center(
                                            child: CustomText(
                                              name: "Review",
                                              fontSize: SizeUtils.fSize_12(),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ),
                                    SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                                    Container(
                                        height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*30,
                                        decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0xFFB5B5B5), // Your shadow color
                                                offset: Offset(0, 0), // X and Y offset
                                                blurRadius: 4, // Blur radius
                                                spreadRadius: 0, // Spread radius
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(3),
                                            border: Border.all(
                                                color:
                                                AppColor.orderBorderPinkColor)),
                                        child: Center(
                                          child: CustomText(
                                            name: "Refund request",
                                            fontSize: SizeUtils.fSize_12(),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),



                                  ],):       Container(
                                      height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*28,
                                      decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0xFFB5B5B5), // Your shadow color
                                              offset: Offset(0, 0), // X and Y offset
                                              blurRadius: 4, // Blur radius
                                              spreadRadius: 0, // Spread radius
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(
                                              color:
                                              AppColor.orderBorderPinkColor)),
                                      child: Center(
                                        child: CustomText(
                                          name: "Cancel Order",
                                          fontSize: SizeUtils.fSize_12(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                  const SizedBox(height: 5,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeUtils.verticalBlockSize*2,)
                      ],
                    );
                  },),

                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                  Column(children: [
                    billSummary(billTitle: "Sub Total",billPrice: 1569.0,),
                    SizedBox(height: SizeUtils.verticalBlockSize*2,),
                    billSummary(billTitle: "TAX",billPrice: 0.0,),   SizedBox(height: SizeUtils.verticalBlockSize*2,),
                    billSummary(billTitle: "Shipping Cost",billPrice: 0.0,),   SizedBox(height: SizeUtils.verticalBlockSize*2,),
                    billSummary(billTitle: "Coupon Discounts",billPrice: 100.0,textColor: AppColor.greenColor),   SizedBox(height: SizeUtils.verticalBlockSize*2,),

                    billSummary(billTitle: "Used Super Coin",billPrice: 100.0,textColor: AppColor.orangeBorderColor),
                    SizedBox(height: SizeUtils.verticalBlockSize*2,),
                    CustomPaint(
                      painter: DottedLinePainter(),
                      child: Container(
                        height: 1, // Adjust the height of the line
                      ),
                    ),
                    SizedBox(height: SizeUtils.verticalBlockSize*2,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      CustomText(name: "Total ",fontSize: SizeUtils.fSize_18(),fontWeight: FontWeight.w600,color: AppColor.blackColor,),
                      CustomText(name: "Rs 1369.0",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w700,color: AppColor.blackColor,),
                    ],)


                  ],),

                  SizedBox(height: SizeUtils.verticalBlockSize*4,),
          
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget billSummary({required String billTitle,required double billPrice,Color? textColor}) {
    return   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      CustomText(name: billTitle,fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w500,color:textColor?? AppColor.blackColor,),
      CustomText(name: "$billPrice",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w600,color: textColor??AppColor.blackColor,),
    ],);
  }

}
