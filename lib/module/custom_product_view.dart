import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/custom_popular_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import 'home_page/product_details.dart';

class CustomProductView extends StatefulWidget {
  CustomPopularData? customPopularModel;
  String? token;
   CustomProductView({required this.customPopularModel,required this.token ,super.key});

  @override
  State<CustomProductView> createState() => _CustomProductViewState();
}

class _CustomProductViewState extends State<CustomProductView> {
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  GraphQLService graphQLService=GraphQLService();
  int count = 0;
  VariationsData? variationsProductModel;
  List<NonVariationProductModel> nonVariationCartProduct = [];
  SharedPrefService sharedPrefService = SharedPrefService();

  AddProductData? addProductModel;

  ProductRemoveData? productRemoveModel;
  String token="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }
  getAllProduct() async {
    token = sharedPrefService.getToken();
    await getListFromSharedPreferences();
    nonVariationCartProduct.forEach((element) {
      widget.customPopularModel!
          .types![0]
          .settings!
          .customeproduct!
          ?.forEach((elementPopularProduct) {
        elementPopularProduct.products?.forEach((elementCustomProduct) {
          if (element.productId == elementCustomProduct.id) {
            elementCustomProduct.qtn = element.productQuantity;
          }

        });



        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    SizedBox(
    height: SizeUtils.verticalBlockSize * 3,
    ),
    ListView.builder(
    shrinkWrap: true,
    itemCount: widget.customPopularModel
        ?.types?[0].settings?.customeproduct?.length ??
    0,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                  SizeUtils.horizontalBlockSize * 3),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    name:
                    "${widget.customPopularModel!.types![0].settings!
                        .customeproduct![index].title}",
                    fontSize: SizeUtils.fSize_18(),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    name: "See All",
                    fontSize: SizeUtils.fSize_20(),
                    fontWeight: FontWeight.w500,
                    color: AppColor.orangeColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              //height:280,

              height: SizeUtils.verticalBlockSize * 40,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.customPopularModel!
                    .types![0]
                    .settings!
                    .customeproduct![index]
                    .products!
                    .length,

                //
                // customPopularModel!
                //     .type!
                //     .settings!
                //     .customeproduct![index]
                //     .products!
                //     .length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal:
                    SizeUtils.horizontalBlockSize * 3),
                itemBuilder: (context, indexProduct) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        // height: 100,
                        //   width: SizeUtils.horizontalBlockSize*40,
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
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                GestureDetector(onTap: () {



                                  Get.toNamed(Routes.productDetails,
                                      arguments: {

                                        'productId': widget.customPopularModel!.types![0]
                                            .settings!.customeproduct![index].products![indexProduct].id,

                                        'productSlug':   widget.customPopularModel!.types![0]
                                            .settings!.customeproduct![index].products![indexProduct].slug,

                                      }
                                  )!.then((value) {

                                    getAllProduct();
                                    setState(() {

                                    });

                                  });



                                },
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.only(
                                        topLeft: Radius
                                            .circular(15),
                                        topRight:
                                        Radius.circular(
                                            15)),
                                    child: Image.network(
                                        widget.customPopularModel!.types![0]
                                            .settings!.customeproduct![index]
                                            .products![indexProduct].image
                                            ?.original ?? "",
                                        fit: BoxFit.fill,
                                        height: SizeUtils
                                            .verticalBlockSize *
                                            23,
                                        width: SizeUtils
                                            .horizontalBlockSize *
                                            43),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeUtils
                                      .verticalBlockSize *
                                      1,
                                  bottom: SizeUtils
                                      .verticalBlockSize *
                                      3),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: SizeUtils
                                        .horizontalBlockSize *
                                        2,
                                  ),
                                  CustomText(
                                    name:
                                    "${widget.customPopularModel!.types![0]
                                        .settings!.customeproduct![index]
                                        .products![indexProduct].name}",
                                    fontSize:
                                    SizeUtils.fSize_14(),
                                    color: AppColor.grayColor,
                                    fontWeight:
                                    FontWeight.w600,
                                    textAlign:
                                    TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeUtils
                                      .horizontalBlockSize *
                                      1,
                                ),
                                //const SizedBox(width: 5,),
                                CustomText(
                                  name:
                                  "Rp${widget.customPopularModel!.types![0]
                                      .settings!.customeproduct![index]
                                      .products![indexProduct].salePrice}",
                                  color: AppColor.greenColor,
                                  fontSize:
                                  SizeUtils.fSize_13(),
                                  fontWeight: FontWeight.w700,
                                ),
                                CustomText(
                                  name:
                                  "/ ${widget.customPopularModel!.types![0]
                                      .settings!.customeproduct![index]
                                      .products![indexProduct].unit}",
                                  color: AppColor.grayColor,
                                  fontSize:
                                  SizeUtils.fSize_10(),
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeUtils
                                      .verticalBlockSize *
                                      1),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        left: 3),
                                    child: Container( width: SizeUtils
                                        .horizontalBlockSize *
                                        16,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          CustomText(
                                            name:
                                            "Rp ${widget.customPopularModel!
                                                .types![0].settings!
                                                .customeproduct![index]
                                                .products![indexProduct].price}",
                                            color: AppColor
                                                .greenColor,
                                            fontSize: SizeUtils
                                                .fSize_12(),
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                          CustomText(
                                            name:
                                            "Rp ${widget.customPopularModel!
                                                .types![0].settings!
                                                .customeproduct![index]
                                                .products![indexProduct]
                                                .maxPrice}",
                                            color: AppColor
                                                .grayTextColor,
                                            fontSize: SizeUtils
                                                .fSize_11(),
                                            fontWeight:
                                            FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  widget.customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].qtn == null ||
                                      widget.customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].qtn == 0
                                      ? Padding(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        4),
                                    child:
                                    GestureDetector(
                                      onTap: () async {

                                        if(token!="")
                                          {


                                            variationsProductModel =
                                            await graphQLService
                                                .variationsProduct(
                                                widget.token ?? "",
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .id!);

                                            if (variationsProductModel!
                                                .product!.variations!.isEmpty) {
                                              count = int.parse(
                                                  "${widget.customPopularModel!
                                                      .types![0].settings!
                                                      .customeproduct![index]
                                                      .products![indexProduct].qtn == null ? 0 : widget.customPopularModel!
                                                      .types![0].settings!
                                                      .customeproduct![index]
                                                      .products![indexProduct].qtn}");

                                              setState(() {
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .qtn = count + 1;
                                              });
                                              await customPopularAddProduct(
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct].id,
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .image!
                                                    .original,
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .salePrice
                                                    .toString(),
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct].qtn,
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct].name,
                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct].unit,
                                              );
                                            }
                                          }
