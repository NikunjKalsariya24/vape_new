import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/people_buy_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import 'product_details.dart';

class PeopleBuyView extends StatefulWidget {
  PeopleBuyData? peopleBuyModel;
  String? token;
   PeopleBuyView({required this.peopleBuyModel,required this.token,super.key});

  @override
  State<PeopleBuyView> createState() => _PeopleBuyViewState();
}

class _PeopleBuyViewState extends State<PeopleBuyView> {
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
      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products!
          ?.forEach((elementPopularProduct) {
        if (element.productId == elementPopularProduct.id) {
          elementPopularProduct.qtn = element.productQuantity;
        }

        setState(() {});
      });
    });
  }

  getListFromSharedPreferences() async {
    final saveListJson = sharedPrefService.nonVariationProductGet();

    if (saveListJson != "") {
      final List<dynamic> decodedList = json.decode(saveListJson);

      nonVariationCartProduct = decodedList
          .map((item) => NonVariationProductModel.fromJson(item))
          .toList();
    } else {
      nonVariationCartProduct = [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [

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
              name: "People also buy This",
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
      Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          //height:280,
          height: SizeUtils.verticalBlockSize * 40,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.peopleBuyModel?.types?.length,
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            GestureDetector(
                              onTap: () {


                                Get.toNamed(Routes.productDetails,
                                    arguments: {

                                      'productId': widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id,

                                      'productSlug':  widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].slug,

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
                                    topRight:
                                    Radius.circular(15),
                                    topLeft:
                                    Radius.circular(
                                        15)),
                                child: Image.network(
                                    "${ widget.peopleBuyModel?.types![0].settings?.handpickedProducts?.products?[index].image?.original}",
                                    fit: BoxFit.fill,
                                    height: SizeUtils
                                        .verticalBlockSize *
                                        23,
                                    width: SizeUtils
                                        .horizontalBlockSize *
                                        44),
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //   const EdgeInsets.all(4.0),
                            //   child: GestureDetector(onTap: () async {
                            //
                            //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                            //     print("like");
                            //
                            //
                            //     if(token != null)
                            //     {
                            //
                            //       // popularProductModel!.popularProducts![index].inWishlist =
                            //       // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                            //
                            //       toggleWishListModel =await graphQLService.wishListToggle(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                            //       print("toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                            //       inWishListModel=await graphQLService.inWishList(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                            //       print("inWishListModelget========${inWishListModel!.inWishlist}");
                            //
                            //
                            //
                            //       bestSellingModel!.bestSellingProducts![index].inWishlist=toggleWishListModel!.toggleWishlist;
                            //       setState(() {
                            //       });
                            //
                            //     }
                            //     else
                            //     {
                            //
                            //       Get.toNamed(Routes.logInScreen);
                            //
                            //     }
                            //
                            //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                            //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist}");
                            //
                            //
                            //
                            //   },
                            //     child: Image.asset(
                            //       peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist==true ?"asset/images/like_icon.png": "asset/images/favorite.png",
                            //       //fit: BoxFit.fill,
                            //       height: SizeUtils
                            //           .verticalBlockSize *
                            //           3,
                            //       //    width: SizeUtils.horizontalBlockSize*40
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.verticalBlockSize *
                                  1,
                              bottom:
                              SizeUtils.verticalBlockSize *
                                  3),
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeUtils
                                    .horizontalBlockSize *
                                    2,
                              ),
                              SizedBox(
                                width: SizeUtils
                                    .horizontalBlockSize *
                                    40,
                                child: CustomText(
                                  maxLines: 1,
                                  name:
                                  "${ widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].name}",
                                  fontSize:
                                  SizeUtils.fSize_14(),
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
                              width: SizeUtils
                                  .horizontalBlockSize *
                                  1,
                            ),
                            //const SizedBox(width: 5,),
                            CustomText(
                              name:
                              "Rp${ widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].salePrice}",
                              color: AppColor.greenColor,
                              fontSize: SizeUtils.fSize_13(),
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(
                              name:
                              "/ ${ widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].unit}",
                              color: AppColor.grayColor,
                              fontSize: SizeUtils.fSize_10(),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeUtils.verticalBlockSize *
                                  1),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 3),
                                child: Container(
                                  width: SizeUtils
                                      .horizontalBlockSize *
                                      16,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      CustomText(
                                        name:
                                        "Rp ${ widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].price ?? 0}",
                                        color:
                                        AppColor.greenColor,
                                        fontSize: SizeUtils
                                            .fSize_12(),
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                      CustomText(
                                        name:
                                        "Rp ${widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].maxPrice ?? 0}",
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
                             widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].qtn == null
                             ||      widget.peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].qtn==0
                                  ? Padding(
                               padding: const EdgeInsets
                                   .symmetric(
                                   horizontal: 4),
                               child: GestureDetector(onTap:() async {


                                 if(token !="")
                                   {
                                     variationsProductModel =
                                     await graphQLService
                                         .variationsProduct(
                                         widget.token ?? "",
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                             .id!);

                                     if (variationsProductModel!
                                         .product!.variations!.isEmpty) {
                                       count = int.parse(
                                           "${ widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn == null ? 0 :  widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn}");

                                       setState(() {
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                             .qtn = count + 1;
                                       });
                                       await peopleBuyAddProduct(
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id,
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                             .image!
                                             .original,
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                             .salePrice
                                             .toString(),
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn,
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].name,
                                         widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].unit,
                                       );
                                     }

                                   }
                                 else
                                   {
                                     Get.toNamed(Routes.logInScreen);
                                   }




                               } ,
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
                                         .circular(6),
                                   ),
                                   child: Row(children: [
                                     const SizedBox(
                                       width: 4,
                                     ),
                                     const Icon(Icons.add,
                                         color: AppColor
                                             .backGroundColor),
                                     CustomText(
                                       name: "Add",
                                       color: AppColor
                                           .backGroundColor,
                                       fontWeight:
                                       FontWeight.w500,
                                       fontSize: SizeUtils
                                           .fSize_14(),
                                     )
                                   ]),
                                 ),
                               ),
                             ):Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    horizontal: 4),
                                child: Container(
                                  height: SizeUtils
                                      .verticalBlockSize *
                                      4.3,
                                  width: SizeUtils
                                      .horizontalBlockSize *
                                      22,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColor
                                        .greenColor,
                                    borderRadius:
                                    BorderRadius
                                        .circular(6),
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        0),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          // SizedBox(width: 4,),
                                          GestureDetector(onTap: () async {


                                            if ( widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .qtn !=
                                                null &&
                                                int.parse( widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .qtn
                                                    .toString()) !=
                                                    0) {
                                              count = int.parse( widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                              index]
                                                  .qtn
                                                  .toString());
                                              print("count=====$count");
                                              widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                              index]
                                                  .qtn = count - 1;

                                              if ( widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                              index]
                                                  .qtn ==
                                                  0) {
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .qtn = null;
                                                print(
                                                    " popularProduct.qtn====${ widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn}");


                                                productRemoveModel =
                                                    await graphQLService
                                                    .cartProductRemove( widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .id!);

                                                print(
                                                    "addProductModel====${ widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                                                if (productRemoveModel!
                                                    .addtocartProductRemove ==
                                                    "Success") {
                                                  await peopleBuyDecreaseProduct(
                                                      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                      index]
                                                          .id,
                                                      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                      index]
                                                          .image!
                                                          .original,
                                                      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                      index]
                                                          .salePrice
                                                          .toString(),
                                                   0,
                                                      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                      index]
                                                          .name,
                                                      widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                      index]
                                                          .unit);

                                                  //count = 0;
                                                }
                                                saveListInSharedPreferences();
                                              } else {

                                                await peopleBuyDecreaseProduct(
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .id,
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .image!
                                                    .original,
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .salePrice
                                                    .toString(),
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .qtn,
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .name,
                                                    widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                                index]
                                                    .unit);
                                              }

                                              print(
                                                  "qtn=====${ widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn}");
                                              saveListInSharedPreferences();
                                            }
                                            setState(() {

                                            });
                                          },
                                            child: const Icon(
                                                Icons
                                                    .remove,
                                                color: AppColor
                                                    .backGroundColor),
                                          ),
                                          CustomText(
                                            name:
                                            "${ widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].qtn}",
                                            color: AppColor
                                                .backGroundColor,
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontSize:
                                            SizeUtils
                                                .fSize_14(),
                                          ),
                                          GestureDetector(onTap: () async {


                                            count = int.parse(widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                                .qtn
                                                .toString());

                                            widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index]
                                                .qtn = count + 1;
                                            setState(() {});
                                            await peopleBuyIncreaseProduct(
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .id,
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .image!
                                                .original,
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .salePrice
                                                .toString(),
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .qtn,
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
                                            index]
                                                .name,
                                                widget.peopleBuyModel!.types![0].settings!.handpickedProducts!.products![
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
      ),
    ],);
  }

  peopleBuyAddProduct(String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storePeopleBuyProduct(productId, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();



  }

  Future<void> storePeopleBuyProduct(
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

  peopleBuyDecreaseProduct( String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {




    await storePeopleBuyProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
  }

  peopleBuyIncreaseProduct( String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {

    await storePeopleBuyProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

}
