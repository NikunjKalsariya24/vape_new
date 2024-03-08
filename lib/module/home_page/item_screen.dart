import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/model/view_wish_list_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';

import 'product_details.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  GraphQLService graphQLService = GraphQLService();

  // GraphQLService graphQLService=Get.put(GraphQLService());
  ViewWishListData? viewWishListModel;
  SharedPrefService sharedPrefService = SharedPrefService();
  bool isViewWish = false;
  String token="";
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  List<NonVariationProductModel> nonVariationCartProduct = [];

  VariationsData? variationsProductModel;

  int count=0;

  AddProductData? addProductModel;

  ProductRemoveData? productRemoveModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     token = sharedPrefService.getToken();
     print("object");

    token!=""? getViewWishData():SizedBox();
  }

  getViewWishData() async {



    if (mounted) {
      setState(() {
        isViewWish = true;
      });



      // Assuming graphQLService and viewWishListModel are defined elsewhere
      // Replace with your actual code
      viewWishListModel = await graphQLService.viewWishList(token ?? "", 10, 1);

      if (mounted) {
        setState(() {
          isViewWish = false;
        });
      }

      if (viewWishListModel != null &&
          viewWishListModel!.wishlists != null &&
          viewWishListModel!.wishlists!.data != null) {
        getAllProduct();
        print(
            "viewWishListModel======${viewWishListModel!.wishlists!.data!.length}");
      }
    }
  }
  Future<void> getAllProduct() async {

    await getListFromSharedPreferences();



    nonVariationCartProduct.forEach((element) {
      viewWishListModel!.wishlists!.data
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: CustomAppBar(
            title: "Favorite Product",
            automaticallyImplyLeading: false,
            leadingIcon: false),
        body: token==""?Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
          GestureDetector(
              onTap: () {
                Get.toNamed(Routes.logInScreen);
              },
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: SizeUtils.verticalBlockSize*10),
                child: CustomButton(
                  buttonName:
                 "Log In" ,
                ),
              )),



        ],):isViewWish
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 3),
                child: SingleChildScrollView(
                  child: Column(children: [
                    GridView.builder(
                      shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                      itemCount: viewWishListModel!.wishlists!.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 0.55),
                      itemBuilder: (context, index) {
                        print("viewWishListModel!.wishlists!.data![index].qtn====${viewWishListModel!.wishlists!.data![index].qtn}");
                        return Container(
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
                                        'productId': viewWishListModel!.wishlists!.data![index].id,
                                        'productSlug': viewWishListModel!.wishlists!.data![index].slug,
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
                                          "${viewWishListModel!.wishlists!.data![index].image!.original}",
                                          fit: BoxFit.fill,
                                          height:
                                              SizeUtils.verticalBlockSize * 23,
                                          width:
                                              SizeUtils.horizontalBlockSize * 44),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        print(
                                            "popularProductModel!.popularProducts![index].inWishlist======${viewWishListModel!.wishlists!.data![index].id}");
                                        print("like");

                                        if (token != null) {
                                          // popularProductModel!.popularProducts![index].inWishlist =
                                          // !(popularProductModel!.popularProducts![index].inWishlist ?? false);

                                          toggleWishListModel =
                                              await graphQLService.wishListToggle(
                                                  viewWishListModel!.wishlists!
                                                      .data![index].id!,
                                                  token ?? "");
                                          print(
                                              "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                                          inWishListModel =
                                              await graphQLService.inWishList(
                                                  viewWishListModel!.wishlists!
                                                      .data![index].id!,
                                                  token ?? "");
                                          print(
                                              "inWishListModelget========${inWishListModel!.inWishlist}");

                                          viewWishListModel!.wishlists!
                                                  .data![index].inWishlist =
                                              toggleWishListModel!.toggleWishlist;
                                          setState(() {});
                                        } else {
                                          Get.toNamed(Routes.logInScreen);
                                        }

                                        print(
                                            "popularProductModel!.popularProducts![index].inWishlist======${viewWishListModel!.wishlists!.data![index].id}");
                                        print(
                                            "popularProductModel!.popularProducts![index].inWishlist======${viewWishListModel!.wishlists!.data![index].inWishlist}");
                                      },
                                      child: Image.asset(
                                        viewWishListModel!.wishlists!.data![index]
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
                                            "${viewWishListModel!.wishlists!.data![index].name}",
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
                                        "Rp${viewWishListModel!.wishlists!.data![index].salePrice}",
                                    color: AppColor.greenColor,
                                    fontSize: SizeUtils.fSize_13(),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  CustomText(
                                    name:
                                        "/ ${viewWishListModel!.wishlists!.data![index].unit}",
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
                                      child: Container(
                                        width: SizeUtils.horizontalBlockSize * 16,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              name:
                                                  "Rp ${viewWishListModel!.wishlists!.data![index].price}",
                                              color: AppColor.greenColor,
                                              fontSize: SizeUtils.fSize_12(),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            CustomText(
                                              name:
                                                  "Rp ${viewWishListModel!.wishlists!.data![index].maxPrice}",
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
                                     viewWishListModel!.wishlists!.data![index].qtn==null ||  viewWishListModel!.wishlists!.data![index].qtn==0
                                         ? Padding(
                                       padding: const EdgeInsets.symmetric(
                                           horizontal: 4),
                                       child: GestureDetector(onTap: () async {
                                         if(token!="")
                                         {
                                           print("tap");
                                           variationsProductModel =
                                               await graphQLService
                                               .variationsProduct(
                                             token ?? "",
                                                   viewWishListModel!.wishlists!.data![index]
                                                   .id!);

                                           if (variationsProductModel!
                                               .product!.variations!.isEmpty) {
                                             count = int.parse(
                                                 "${viewWishListModel!.wishlists!.data![index].qtn == null ? 0 : viewWishListModel!.wishlists!.data![index].qtn}");

                                             setState(() {
                                               viewWishListModel!.wishlists!.data![index]
                                                   .qtn = count + 1;
                                             });
                                             await favoriteAddProduct(
                                               viewWishListModel!.wishlists!.data![index].id,
                                               viewWishListModel!.wishlists!.data![index]
                                                 .image!
                                                 .original,
                                               viewWishListModel!.wishlists!.data![index]
                                                 .salePrice
                                                 .toString(),
                                               viewWishListModel!.wishlists!.data![index].qtn,
                                               viewWishListModel!.wishlists!.data![index].name,
                                               viewWishListModel!.wishlists!.data![index].unit,
                                             );
                                           }
                                         }
                                         else
                                         {
                                           Get.toNamed(Routes.logInScreen);
                                         }
                                       },
                                         child: Container(
                                           height:
                                           SizeUtils.verticalBlockSize *
                                               4.3,
                                           width:
                                           SizeUtils.horizontalBlockSize *
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
                                     ):Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Container(
                                              height:
                                                  SizeUtils.verticalBlockSize *
                                                      4.3,
                                              width:
                                                  SizeUtils.horizontalBlockSize *
                                                      22,
                                              decoration: BoxDecoration(
                                                color: AppColor.greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // SizedBox(width: 4,),
                                                      GestureDetector(onTap: () async {
                                                        if (viewWishListModel!.wishlists!.data![index].qtn != null &&
                                                            int.parse(viewWishListModel!.wishlists!.data![index].qtn.toString()) != 0) {

                                                          print("get to popular");
                                                          count = int.parse(viewWishListModel!.wishlists!.data![index].qtn.toString());
                                                          print("count=====$count");
                                                          viewWishListModel!.wishlists!.data![index].qtn = count - 1;

                                                          if (viewWishListModel!.wishlists!.data![index].qtn == 0) {
                                                            print("get to popular10");
                                                            viewWishListModel!.wishlists!.data![index].qtn = null;
                                                            print(
                                                                " popularProduct.qtn====${viewWishListModel!.wishlists!.data![index].qtn}");


                                                            productRemoveModel = await graphQLService.cartProductRemove(viewWishListModel!.wishlists!.data![index].id!);

                                                            print(
                                                                "addProductModel====${viewWishListModel!.wishlists!.data![index].id}");
                                                            if (productRemoveModel!.addtocartProductRemove == "Success") {
                                                              print("get to popular100");
                                                              await popularDecreaseProduct(
                                                                  viewWishListModel!.wishlists!.data![index].id,
                                                                  viewWishListModel!.wishlists!.data![index].image!.original,
                                                                  viewWishListModel!.wishlists!.data![index].salePrice.toString(),
                                                              0,
                                                              //       widget.popularProductModel!.popularProducts![index].qtn,
                                                                  viewWishListModel!.wishlists!.data![index].name,
                                                                  viewWishListModel!.wishlists!.data![index].unit);
                                                              // nonVariationCartProduct.removeWhere((element) => element.productId == widget.popularProductModel!.popularProducts![index].id);

                                                              //count = 0;
                                                            }
                                                            saveListInSharedPreferences();
                                                          } else {
                                                            print("get to popular1000");
                                                            setState(() {});
                                                            await popularDecreaseProduct(
                                                                viewWishListModel!.wishlists!.data![index].id,
                                                                viewWishListModel!.wishlists!.data![index].image!.original,
                                                                viewWishListModel!.wishlists!.data![index].salePrice.toString(),
                                                                viewWishListModel!.wishlists!.data![index].qtn,
                                                                viewWishListModel!.wishlists!.data![index].name,
                                                                viewWishListModel!.wishlists!.data![index].unit);
                                                            saveListInSharedPreferences();
                                                          }

                                                          print(
                                                              "qtn=====${viewWishListModel!.wishlists!.data!
                                                              [index].qtn}");
                                                          saveListInSharedPreferences();
                                                        }
                                                        setState(() {});
                                                      },
                                                        child: const Icon(Icons.remove,
                                                            color: AppColor
                                                                .backGroundColor),
                                                      ),
                                                      CustomText(
                                                        name:
                                                            "${viewWishListModel!.wishlists!.data![index].qtn}",
                                                        color: AppColor
                                                            .backGroundColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            SizeUtils.fSize_14(),
                                                      ),
                                                      GestureDetector(onTap: () async {

                                                        count = int.parse( viewWishListModel!.wishlists!.data![index]
                                                            .qtn
                                                            .toString());

                                                        viewWishListModel!.wishlists!.data![index]
                                                            .qtn = count + 1;
                                                        setState(() {});
                                                        await increaseFavoriteProduct(
                                                            viewWishListModel!.wishlists!.data![
                                                        index]
                                                            .id,
                                                            viewWishListModel!.wishlists!.data![
                                                        index]
                                                            .image!
                                                            .original,
                                                            viewWishListModel!.wishlists!.data![
                                                        index]
                                                            .salePrice
                                                            .toString(),
                                                            viewWishListModel!.wishlists!.data![
                                                        index]
                                                            .qtn,
                                                            viewWishListModel!.wishlists!.data![
                                                        index]
                                                            .name,
                                                            viewWishListModel!.wishlists!.data![
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
                        );
                      },
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: viewWishListModel!.wishlists!.data!.length,
                    //   physics: const BouncingScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     return Column(
                    //       children: [
                    //         Container(
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container(
                    //                 // boxShadow: [
                    //                 //   BoxShadow(
                    //                 //     color: Colors.black.withOpacity(0.25), // Shadow color
                    //                 //     offset: Offset(0, 0), // X and Y offset
                    //                 //     blurRadius: 8, // Blur radius
                    //                 //     spreadRadius: 0, // Spread radius
                    //                 //   ),
                    //                 // ],
                    //                 // ),
                    //                 child: Image.network(
                    //                   "${viewWishListModel!.wishlists!.data![index].image?.original}",
                    //                   width: SizeUtils.verticalBlockSize * 15,
                    //                   //height: SizeUtils.verticalBlockSize*17
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: SizeUtils.horizontalBlockSize * 3,
                    //               ),
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   SizedBox(
                    //                     height: SizeUtils.verticalBlockSize * 1,
                    //                   ),
                    //                   Container(height: SizeUtils.verticalBlockSize*6,width: SizeUtils.horizontalBlockSize*35,
                    //                     child: CustomText(maxLines: 2,
                    //                         name: "${viewWishListModel!.wishlists!.data![index].name}",
                    //                         fontSize: SizeUtils.fSize_13(),
                    //                         fontWeight: FontWeight.w600,
                    //                         color: AppColor.blackColor),
                    //                   ),
                    //                   // CustomText(
                    //                   //     name: "Running Shoes",
                    //                   //     fontSize: SizeUtils.fSize_13(),
                    //                   //     fontWeight: FontWeight.w600,
                    //                   //     color: AppColor.blackColor),
                    //                   SizedBox(height: SizeUtils.verticalBlockSize*4,),
                    //                   // Padding(
                    //                   //   padding: EdgeInsets.symmetric(
                    //                   //       vertical: SizeUtils.verticalBlockSize * 1),
                    //                   //   child: Row(
                    //                   //     children: [
                    //                   //       CustomText(
                    //                   //         name: "Color:",
                    //                   //         fontSize: SizeUtils.fSize_11(),
                    //                   //         fontWeight: FontWeight.w400,
                    //                   //         color: AppColor.blackNoteColor,
                    //                   //       ),
                    //                   //       SizedBox(
                    //                   //         width: SizeUtils.horizontalBlockSize * 1,
                    //                   //       ),
                    //                   //       CustomText(
                    //                   //         name: "Gray",
                    //                   //         fontSize: SizeUtils.fSize_11(),
                    //                   //         fontWeight: FontWeight.w400,
                    //                   //         color: AppColor.blackColor,
                    //                   //       ),
                    //                   //       SizedBox(
                    //                   //         width: SizeUtils.horizontalBlockSize * 4,
                    //                   //       ),
                    //                   //       CustomText(
                    //                   //         name: "Size:",
                    //                   //         fontSize: SizeUtils.fSize_11(),
                    //                   //         fontWeight: FontWeight.w400,
                    //                   //         color: AppColor.blackNoteColor,
                    //                   //       ),
                    //                   //       SizedBox(
                    //                   //         width: SizeUtils.horizontalBlockSize * 1,
                    //                   //       ),
                    //                   //       CustomText(
                    //                   //         name: "${viewWishListModel!.wishlists!.data![index].inWishlist}",
                    //                   //         fontSize: SizeUtils.fSize_11(),
                    //                   //         fontWeight: FontWeight.w400,
                    //                   //         color: AppColor.blackColor,
                    //                   //       )
                    //                   //     ],
                    //                   //   ),
                    //                   // ),
                    //                   Container(
                    //                     height: SizeUtils.verticalBlockSize * 4,
                    //                     width: SizeUtils.horizontalBlockSize * 25,
                    //                     decoration: BoxDecoration(
                    //                         color: AppColor.greenColor,
                    //                         borderRadius: BorderRadius.circular(6)),
                    //                     child: Center(
                    //                       child: Row(
                    //                           mainAxisAlignment:
                    //                           MainAxisAlignment.spaceEvenly,
                    //                           children: [
                    //                             const Icon(
                    //                               Icons.remove,
                    //                               color: AppColor.backGroundColor,
                    //                             ),
                    //                             CustomText(
                    //                               name: "${viewWishListModel!.wishlists!.data![index].quantity}",
                    //                               fontSize: SizeUtils.fSize_13(),
                    //                               fontWeight: FontWeight.w700,
                    //                               color: AppColor.backGroundColor,
                    //                             ),
                    //                             const Icon(
                    //                               Icons.add,
                    //                               color: AppColor.backGroundColor,
                    //                             ),
                    //                           ]),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               const Spacer(),
                    //               Padding(
                    //                 padding: EdgeInsets.symmetric(
                    //                     vertical: 0),
                    //                 child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    //                   children: [
                    //                     Padding(
                    //                       padding:
                    //                       const EdgeInsets.all(0.0),
                    //                       child: GestureDetector(onTap: () async {
                    //
                    //                     //    print("popularProductModel!.popularProducts![index].inWishlist======${popularProductModel!.popularProducts![index].id}");
                    //                         print("like");
                    //
                    //
                    //                         if(token != null)
                    //                         {
                    //
                    //                           // popularProductModel!.popularProducts![index].inWishlist =
                    //                           // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                    //
                    //                           toggleWishListModel =await graphQLService.wishListToggle(viewWishListModel!.wishlists!.data![index].id!,token??"");
                    //                           print("toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                    //                           inWishListModel=await graphQLService.inWishList(viewWishListModel!.wishlists!.data![index].id!,token??"");
                    //                           print("inWishListModelget========${inWishListModel!.inWishlist}");
                    //                           viewWishListModel!.wishlists!.data![index].inWishlist=toggleWishListModel!.toggleWishlist;
                    //                           setState(() {
                    //                           });
                    //
                    //                         }
                    //                         else
                    //                         {
                    //
                    //                           Get.toNamed(Routes.logInScreen);
                    //
                    //                         }
                    //
                    //
                    //
                    //
                    //                       },
                    //                         child: Image.asset(
                    //                           viewWishListModel!.wishlists!.data![index].inWishlist==true?"asset/images/like_icon.png" :  "asset/images/favorite.png",
                    //                           //fit: BoxFit.fill,
                    //                           height: SizeUtils
                    //                               .verticalBlockSize *
                    //                               3,
                    //                           //    width: SizeUtils.horizontalBlockSize*40
                    //                         ),
                    //                       ),
                    //                     ),
                    //
                    //                     Row(
                    //                       children: [
                    //                         CustomText(
                    //                           name: "Rp${viewWishListModel!.wishlists!.data![index].salePrice} ",
                    //                           fontSize: SizeUtils.fSize_12(),
                    //                           fontWeight: FontWeight.w700,
                    //                           color: AppColor.blackColor,
                    //                         ),
                    //                         CustomText(
                    //                           name: "/${viewWishListModel!.wishlists!.data![index].unit} ",
                    //                           fontSize: SizeUtils.fSize_12(),
                    //                           fontWeight: FontWeight.w700,
                    //                           color: AppColor.blackColor,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     SizedBox(
                    //                       height: SizeUtils.verticalBlockSize * 1,
                    //                     ),
                    //                     // GestureDetector(
                    //                     //   onTap: () {
                    //                     //    // getBottomSheet(context);
                    //                     //   },
                    //                     //   child: Row(
                    //                     //     children: [
                    //                     //       CustomText(
                    //                     //         name: "Update",
                    //                     //         fontSize: SizeUtils.fSize_11(),
                    //                     //         fontWeight: FontWeight.w500,
                    //                     //         color: AppColor.blackNoteColor,
                    //                     //       ),
                    //                     //       const Icon(Icons.keyboard_arrow_down)
                    //                     //     ],
                    //                     //   ),
                    //                     // )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: SizeUtils.verticalBlockSize * 4,
                    //         )
                    //       ],
                    //     );
                    //   },
                    // ),
                  ]),
                ),
              ),
      ),
    );
  }

  getLogIn() {

    Get.toNamed(Routes.logInScreen);
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

  favoriteAddProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storeFavoriteProduct(productId, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

  storeFavoriteProduct( String productId,
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

  popularDecreaseProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeFavoriteProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
    
    
  }

  increaseFavoriteProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeFavoriteProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }


}