else
  {
    Get.toNamed(Routes.logInScreen);
  }


                                      },
                                      child: Container(
                                        height: SizeUtils
                                            .verticalBlockSize *
                                            4.3,
                                        width: SizeUtils
                                            .horizontalBlockSize *
                                            20,
                                        decoration:
                                        BoxDecoration(
                                          color: AppColor
                                              .greenColor,
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              6),
                                        ),
                                        child: Row(
                                            children: [
                                              const SizedBox(
                                                width:
                                                4,
                                              ),
                                              const Icon(
                                                  Icons
                                                      .add,
                                                  color:
                                                  AppColor.backGroundColor),
                                              CustomText(
                                                name:
                                                "Add",
                                                color: AppColor
                                                    .backGroundColor,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize:
                                                SizeUtils.fSize_14(),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ):Padding(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        4),
                                    child: Container(
                                      height: SizeUtils
                                          .verticalBlockSize *
                                          4.3,
                                      width: SizeUtils
                                          .horizontalBlockSize *
                                          21,
                                      decoration:
                                      BoxDecoration(
                                        color: AppColor
                                            .greenColor,
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            6),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            4),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              // SizedBox(width: 4,),
                                              GestureDetector(onTap: () async {


                                                if (widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .qtn !=
                                                    null &&
                                                    int.parse(widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                        .qtn
                                                        .toString()) !=
                                                        0) {
                                                  count = int.parse(widget.customPopularModel!
                                                      .types![0].settings!
                                                      .customeproduct![index]
                                                      .products![indexProduct]
                                                      .qtn
                                                      .toString());
                                                  print("count=====$count");
                                                  widget.customPopularModel!
                                                      .types![0].settings!
                                                      .customeproduct![index]
                                                      .products![indexProduct]
                                                      .qtn = count - 1;

                                                  if (widget.customPopularModel!
                                                      .types![0].settings!
                                                      .customeproduct![index]
                                                      .products![indexProduct]
                                                      .qtn ==
                                                      0) {
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                        .qtn = null;
                                                    print(
                                                        " popularProduct.qtn====${widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct].qtn}");


                                                    productRemoveModel =
                                                        await graphQLService
                                                        .cartProductRemove(widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .id!);

                                                    print(
                                                        "addProductModel====${widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct].id}");
                                                    if (productRemoveModel!
                                                        .addtocartProductRemove ==
                                                        "Success") {
                                                      await customPopularDecreaseProduct(
                                                          widget.customPopularModel!
                                                              .types![0].settings!
                                                              .customeproduct![index]
                                                              .products![indexProduct]
                                                              .id,
                                                          widget.customPopularModel!
                                                              .types![0].settings!
                                                              .customeproduct![index]
                                                              .products![indexProduct]
                                                              .image!
                                                              .original,
                                                          widget.customPopularModel!
                                                              .types![0].settings!
                                                              .customeproduct![index]
                                                              .products![indexProduct]
                                                              .salePrice
                                                              .toString(),
                                                        0,
                                                          widget.customPopularModel!
                                                              .types![0].settings!
                                                              .customeproduct![index]
                                                              .products![indexProduct]
                                                              .name,
                                                          widget.customPopularModel!
                                                              .types![0].settings!
                                                              .customeproduct![index]
                                                              .products![indexProduct]
                                                              .unit);

                                                      //count = 0;
                                                    }
                                                    saveListInSharedPreferences();

                                                  } else {

                                                    await customPopularDecreaseProduct(
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .id,
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .image!
                                                        .original,
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .salePrice
                                                        .toString(),
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .qtn,
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .name,
                                                        widget.customPopularModel!
                                                            .types![0].settings!
                                                            .customeproduct![index]
                                                            .products![indexProduct]
                                                        .unit);
                                                  }

                                                  print(
                                                      "qtn=====${widget.customPopularModel!
                                                          .types![0].settings!
                                                          .customeproduct![index]
                                                          .products![indexProduct].qtn}");
                                                  saveListInSharedPreferences();
                                                }
                                                setState(() {});
                                              },
                                                child: const Icon(
                                                    Icons
                                                        .remove,
                                                    color:
                                                    AppColor.backGroundColor),
                                              ),
                                              CustomText(
                                                name:
                                                "${widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .qtn}",
                                                color:
                                                AppColor.backGroundColor,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize:
                                                SizeUtils.fSize_14(),
                                              ),
                                              GestureDetector(onTap: () async {

                                                count = int.parse(widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .qtn
                                                    .toString());

                                                widget.customPopularModel!
                                                    .types![0].settings!
                                                    .customeproduct![index]
                                                    .products![indexProduct]
                                                    .qtn = count + 1;
                                                setState(() {});
                                                await customPopularIncreaseProduct(
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .id,
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .image!
                                                    .original,
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .salePrice
                                                    .toString(),
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .qtn,
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .name,
                                                    widget.customPopularModel!
                                                        .types![0].settings!
                                                        .customeproduct![index]
                                                        .products![indexProduct]
                                                    .unit);

                                              },
                                                child: const Icon(
                                                    Icons
                                                        .add,
                                                    color:
                                                    AppColor.backGroundColor),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: SizeUtils.verticalBlockSize*3,)
          ]);
    })],);

  }
  getListFromSharedPreferences() async {
    final saveListJson = sharedPrefService.nonVariationProductGet();
    print("saveListJson====${saveListJson}");
    if (saveListJson != "") {
      final List<dynamic> decodedList = json.decode(saveListJson);

      // sharedPrefService.nonVariationRemove();
      //
      // nonVariationCartProduct.clear();
      nonVariationCartProduct = decodedList
          .map((item) => NonVariationProductModel.fromJson(item))
          .toList();
    } else {
      nonVariationCartProduct = [];
    }
  }

  customPopularAddProduct(String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {




    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storeCustomPopularProduct(productId, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();




  }

  Future<void> storeCustomPopularProduct(
      String productId,
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

  saveListInSharedPreferences() async {
    final saveListJson = json
        .encode(nonVariationCartProduct.map((item) => item.toJson()).toList());

    print("saveListJson====$saveListJson");
    sharedPrefService.nonVariationProduct(saveListJson);

    print("saveokokokok");
  }

  customPopularDecreaseProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {




    await storeCustomPopularProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
  }

  customPopularIncreaseProduct(    String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {



    await storeCustomPopularProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

}
