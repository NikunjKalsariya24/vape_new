import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/popular_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class PopularProductView extends StatefulWidget {
  final PopularProductData? popularProductModel;
  final String? token;

  const PopularProductView(
      {required this.popularProductModel, required this.token, super.key});

  @override
  State<PopularProductView> createState() => _PopularProductViewState();
}

class _PopularProductViewState extends State<PopularProductView> {
  AddProductData? addProductModel;
  ProductRemoveData? productRemoveModel;
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  GraphQLService graphQLService = GraphQLService();
  int count = 0;
  VariationsData? variationsProductModel;
  List<NonVariationProductModel> nonVariationCartProduct = [];
  SharedPrefService sharedPrefService = SharedPrefService();
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
      widget.popularProductModel?.popularProducts
          ?.forEach((elementPopularProduct) {
        if (element.productId == elementPopularProduct.id) {
          elementPopularProduct.qtn = element.productQuantity;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        SizedBox(
          height: SizeUtils.verticalBlockSize * 3,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                name: "Popular products",
                fontSize: SizeUtils.fSize_18(),
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                name: "See All",
                fontSize: SizeUtils.fSize_20(),
                fontWeight: FontWeight.w500,
                color: AppColor.orangeColor,
              )
            ],
          ),
        ),
        SizedBox(
          //height:280,

          height: SizeUtils.verticalBlockSize * 40,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.popularProductModel?.popularProducts?.length ?? 0,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 3),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    // height: 100,
                    //   width: SizeUtils.horizontalBlockSize*40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.backGroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          // Shadow color with opacity
                          offset: Offset(0, 1),
                          // X, Y offset
                          blurRadius: 1,
                          // Blur radius
                          spreadRadius: 1, // Spread radius
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.productDetails, arguments: {
                                  'productId': widget.popularProductModel!
                                      .popularProducts![index].id,
                                  'productSlug': widget.popularProductModel!
                                      .popularProducts![index].slug,
                                })!.then((value) {


                                  getAllProduct();
                                  setState(() {

                                  });
                                });
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                child: Image.network(
                                    "${widget.popularProductModel!.popularProducts![index].image!.original}",
                                    fit: BoxFit.fill,
                                    height: SizeUtils.verticalBlockSize * 23,
                                    width: SizeUtils.horizontalBlockSize * 44),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () async {
                                  print(
                                      "popularProductModel!.popularProducts![index].inWishlist======${widget.popularProductModel!.popularProducts![index].id}");
                                  print("like");

                                  if (widget.token != null) {
                                    // popularProductModel!.popularProducts![index].inWishlist =
                                    // !(popularProductModel!.popularProducts![index].inWishlist ?? false);

                                    toggleWishListModel =
                                        await graphQLService.wishListToggle(
                                            widget.popularProductModel!
                                                .popularProducts![index].id!,
                                            widget.token ?? "");
                                    print(
                                        "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                                    inWishListModel =
                                        await graphQLService.inWishList(
                                            widget.popularProductModel!
                                                .popularProducts![index].id!,
                                            widget.token ?? "");
                                    print(
                                        "inWishListModelget========${inWishListModel!.inWishlist}");

                                    widget
                                            .popularProductModel!
                                            .popularProducts![index]
                                            .inWishlist =
                                        toggleWishListModel!.toggleWishlist;
                                    setState(() {});
                                  } else {
                                    Get.toNamed(Routes.logInScreen);
                                  }

                                  print(
                                      "popularProductModel!.popularProducts![index].inWishlist======${widget.popularProductModel!.popularProducts![index].id}");
                                  print(
                                      "popularProductModel!.popularProducts![index].inWishlist======${widget.popularProductModel!.popularProducts![index].inWishlist}");
                                },
                                child: Image.asset(
                                  widget
                                              .popularProductModel!
                                              .popularProducts![index]
                                              .inWishlist ==
                                          true
                                      ? "asset/images/like_icon.png"
                                      : "asset/images/favorite.png",
                                  //fit: BoxFit.fill,
                                  height: SizeUtils.verticalBlockSize * 3,
                                  //    width: SizeUtils.horizontalBlockSize*40
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.verticalBlockSize * 1,
                              bottom: SizeUtils.verticalBlockSize * 3),
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 2,
                              ),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 40,
                                child: CustomText(
                                  maxLines: 1,
                                  name:
                                      "${widget.popularProductModel!.popularProducts![index].name}",
                                  fontSize: SizeUtils.fSize_14(),
                                  color: AppColor.grayColor,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 1,
                            ),
                            //const SizedBox(width: 5,),
                            CustomText(
                              name:
                                  "Rp${widget.popularProductModel!.popularProducts![index].salePrice}",
                              color: AppColor.greenColor,
                              fontSize: SizeUtils.fSize_13(),
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(
                              name:
                                  "/ ${widget.popularProductModel!.popularProducts![index].unit}",
                              color: AppColor.grayColor,
                              fontSize: SizeUtils.fSize_10(),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.verticalBlockSize * 1),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 16,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        name:
                                            "Rp ${widget.popularProductModel!.popularProducts![index].price}",
                                        color: AppColor.greenColor,
                                        fontSize: SizeUtils.fSize_12(),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomText(
                                        name:
                                            "Rp ${widget.popularProductModel!.popularProducts![index].maxPrice}",
                                        color: AppColor.grayTextColor,
                                        fontSize: SizeUtils.fSize_11(),
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              widget.popularProductModel!
                                          .popularProducts![index].qtn ==
                                      null || widget.popularProductModel!.popularProducts![index].qtn==0
                                  ? GestureDetector(
                                      onTap: () async {

                                       if(token!="")
                                         {
                                           print("tap");
                                           variationsProductModel =
                                           await graphQLService
                                               .variationsProduct(
                                               widget.token ?? "",
                                               widget
                                                   .popularProductModel!
                                                   .popularProducts![index]
                                                   .id!);

                                           if (variationsProductModel!
                                               .product!.variations!.isEmpty) {
                                             count = int.parse(
                                                 "${widget.popularProductModel!.popularProducts![index].qtn == null ? 0 : widget.popularProductModel!.popularProducts![index].qtn}");

                                             setState(() {
                                               widget
                                                   .popularProductModel!
                                                   .popularProducts![index]
                                                   .qtn = count + 1;
                                             });
                                             await popularAddProduct(
                                               widget.popularProductModel!
                                                   .popularProducts![index].id,
                                               widget
                                                   .popularProductModel!
                                                   .popularProducts![index]
                                                   .image!
                                                   .original,
                                               widget
                                                   .popularProductModel!
                                                   .popularProducts![index]
                                                   .salePrice
                                                   .toString(),
                                               widget.popularProductModel!
                                                   .popularProducts![index].qtn,
                                               widget.popularProductModel!
                                                   .popularProducts![index].name,
                                               widget.popularProductModel!
                                                   .popularProducts![index].unit,
                                             );
                                           }
                                         }
                                       else
                                         {
                                           Get.toNamed(Routes.logInScreen);
                                         }


                                        // variationsProductModel =
                                        //     await graphQLService
                                        //         .variationsProduct(
                                        //             widget.token ?? "",
                                        //             widget
                                        //                 .popularProductModel!
                                        //                 .popularProducts![index]
                                        //                 .id!);
                                        // // variationsProductModel=await graphQLService.variationsProduct(widget.token??"","953");
                                        // print(
                                        //     "variationsProductModel====${variationsProductModel!.product!.variations!.length}");
                                        // if (variationsProductModel!
                                        //     .product!.variations!.isEmpty) {
                                        //   addProductModel = await graphQLService
                                        //       .addToCartProduct(widget
                                        //           .popularProductModel!
                                        //           .popularProducts![index]
                                        //           .id!);
                                        //   print(
                                        //       "addProductModel====${addProductModel!.addtocartProduct}");
                                        //   print(
                                        //       "addProductModel====${widget.popularProductModel!.popularProducts![index].id!}");
                                        //   if (addProductModel!
                                        //           .addtocartProduct ==
                                        //       "Success") {
                                        //     widget
                                        //         .popularProductModel!
                                        //         .popularProducts![index]
                                        //         .qtn = count + 1;
                                        //
                                        //     storeData.add(widget
                                        //         .popularProductModel!
                                        //         .popularProducts![index]);
                                        //
                                        //     print(
                                        //         "storeData=====${storeData[0].qtn}");
                                        //     setState(() {});
                                        //   }
                                        // }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Container(
                                          height:
                                              SizeUtils.verticalBlockSize * 4.3,
                                          width: SizeUtils.horizontalBlockSize *
                                              20,
                                          decoration: BoxDecoration(
                                            color: AppColor.greenColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(children: [
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Icon(Icons.add,
                                                color:
                                                    AppColor.backGroundColor),
                                            CustomText(
                                              name: "Add",
                                              color: AppColor.backGroundColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeUtils.fSize_14(),
                                            )
                                          ]),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Container(
                                        height:
                                            SizeUtils.verticalBlockSize * 4.3,
                                        width:
                                            SizeUtils.horizontalBlockSize * 22,
                                        decoration: BoxDecoration(
                                          color: AppColor.greenColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // SizedBox(width: 4,),
                                                GestureDetector(
                                                  onTap: () async {
                                                    print("tap");
                                                    if (widget.popularProductModel!.popularProducts![index].qtn != null &&
                                                        int.parse(widget.popularProductModel!.popularProducts![index].qtn.toString()) != 0) {

                                                      print("get to popular");
                                                      count = int.parse(widget.popularProductModel!.popularProducts![index].qtn.toString());
                                                      print("count=====$count");
                                                      widget.popularProductModel!.popularProducts![index].qtn = count - 1;

                                                      if (widget.popularProductModel!.popularProducts![index].qtn == 0) {
                                                        print("get to popular10");
                                                        widget.popularProductModel!.popularProducts![index].qtn = null;
                                                        print(
                                                            " popularProduct.qtn====${widget.popularProductModel!.popularProducts![index].qtn}");


                                                        productRemoveModel = await graphQLService.cartProductRemove(widget.popularProductModel!.popularProducts![index].id!);

                                                        print(
                                                            "addProductModel====${widget.popularProductModel!.popularProducts![index].id}");
                                                        if (productRemoveModel!.addtocartProductRemove == "Success") {
                                                          print("get to popular100");
                                                          await popularDecreaseProduct(
                                                              widget.popularProductModel!.popularProducts![index].id,
                                                              widget.popularProductModel!.popularProducts![index].image!.original,
                                                              widget.popularProductModel!.popularProducts![index].salePrice.toString(),
                                                       0,
                                                       //       widget.popularProductModel!.popularProducts![index].qtn,
                                                              widget.popularProductModel!.popularProducts![index].name,
                                                              widget.popularProductModel!.popularProducts![index].unit);
                                      // nonVariationCartProduct.removeWhere((element) => element.productId == widget.popularProductModel!.popularProducts![index].id);

                                                          //count = 0;
                                                        }
                                                        saveListInSharedPreferences();
                                                      } else {
                                                        print("get to popular1000");
                                                        setState(() {});
                                                        await popularDecreaseProduct(
                                                            widget.popularProductModel!.popularProducts![index].id,
                                                            widget.popularProductModel!.popularProducts![index].image!.original,
                                                            widget.popularProductModel!.popularProducts![index].salePrice.toString(),
                                                            widget.popularProductModel!.popularProducts![index].qtn,
                                                            widget.popularProductModel!.popularProducts![index].name,
                                                            widget.popularProductModel!.popularProducts![index].unit);
                                                        saveListInSharedPreferences();
                                                      }

                                                      print(
                                                          "qtn=====${widget.popularProductModel!.popularProducts![index].qtn}");
                                                      saveListInSharedPreferences();
                                                    }
                                                    setState(() {});
                                                    // await popularDecreaseProduct(
                                                    // widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].id,
                                                    // widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].image!.original,
                                                    // widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].salePrice.toString(),
                                                    // widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].qtn, widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].name,
                                                    // widget
                                                    //     .popularProductModel!
                                                    //     .popularProducts![index].unit);

                                                    // setState(() {
                                                    //
                                                    // });
                                                    // else if(int.parse(widget.popularProductModel!.popularProducts![index].qtn.toString())==0)
                                                    //   {
                                                    //     widget.popularProductModel!.popularProducts![index].qtn=null;
                                                    //     setState(() {
                                                    //
                                                    //     });
                                                    //   }
                                                    // else
                                                    //   {
                                                    //     widget.popularProductModel!.popularProducts![index].qtn=null;
                                                    //     setState(() {
                                                    //

                                                    //     });
                                                    //   }
                                                  },
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color: AppColor

                                                          .backGroundColor),
                                                ),
                                                CustomText(
                                                  name:
                                                      "${widget.popularProductModel!.popularProducts![index].qtn}",
                                                  color:
                                                      AppColor.backGroundColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      SizeUtils.fSize_14(),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    print("tap");

                                                    count = int.parse(widget
                                                        .popularProductModel!
                                                        .popularProducts![index]
                                                        .qtn
                                                        .toString());

                                                    widget
                                                        .popularProductModel!
                                                        .popularProducts![index]
                                                        .qtn = count + 1;
                                                    setState(() {});
                                                    await popularIncreaseProduct(
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .id,
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .image!
                                                            .original,
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .salePrice
                                                            .toString(),
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .qtn,
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .name,
                                                        widget
                                                            .popularProductModel!
                                                            .popularProducts![
                                                                index]
                                                            .unit);


                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColor
                                                        .backGroundColor,
                                                  ),
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
      ],
    );
  }

  Future<void> popularAddProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storePopularProduct(productId, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

  Future<void> storePopularProduct(
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

  Future<void> popularDecreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storePopularProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);
  }

  popularIncreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storePopularProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }
}
