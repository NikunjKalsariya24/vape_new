import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/nearest_store_model.dart';
import 'package:vape/model/new_product_model.dart';
import 'package:vape/model/new_shop_model.dart';
import 'package:vape/module/home_page/fastest_stores.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import 'product_details.dart';

class NearShopView extends StatefulWidget {
  List<NewShopModel>? shopList;
  String? token;

  NearShopView({required this.shopList, required this.token, super.key});

  @override
  State<NearShopView> createState() => _NearShopViewState();
}

class _NearShopViewState extends State<NearShopView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      SizedBox(
        height: SizeUtils.verticalBlockSize * 3,
      ),
      widget.shopList == null || widget.shopList?.length == 0
          ? const SizedBox()
          : Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
              SizeUtils.horizontalBlockSize * 3),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                name: "faster Deliver Your Nearest stores",
                color: AppColor.blackNeutralColor,
                fontSize: SizeUtils.fSize_16(),
                fontWeight: FontWeight.w700),
          )),
      widget.shopList == null || widget.shopList?.length == 0
          ? const SizedBox()
          : SizedBox(
        height: SizeUtils.verticalBlockSize * 3,
      ),

      widget.shopList == null || widget.shopList?.length == 0
          ? const SizedBox()
          : Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
          height: SizeUtils.verticalBlockSize * 30,
          child: Padding(
          padding: EdgeInsets.symmetric(
          horizontal:
          SizeUtils.horizontalBlockSize * 3),
      child: ListView.builder(
          itemCount: widget.shopList?.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return FastestStore();
                    // },));



                    Get.toNamed(Routes.fastestStore,
                        arguments: {

                          'storeImage': widget.shopList![index].coverImage!.original,

                          'storeId':  widget.shopList![index].id,
                          'storeSlug': widget.shopList![index].slug


                        }
                    );


                    // Get.offAll(const FastestStore());
                  },
                  child: Container(
                    // height:
                    //     SizeUtils.verticalBlockSize *
                    //         12,
                    // width:
                    //     SizeUtils.horizontalBlockSize *
                    //         29,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(15),
                      color: AppColor.backGroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(
                              0, 0, 0, 0.08),
                          // Shadow color with opacity
                          offset: Offset(0, 1),
                          // X, Y offset
                          blurRadius: 1,
                          // Blur radius
                          spreadRadius:
                          1, // Spread radius
                        ),
                      ],
                    ),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.only(
                            topLeft:
                            Radius.circular(
                                15),
                            topRight:
                            Radius.circular(
                                15)),
                        child: Image.network(
                            "${widget.shopList![index].coverImage!.original}",
                            fit: BoxFit.fill,
                            height: SizeUtils
                                .verticalBlockSize *
                                15,
                            width: SizeUtils
                                .horizontalBlockSize *
                                43),
                      ),
                      SizedBox(
                        height: SizeUtils
                            .verticalBlockSize *
                            1,
                      ),
                      CustomText(
                          name:
                          "${widget.shopList![index].name}",
                          color: AppColor
                              .blackNeutralColor,
                          fontSize:
                          SizeUtils.fSize_14(),
                          fontWeight:
                          FontWeight.w600),
                      Container(
                        width: SizeUtils
                            .horizontalBlockSize *
                            43,
                        child: Center(
                          child: CustomText(
                            maxLines: 2,
                            name:
                            "${widget.shopList![index].address!
                                .streetAddress},${widget.shopList![index]
                                .address!.city},\n${widget.shopList![index]
                                .address!.zip},${widget.shopList![index]
                                .address!.state},${widget.shopList![index]
                                .address!.country}",
                            color: AppColor.grayColor,
                            fontSize:
                            SizeUtils.fSize_12(),
                            fontWeight:
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils
                            .verticalBlockSize *
                            1,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            bottom: 8),
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColor
                                    .blackColor
                                    .withOpacity(
                                    0.45),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child: CustomText(
                                name:
                                "${formatDouble(
                                    widget.shopList![index].distance!,
                                    2)}Km Away",
                                fontSize: SizeUtils
                                    .fSize_10(),
                                color: AppColor
                                    .backGroundColor,
                                fontWeight:
                                FontWeight.w400,
                              ),
                            )),
                      ),
                    ]),
                  ),
                ),
              ],);
          }
      )
    )
    )

    )
    ]);
  }

  String formatDouble(double value, int decimalPlaces) {
    return value.toStringAsFixed(decimalPlaces);
  }
}
