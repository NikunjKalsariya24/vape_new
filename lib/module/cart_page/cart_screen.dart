import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/get_coupen_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/user_delivery_time_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/module/home_page/home_screen.dart';
import 'package:vape/module/home_page/product_home_page.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_paint.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';
import 'package:vape/widget/shimmer_effect.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List circleColor = [
    AppColor.yellowCircleColor,
    AppColor.greenCircleColor,
    AppColor.lightBlueCircleColor,
    AppColor.redCircleColor,
    AppColor.blackCircleColor
  ];
  List productWeight = ["1 KG", "2 KG", "3 KG", "5 KG"];
  SharedPrefService sharedPrefService=SharedPrefService();
  bool isSelectedColor = false;

  int isSelect = 0;
  int isSelectKg = 0;
  int itemQuantity = 1;
  int selectPayment = -1;
  int expectedTimeSelected = 0;

  String selectedOption = "0.0";


  String? token;

  List<NonVariationProductModel> nonVariationCartProduct = [];

  VariationsData? variationsProductModel;

  int count=0;

  AddProductData? addProductModel;

  ProductRemoveData? productRemoveModel;
  GraphQLService graphQLService = GraphQLService();
  GetCouponData? getCouponModel;
  BottomBarController bottomBarController=Get.put(BottomBarController());
  UserDeliveryTimeData? userDeliveryTimeModel;
  bool isCart=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token=sharedPrefService.getToken();
    getCart();
    print("token=========${token}");

  }
  double subTotal=0.0;
  getCart() async {


    setState(() {
      isCart=true;
    });
    await getListFromSharedPreferences();


    getCouponModel=await graphQLService.getCoupon(token!);
    userDeliveryTimeModel=await graphQLService.userDeliveryTime(token!);


    setState(() {
      isCart=false;
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar:  token==""?const SizedBox():Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
        child: Container(
            height: SizeUtils.verticalBlockSize * 6,
            decoration: BoxDecoration(
                color: AppColor.orangeColor,
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      name: "Rs. 1369.0",
                      fontSize: SizeUtils.fSize_18(),
                      fontWeight: FontWeight.w600,
                      color: AppColor.backGroundColor,
                    ),
                    GestureDetector(
                        onTap: () {
                          //  Get.toNamed(Routes.orderScreen);

                          getOrderBottomSheet();
                        },
                        child: CustomText(
                          name: "Order Now",
                          fontSize: SizeUtils.fSize_18(),
                          fontWeight: FontWeight.w600,
                          color: AppColor.backGroundColor,
                        )),
                  ],
                ),
              ),
            )),
      ),
      appBar: const CustomAppBar(
        leadingIcon: false, title: "Shopping Cart",
        // backScreenOnTap: () {
        //   Get.back();
        // },
      ),
      body:isCart?Center(child: CircularProgressIndicator()): Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: nonVariationCartProduct.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
           double productTotalPrice     =getProductPrice(nonVariationCartProduct[index].productPrice,double.parse(nonVariationCartProduct[index].productQuantity.toString()));


                return Column(
                  children: [
                    Visibility(visible: nonVariationCartProduct[index].productQuantity==0||nonVariationCartProduct[index].productQuantity==null?false:true,
                      child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(6),),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black.withOpacity(0.25), // Shadow color
                              //     offset: Offset(0, 0), // X and Y offset
                              //     blurRadius: 8, // Blur radius
                              //     spreadRadius: 0, // Spread radius
                              //   ),
                              // ],
                              // ),
                              child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(6)),
                                child: Image.network(
                                  "${nonVariationCartProduct[index].productImage}",
                                  width: SizeUtils.horizontalBlockSize * 30,height: SizeUtils.verticalBlockSize * 15,fit: BoxFit.fill,
                                  //height: SizeUtils.verticalBlockSize*17
                                ),
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
                                Container(width: SizeUtils.horizontalBlockSize*40,
                                  child: CustomText(
                                      name: "${nonVariationCartProduct[index].productTitle}",
                                      fontSize: SizeUtils.fSize_13(),
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize*2),
                                  child: Container(width: SizeUtils.horizontalBlockSize*40,
                                    child: CustomText(
                                        name: "${nonVariationCartProduct[index].productQuantity} x ${nonVariationCartProduct[index].productUnit}",
                                        fontSize: SizeUtils.fSize_13(),
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.blackColor
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: SizeUtils.verticalBlockSize * 6,
                                // ),
                                // CustomText(
                                //     name: "Running Shoes",
                                //     fontSize: SizeUtils.fSize_13(),
                                //     fontWeight: FontWeight.w600,
                                //     color: AppColor.blackColor),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: SizeUtils.verticalBlockSize * 1),
                                //   child: Row(
                                //     children: [
                                //       CustomText(
                                //         name: "Color:",
                                //         fontSize: SizeUtils.fSize_11(),
                                //         fontWeight: FontWeight.w400,
                                //         color: AppColor.blackNoteColor,
                                //       ),
                                //       SizedBox(
                                //         width: SizeUtils.horizontalBlockSize * 1,
                                //       ),
                                //       CustomText(
                                //         name: "Gray",
                                //         fontSize: SizeUtils.fSize_11(),
                                //         fontWeight: FontWeight.w400,
                                //         color: AppColor.blackColor,
                                //       ),
                                //       SizedBox(
                                //         width: SizeUtils.horizontalBlockSize * 4,
                                //       ),
                                //       CustomText(
                                //         name: "Size:",
                                //         fontSize: SizeUtils.fSize_11(),
                                //         fontWeight: FontWeight.w400,
                                //         color: AppColor.blackNoteColor,
                                //       ),
                                //       SizedBox(
                                //         width: SizeUtils.horizontalBlockSize * 1,
                                //       ),
                                //       CustomText(
                                //         name: "L",
                                //         fontSize: SizeUtils.fSize_11(),
                                //         fontWeight: FontWeight.w400,
                                //         color: AppColor.blackColor,
                                //       )
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  height: SizeUtils.verticalBlockSize * 4,
                                  width: SizeUtils.horizontalBlockSize * 25,
                                  decoration: BoxDecoration(
                                      color: AppColor.greenColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(onTap: () async {



                                            if (nonVariationCartProduct[index].productQuantity != null &&
                                                int.parse(nonVariationCartProduct[index].productQuantity.toString()) != 0) {

                                              print("get to popular");
                                              count = int.parse(nonVariationCartProduct[index].productQuantity.toString());
                                              print("count=====$count");
                                              nonVariationCartProduct[index].productQuantity = count - 1;

                                              if (nonVariationCartProduct[index].productQuantity == 0) {
                                                print("get to popular10");
                                                nonVariationCartProduct[index].productQuantity = null;
                                                print(
                                                    " popularProduct.qtn====${nonVariationCartProduct[index].productQuantity}");


                                                productRemoveModel = await graphQLService.cartProductRemove(nonVariationCartProduct[index].productId!);

                                                print(
                                                    "addProductModel====${nonVariationCartProduct[index].productQuantity}");
                                                if (productRemoveModel!.addtocartProductRemove == "Success") {
                                                  print("get to popular100");
                                                  await cartDecreaseProduct(

                                                      nonVariationCartProduct[index].productId,
                                                      nonVariationCartProduct[index].productImage,
                                                      nonVariationCartProduct[index].productPrice.toString(),
                                                      0,
                                                      //       widget.popularProductModel!.popularProducts![index].qtn,
                                                      nonVariationCartProduct[index].productTitle,
                                                      nonVariationCartProduct[index].productUnit);
                                                  // nonVariationCartProduct.removeWhere((element) => element.productId == widget.popularProductModel!.popularProducts![index].id);

                                                  //count = 0;
                                                }
                                                saveListInSharedPreferences();
                                              } else {
                                                print("get to popular1000");
                                                setState(() {});
                                                await cartDecreaseProduct(
                                                    nonVariationCartProduct[index].productId,
                                                    nonVariationCartProduct[index].productImage,
                                                    nonVariationCartProduct[index].productPrice.toString(),

                                                         nonVariationCartProduct[index].productQuantity,
                                                    nonVariationCartProduct[index].productTitle,
                                                    nonVariationCartProduct[index].productUnit);
                                                saveListInSharedPreferences();
                                              }


                                              saveListInSharedPreferences();
                                            }
                                            setState(() {});
                                          },
                                            child: const Icon(
                                              Icons.remove,
                                              color: AppColor.backGroundColor,
                                            ),
                                          ),
                                          CustomText(
                                            name: "${nonVariationCartProduct[index].productQuantity}",
                                            fontSize: SizeUtils.fSize_13(),
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.backGroundColor,
                                          ),
                                          GestureDetector(onTap: () async {


                                            count = int.parse(nonVariationCartProduct[index]
                                                .productQuantity
                                                .toString());

                                            nonVariationCartProduct[index]
                                                .productQuantity = count + 1;
                                            setState(() {});
                                            await cartIncreaseProduct(
                                            nonVariationCartProduct[
                                            index]
                                                .productId,
                                                nonVariationCartProduct[
                                            index]
                                                .productImage,
                                                nonVariationCartProduct[
                                            index]
                                                .productPrice
                                                .toString(),
                                                nonVariationCartProduct[
                                            index]
                                                .productQuantity,
                                                nonVariationCartProduct[
                                            index]
                                                .productTitle,
                                                nonVariationCartProduct[
                                            index]
                                                .productUnit);





                                          },
                                            child: const Icon(
                                              Icons.add,
                                              color: AppColor.backGroundColor,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeUtils.verticalBlockSize * 4,horizontal: SizeUtils.horizontalBlockSize*1),
                              child: Column(
                                children: [
                                  CustomText(
                                    name: "Rs ${productTotalPrice}",
                                    fontSize: SizeUtils.fSize_12(),
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blackColor,
                                  ),
                                  SizedBox(
                                    height: SizeUtils.verticalBlockSize * 1,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     getBottomSheet(context);
                                  //   },
                                  //   child: Row(
                                  //     children: [
                                  //       CustomText(
                                  //         name: "Update",
                                  //         fontSize: SizeUtils.fSize_11(),
                                  //         fontWeight: FontWeight.w500,
                                  //         color: AppColor.blackNoteColor,
                                  //       ),
                                  //       const Icon(Icons.keyboard_arrow_down)
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            GestureDetector(onTap: () {
              bottomBarController.pageIndex.value = 0;
           // Get.to(HomeScreen());
            },
              child: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 3),
                child: DottedBorder(
                  dashPattern: const [6, 4],
                  strokeWidth: 2,
                           strokeCap: StrokeCap.round,
                  color: AppColor.blackColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(7),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.blackAddressColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("asset/images/cart.png",
                              width: SizeUtils.horizontalBlockSize * 10),
                          CustomText(
                            name: "Add More Iteams",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.backGroundColor),
                            child: const Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(
                                Icons.add,
                                color: AppColor.greenColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 2,
            ),
            CustomText(
              name: "Offers and benefits ",
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.blackAddressColor,
                  borderRadius: BorderRadius.circular(3)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("asset/images/discount.png",
                        width: SizeUtils.horizontalBlockSize * 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            name: "Offers for You",
                            fontSize: SizeUtils.fSize_14(),
                            fontWeight: FontWeight.w700,
                            color: AppColor.blackColor),
                        CustomText(
                            name: "Save up to \$2",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackLightColor),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          getViewOfferBottomSheet(context,getCouponModel);
                        },
                        child: CustomText(
                            name: "View Offers",
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w700,
                            color: AppColor.greenColor)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 2,
            ),
            CustomText(
              name: "Select Shipping address",
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w700,
              color: AppColor.blackColor,
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.blackAddressColor,
                  borderRadius: BorderRadius.circular(3)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          name: "HOME",
                          fontSize: SizeUtils.fSize_15(),
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.addAddress,
                                  arguments: {"addressType": "editAddress"});
                            },
                            child: CustomText(
                              name: "Change",
                              fontSize: SizeUtils.fSize_12(),
                              fontWeight: FontWeight.w700,
                              color: AppColor.greenColor,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    CustomText(
                      name:
                          "3 Newbridge Court Chino Hills, CA 91709, United States",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            CustomText(
              name: "Bill Summary ",
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w700,
              color: AppColor.blackColor,
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.blackAddressColor,
                  borderRadius: BorderRadius.circular(3)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    billSummary(
                      billTitle: "Sub Total",
                      billPrice:" ${
                          subTotalPrice(nonVariationCartProduct,context)}",
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    billSummary(
                      billTitle: "TAX",
                      billPrice: "0.0",
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    billSummary(
                      billTitle: "Shipping Cost",
                      billPrice: "0.0",
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    billSummary(
                        billTitle: "Coupon Discounts",
                        billPrice: selectedOption,
                        textColor: AppColor.greenColor),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    billSummary(
                        billTitle: "Used Super Coin",
                        billPrice: "100.0",
                        textColor: AppColor.orangeBorderColor),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    CustomPaint(
                      painter: DottedLinePainter(),
                      child: Container(
                        height: 1, // Adjust the height of the line
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          name: "Total ",
                          fontSize: SizeUtils.fSize_18(),
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackColor,
                        ),
                        CustomText(
                          name: "Rs 1369.0",
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            CustomText(
              name: "Expected Time",
              fontSize: SizeUtils.fSize_16(),
              fontWeight: FontWeight.w700,
              color: AppColor.blackColor,
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColor.blackAddressColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 1,
                    vertical: SizeUtils.verticalBlockSize * 1),
                child: GridView.builder(
                  itemCount: userDeliveryTimeModel!.settings!.options!.deliveryTime!.length,
                  shrinkWrap: true,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,mainAxisExtent: SizeUtils.verticalBlockSize*6,
                  //    childAspectRatio: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            expectedTimeSelected = index;
                          });
                        },
                        child: expextedTimeSummary(
                          title: userDeliveryTimeModel!.settings!.options!.deliveryTime![index].title!,
                            time: userDeliveryTimeModel!.settings!.options!.deliveryTime![index].description!,
                            expectedTimeSelected: expectedTimeSelected,
                            index: index));
                  },
                ),
              ),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
          ]),
        ),
      ),
    );
  }

  Widget billSummary(
      {required String billTitle,
      required String billPrice,
      Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          name: billTitle,
          fontSize: SizeUtils.fSize_16(),
          fontWeight: FontWeight.w500,
          color: textColor ?? AppColor.blackColor,
        ),
        CustomText(
          name: "$billPrice",
          fontSize: SizeUtils.fSize_16(),
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColor.blackColor,
        ),
      ],
    );
  }

  void getBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.backGroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              //  height: SizeUtils.verticalBlockSize * 60,
              width: SizeUtils.screenWidth,
              decoration: BoxDecoration(
                color: AppColor.backGroundColor,
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
                      height: SizeUtils.verticalBlockSize * 3,
                    ),
                    CustomText(
                        name: "GEEK B5 ACAPUL COCO",
                        fontSize: SizeUtils.fSize_24(),
                        fontWeight: FontWeight.w600),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.verticalBlockSize * 1),
                      child: Text(
                        "Apple Mountain works as a seller for many apple growers of apple.",
                        style: GoogleFonts.poppins(
                            color: AppColor.bottomsSheetTexColor,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // CustomText(name: "Apple Mountain works as a seller for many apple growers of apple.",color: AppColor.bottomsSheetTexColor,fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w600),
                    Row(
                      children: [
                        Text(
                          "4.5",
                          style: GoogleFonts.poppins(
                              color: AppColor.bottomsSheetTexColor,
                              fontSize: SizeUtils.fSize_12(),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        RatingBar.builder(
                          initialRating: 4.5,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColor.yellowColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating); // Use the updated rating here
                          },
                        ),
                        Text(
                          "(89 reviews)",
                          style: GoogleFonts.poppins(
                              color: AppColor.bottomsSheetTexColor,
                              fontSize: SizeUtils.fSize_12(),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.verticalBlockSize * 3),
                      child: SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: circleColor.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 60,
                              width: 65,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      isSelect = index;
                                      setState(() {});
                                    },
                                    child: isSelect == index
                                        ? DottedBorder(
                                            color: Colors.black,
                                            strokeWidth: 2,
                                            borderType: BorderType.Circle,
                                            dashPattern: const [5, 2],
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: circleColor[index],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: circleColor[index],
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.transparent,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                  ),
                                  // SizedBox(width: SizeUtils.horizontalBlockSize*3,)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                right: SizeUtils.horizontalBlockSize * 3),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectKg = index;
                                });
                              },
                              child: Container(
                                  height: SizeUtils.verticalBlockSize * 3,
                                  width: SizeUtils.horizontalBlockSize * 20,
                                  decoration: isSelectKg == index
                                      ? BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.greenBorderColor,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColor.orangeShadowColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColor.blackShadowColor),
                                  child: Center(
                                      child: CustomText(
                                    name: "1 KG",
                                    color: isSelectKg == index
                                        ? AppColor.orangeColor
                                        : AppColor.blackColor,
                                    fontWeight: isSelectKg == index
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    fontSize: isSelectKg == index
                                        ? SizeUtils.fSize_20()
                                        : SizeUtils.fSize_18(),
                                  ))),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 3,
                    ),
                    Row(
                      children: [
                        CustomText(
                          name: "\$ 1800.00",
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeUtils.fSize_20(),
                        ),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 6,
                        ),
                        CustomText(
                          name: "\$ 2000.00",
                          color: AppColor.blackNoteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeUtils.fSize_18(),
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColor.blackNoteColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 3,
                    ),

                    Row(
                      children: [
                        Container(
                            height: SizeUtils.verticalBlockSize * 6,
                            width: SizeUtils.horizontalBlockSize * 35,
                            decoration: BoxDecoration(
                                color: AppColor.greenColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeUtils.horizontalBlockSize * 3),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (itemQuantity >= 1) {
                                        setState(() {
                                          itemQuantity = itemQuantity - 1;
                                        });
                                      }
                                    },
                                    child: const Icon(Icons.remove,
                                        color: AppColor.backGroundColor),
                                  ),
                                ),
                                CustomText(
                                  name: itemQuantity.toString(),
                                  color: AppColor.backGroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeUtils.fSize_14(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeUtils.horizontalBlockSize * 3),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (itemQuantity >= 0) {
                                        setState(() {
                                          itemQuantity = itemQuantity + 1;
                                        });
                                      }
                                    },
                                    child: const Icon(Icons.add,
                                        color: AppColor.backGroundColor),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.horizontalBlockSize * 4),
                          child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              decoration: BoxDecoration(
                                color: AppColor.yellowCircleColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                  child: CustomText(
                                name: "Add to cart",
                                fontSize: SizeUtils.fSize_18(),
                                fontWeight: FontWeight.w700,
                                color: AppColor.backGroundColor,
                              ))),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void getViewOfferBottomSheet(BuildContext context, GetCouponData? getCouponModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: SizeUtils.verticalBlockSize * 80,
            width: SizeUtils.screenWidth,
            decoration: BoxDecoration(
              color: AppColor.backGroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                      height: SizeUtils.verticalBlockSize * 3,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: getCouponModel!.coupons!.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {

                          String expireCouponDate = DateFormat("dd-MMM-yyyy").format(getCouponModel!.coupons!.data![index].expireAt!);

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.blackAddressColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF939393)
                                            .withOpacity(0.24),
                                        offset: const Offset(0, 0),
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    border: Border.all(
                                        color: AppColor.textFieldColor)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.horizontalBlockSize * 3,
                                      vertical:
                                          SizeUtils.verticalBlockSize * 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Transform.scale(
                                            scale: 1.5,
                                            child: Radio<String>(
                                              fillColor: MaterialStateColor
                                                  .resolveWith(
                                                (Set<MaterialState> states) {
                                                  return AppColor.orangeColor;
                                                },
                                              ),
                                              value: getCouponModel.coupons!.data![index].amount.toString(),
                                              activeColor: AppColor.orangeColor,
                                              hoverColor: AppColor.orangeColor,
                                              focusColor: AppColor.orangeColor,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: VisualDensity
                                                          .minimumDensity,
                                                      vertical: VisualDensity
                                                          .minimumDensity),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,

                                              //visualDensity: VisualDensity(horizontal: 0, vertical: 0), // Adjust density
                                              groupValue: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value!;
                                                  print("selectedOption====${selectedOption}");
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeUtils.horizontalBlockSize *
                                                    2,
                                          ),
                                          DottedBorder(
                                            strokeWidth: 1,
                                            color: AppColor.greenColor,
                                            borderType: BorderType.RRect,
                                            child: Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: CustomText(
                                                name: "${getCouponModel.coupons!.data![index].code}",
                                                fontSize: SizeUtils.fSize_14(),
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.couponColor,
                                              ),
                                            )),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              showAwesomeDialog(context,getCouponModel!.coupons!.data![index].amount.toString());
                                              // Get.back();

                                              // Navigator.pop(context);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor
                                                          .couponBorderColor,
                                                      offset: Offset(0, 0),
                                                      blurRadius: 3,
                                                      spreadRadius: 0,
                                                    ),
                                                  ],
                                                  color:
                                                      AppColor.backGroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .borderColor)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 20),
                                                child: CustomText(
                                                  name: "APPLY",
                                                  color: AppColor.greenColor,
                                                  fontSize:
                                                      SizeUtils.fSize_15(),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeUtils.verticalBlockSize * 1,
                                      ),
                                      CustomText(
                                        name:
                                            "${getCouponModel!.coupons!.data![index].description}",
                                        fontSize: SizeUtils.fSize_12(),
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.couponColor,
                                      ),
                                      SizedBox(
                                        height: SizeUtils.verticalBlockSize * 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            name: "SAVE ₹${getCouponModel!.coupons!.data![index].amount}",
                                            fontSize: SizeUtils.fSize_15(),
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.greenColor,
                                          ),
                                          CustomText(
                                            name: expireCouponDate,
                                            fontSize: SizeUtils.fSize_12(),
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.couponDateColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 1,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ]),
            ),
          );
        });
      },
    ).whenComplete(() {

      setState(() {

      });
    });
  }

  void showAwesomeDialog(BuildContext context, String cartAmountOffer) {
    Get.back();
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 3),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Image.asset("asset/images/coupen_background.png",
                          height: SizeUtils.verticalBlockSize * 28),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "asset/images/cancle.png",
                                  height: SizeUtils.verticalBlockSize * 3,
                                )),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                  "asset/images/discount_icon.png",
                                  height: SizeUtils.verticalBlockSize * 10)),
                          Align(
                              alignment: Alignment.topCenter,
                              child: ShimmerEffect(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: AppColor.greenColor,
                                  child: CustomText(
                                    textAlign: TextAlign.center,
                                    name: "\$$cartAmountOffer Saving With this Coupon Code",
                                    fontSize: SizeUtils.fSize_24(),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.greenColor,
                                  ))),
                          //Spacer(),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 4,
                          ),
                          CustomText(
                            name: "Successfully Applied",
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w600,
                            color: AppColor.yellowCircleColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
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
            return Container(
              height: isCardView
                  ? SizeUtils.verticalBlockSize * 45
                  : SizeUtils.verticalBlockSize * 30,
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
                          isCardView=!isCardView;
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
                                  height:
                                  SizeUtils.verticalBlockSize * 6,
                                  fit: BoxFit.fill),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize *
                                    10,
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
                                    horizontal: SizeUtils
                                        .horizontalBlockSize *
                                        4),
                                child:selectPayment==0 && isCardView?const Icon(Icons.keyboard_arrow_up):const Icon(
                                    Icons.keyboard_arrow_down),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    isCardView?ListView.builder(shrinkWrap: true,itemCount: 2,physics: const BouncingScrollPhysics(),itemBuilder: (context, index) {
  return Column(children: [
    Container(  decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 4, horizontal: 4),
        child: GestureDetector(onTap: () {

          Get.toNamed(Routes.orderScreen);
        },
          child: Row(children: [
            Image.asset("asset/images/card_show.png",
                height:
                SizeUtils.verticalBlockSize * 6,
                fit: BoxFit.fill),
            SizedBox(
              width: SizeUtils.horizontalBlockSize *
                  10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              CustomText(name: "SBI CARD ",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w500,color: AppColor.blackColor,),
              CustomText(name: "5282 **** **** 8342",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w500,color: AppColor.couponDateColor,),
            ],)

          ]),
        ),
      ),
    ),
    SizedBox(height: SizeUtils.verticalBlockSize*1,),
  ],);
},):const SizedBox(),


                    GestureDetector(
                      onTap: () {
                        setStateBottomSheet(() {
                          selectPayment = 1;

                       //   isCardView=!isCardView;
                        });
                        Get.toNamed(Routes.orderScreen);
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
                                  height:
                                  SizeUtils.verticalBlockSize * 6,
                                  fit: BoxFit.fill),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize *
                                    10,
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
                                    horizontal: SizeUtils
                                        .horizontalBlockSize *
                                        4),
                                child:

                                const Icon(
                                    Icons.keyboard_arrow_down),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget expextedTimeSummary(
      {required String time,
      required int expectedTimeSelected,
        required String title,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 0, bottom: 0),
      child: DottedBorder(
          dashPattern: const [6, 5],
          strokeWidth: 2,strokeCap: StrokeCap.round,

          color: expectedTimeSelected == index
              ? AppColor.blackColor
              : AppColor.transparent,
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          child: Container(
            width: double.infinity


              ,
              // height: SizeUtils.verticalBlockSize * 5,
              // width: SizeUtils.horizontalBlockSize * 25,
              decoration: BoxDecoration(
                  color: AppColor.backGroundColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Column(
                children: [
                  CustomText(
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w500,
                                      name: title,
                                    ),

                  CustomText(
                    fontSize: SizeUtils.fSize_12(),
                    fontWeight: FontWeight.w500,
                    name: time,
                  ),
                ],
              ))),
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


  getListFromSharedPreferences() async {
    final saveListJson = sharedPrefService.nonVariationProductGet();
    print("saveListJson====${saveListJson}");

    //  var id =sharedPrefService.nonVariationRemove();
    //  print("id========${id}");
    //  nonVariationCartProduct.clear();
    // print("saveListJson====${saveListJson}");
    if (saveListJson != "") {
      final List<dynamic> decodedList = json.decode(saveListJson);

//      var id =sharedPrefService.nonVariationRemove();
// print("id========${id}");
//       nonVariationCartProduct.clear();
      nonVariationCartProduct = decodedList
          .map((item) => NonVariationProductModel.fromJson(item))
          .toList();

      print("nonVariationCartProduct====${nonVariationCartProduct.length}");
    } else {
      nonVariationCartProduct = [];
    }
  }

  cartAddProduct(String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storeCartProduct(productId, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

  storeCartProduct(String productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    await getListFromSharedPreferences();

    if (nonVariationCartProduct.isEmpty) {
      nonVariationCartProduct.add(NonVariationProductModel(
          productId: productId,
          productImage: productImage,
          productPrice: productPrice,
          productQuantity: productQuantity,
          productTitle: productName,
          productUnit: productUnit));
      // storeData.add(popularProductIn);
    } else {
      bool found = false;
      for (int i = 0; i < nonVariationCartProduct.length; i++) {
        print("in product 10");
        if (nonVariationCartProduct[i].productId == productId) {
          print("Item with id $productId.id found, updating quantity");
          nonVariationCartProduct[i].productQuantity = productQuantity;

          print("Item with id ${nonVariationCartProduct[i].productId}");
          found = true;
          break;
        }
      }
      if (!found) {
        print("in product 100");
        print("Item with id $productId.qtn not found, adding new item");
        nonVariationCartProduct.add(NonVariationProductModel(
            productId: productId,
            productImage: productImage,
            productPrice: productPrice,
            productQuantity: productQuantity,
            productTitle: productName,
            productUnit: productUnit));
      }
    }
  }

  saveListInSharedPreferences() {
    final saveListJson = json
        .encode(nonVariationCartProduct.map((item) => item.toJson()).toList());

    print("saveListJson====$saveListJson");
    sharedPrefService.nonVariationProduct(saveListJson);

    print("saveokokokok");
  }

  cartDecreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {

    await storeCartProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
  }

  cartIncreaseProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {

    await storeCartProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();

  }
  double getProductPrice(String? productPrice, double productQuantity) {

    if (productPrice == null || productPrice.isEmpty || productPrice == "null") {
      print("productPrice===${productPrice}");
      return 0.0;
    }


    double price = double.parse(productPrice);

    double totalProductPrice = price * productQuantity;
    print("totalProductPrice===${totalProductPrice}");

    return totalProductPrice;
  }

  double subTotalPrice(List<NonVariationProductModel> nonVariationCartProduct, BuildContext context) {



    double subTotal = 0.0;

    subTotal = nonVariationCartProduct.fold<double>(0.0, (total, element) {
      if (element.productPrice == null || element.productPrice!.isEmpty || element.productPrice == "null") {
        return total;
      }
      return total + (double.parse(element.productPrice!) * double.parse(element.productQuantity.toString()));
    });

    return subTotal;
  }
  }



