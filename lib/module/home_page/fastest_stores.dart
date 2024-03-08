import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/people_buy_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/related_recommended_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/module/cart_page/cart_screen.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/module/home_page/item_screen.dart';
import 'package:vape/module/home_page/massage_screen.dart';
import 'package:vape/module/home_page/people_alsobuy_view.dart';
import 'package:vape/module/home_page/product_details.dart';
import 'package:vape/module/home_page/product_home_page.dart';
import 'package:vape/module/home_page/profile/profile_screen.dart';
import 'package:vape/near_store_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import 'related_recommended_product.dart';

class FastestStore extends StatefulWidget {
  const FastestStore({super.key});

  @override
  State<FastestStore> createState() => _FastestStoreState();
}

class _FastestStoreState extends State<FastestStore> {

  BottomBarController bottomBarController=Get.put(BottomBarController());
  List topOfferImage = [
    "asset/images/top_offer_one.png",
    "asset/images/top_offer_two.png",
    "asset/images/top_offer_three.png",
    "asset/images/top_offer_four.png",
    "asset/images/top_offer_five.png",
    "asset/images/top_offer_six.png"
  ];

  List topOfferName = [
    "Food Packs",
    "Soft Drinks",
    "Dairy food",
    "Beverages",
    "Snacks",
    "Bravrage food"
  ];
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  final pages = [
    ProductHomePage(),
    const ItemScreen(),
    const CartScreen(),
    const MassageScreen(),
    const ProfileScreen(),
  ];
  SharedPrefService sharedPrefService=SharedPrefService();
  GraphQLService graphQLService=GraphQLService();
  String token="";

  String? storeImage;
  String? storeSlug;
  int? storeId;
  Map<String, dynamic> data = Get.arguments;
  NearStoreProductData? nearStoreProductModel;
  RelatedRecommendedData? relatedRecommendedProduct;
  bool isNearStoreProduct=false;
  PeopleBuyData? peopleBuyModel;
  int count = 0;
  VariationsData?  variationsProductModel;
  ProductRemoveData? productRemoveModel;
  AddProductData? addProductModel;
  List<NonVariationProductModel> nonVariationCartProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    bottomBarController.pageNewIndex.value=(-1);

    token = sharedPrefService.getToken();
    storeImage=data['storeImage'];
    storeId=data['storeId'];
    storeSlug=data['storeSlug'];
    print("storeSlug=====${storeSlug}");
    getStoreProduct();
  }
  getStoreProduct() async {

    setState(() {
      isNearStoreProduct=true;
    });

    nearStoreProductModel=await   graphQLService.nearStoreProduct(token ??"", storeId!);
    relatedRecommendedProduct=await graphQLService.relatedRecommendedProduct(token??"", storeSlug!);
    print("relatedRecommendedProduct====${relatedRecommendedProduct!.product?.relatedProducts?.length}");
    peopleBuyModel = await graphQLService.peopleBuy(token ?? "", "Grocery");
print("nearStoreProductModel========${nearStoreProductModel!.products!.data!.length}");


    getAllProduct();
    setState(() {
      isNearStoreProduct=false;
    });

  }

  getAllProduct() async {
    await getListFromSharedPreferences();
    nonVariationCartProduct.forEach((element) {
      nearStoreProductModel!.products!.data!
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
    return Obx(() =>
        SafeArea(
          child: Scaffold(
          backgroundColor: AppColor.backGroundColor,
          bottomNavigationBar: AppBottomBar(bottomBar: "0"),
            body: bottomBarController.pageNewIndex.value!=(-1)? pages[bottomBarController.pageNewIndex.value]:isNearStoreProduct?Center(child: CircularProgressIndicator()):Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

            //  SizedBox(height: SizeUtils.verticalBlockSize*1,),

              Image.network("$storeImage", height: SizeUtils.verticalBlockSize * 35,
                  fit: BoxFit.fill),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 3),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: nearStoreProductModel!.products!.data!.length,
                                    
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.60),
                          itemBuilder: (context, index) {
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
                                        color:
                                        Color.fromRGBO(0, 0, 0, 0.08),
                                    

                                        offset: Offset(0, 1),

                                        blurRadius: 1,

                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            GestureDetector(onTap: () {


                                              Get.toNamed(Routes.productDetails, arguments: {
                                                'productId': nearStoreProductModel!.products!.data![index].id,

                                                'productSlug':  nearStoreProductModel!.products!.data![index].slug,
                                              })!.then((value) {


                                                getAllProduct();
                                                setState(() {

                                                });
                                              });

                                            


                                            },
                                              child: ClipRRect(
                                                borderRadius:
                                                const BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(15),
                                                  topRight:
                                                  Radius.circular(15),
                                                ),
                                                child: Image.network(
                                                    "${nearStoreProductModel!.products!.data![index].image!.original}",
                                                    fit: BoxFit.fill,
                                                    height: SizeUtils
                                                        .verticalBlockSize *
                                                        23,
                                                    width: SizeUtils
                                                        .horizontalBlockSize *
                                                        43),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  print(
                                                      "popularProductModel!.popularProducts![index].inWishlist======${nearStoreProductModel!.products!.data![index].id}");
                                                  print("like");

                                                  if (token != "") {
                                                    // popularProductModel!.popularProducts![index].inWishlist =
                                                    // !(popularProductModel!.popularProducts![index].inWishlist ?? false);

                                                    toggleWishListModel =
                                                    await graphQLService.wishListToggle(
                                                        nearStoreProductModel!.products!.data![index].id!,
                                                     token ?? "");
                                                    print(
                                                        "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                                                    inWishListModel =
                                                    await graphQLService.inWishList(
                                                        nearStoreProductModel!.products!.data![index].id!,
                                                       token ?? "");
                                                    print(
                                                        "inWishListModelget========${inWishListModel!.inWishlist}");
                                                    nearStoreProductModel!.products!.data![index].inWishlist =
                                                        toggleWishListModel!.toggleWishlist;
                                                    setState(() {});
                                                  } else {
                                                    Get.toNamed(Routes.logInScreen);
                                                  }

                                                  print(
                                                      "popularProductModel!.popularProducts![index].inWishlist======${nearStoreProductModel!.products!.data![index].id}");
                                                  print(
                                                      "popularProductModel!.popularProducts![index].inWishlist======${nearStoreProductModel!.products!.data![index].inWishlist}");
                                                },
                                                child: Image.asset(
                                                  nearStoreProductModel!.products!.data![index].inWishlist ==
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
                                            Container(width: SizeUtils.horizontalBlockSize*42,
                                              child: CustomText(
                                                name:
                                                "${nearStoreProductModel!.products!.data![index].name}",
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
                                            "Rp ${nearStoreProductModel!.products!.data![index].salePrice}",
                                            color: AppColor.greenColor,
                                            fontSize:
                                            SizeUtils.fSize_13(),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          CustomText(
                                            name:
                                            "/ ${nearStoreProductModel!.products!.data![index].unit}",
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
                                                1,bottom:  SizeUtils
                                            .verticalBlockSize *
                                            1),
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
                                                      "Rp ${nearStoreProductModel!.products!.data![index].price}",
                                                      color: AppColor.greenColor,
                                                      fontSize: SizeUtils.fSize_12(),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    CustomText(
                                                      name:
                                                      "Rp ${nearStoreProductModel!.products!.data![index].maxPrice}",
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
                                            ),   nearStoreProductModel!.products!.data![index].qtn ==
                                                null ||nearStoreProductModel!.products!.data![index].qtn ==
                                                0
                                                ? GestureDetector(
                                              onTap: () async {
                                                print("tap");



                                                if(token != "")
                                                  {
                                                    variationsProductModel =
                                                    await graphQLService
                                                        .variationsProduct(
                                                        token ?? "",
                                                        nearStoreProductModel!.products!.data![index]
                                                            .id!);

                                                    if (variationsProductModel!
                                                        .product!.variations!.isEmpty) {
                                                      count = int.parse(
                                                          "${nearStoreProductModel!.products!.data![index].qtn == null ? 0 : nearStoreProductModel!.products!.data![index].qtn}");

                                                      setState(() {
                                                        nearStoreProductModel!.products!.data![index]
                                                            .qtn = count + 1;
                                                      });
                                                      await nearStoreAddProduct(
                                                        nearStoreProductModel!.products!.data![index].id,
                                                        nearStoreProductModel!.products!.data![index]
                                                            .image!
                                                            .original,

                                                        nearStoreProductModel!.products!.data![index]
                                                            .salePrice
                                                            .toString(),

                                                        nearStoreProductModel!.products!.data![index].qtn,
                                                        nearStoreProductModel!.products!.data![index].name,
                                                        nearStoreProductModel!.products!.data![index].unit,
                                                      );
                                                    }

                                                  }
                                                else
                                                  {

                                                    Get.toNamed(Routes.logInScreen);
                                                  }



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

                                                            if (    nearStoreProductModel!.products!.data![
                                                            index]
                                                                .qtn !=
                                                                null &&
                                                                int.parse(    nearStoreProductModel!.products!.data![
                                                                index]
                                                                    .qtn
                                                                    .toString()) !=
                                                                    0) {
                                                              count = int.parse(    nearStoreProductModel!.products!.data![
                                                              index]
                                                                  .qtn
                                                                  .toString());
                                                              print("count=====$count");
                                                              nearStoreProductModel!.products!.data![
                                                              index]
                                                                  .qtn = count - 1;

                                                              if (nearStoreProductModel!.products!.data![
                                                              index]
                                                                  .qtn ==
                                                                  0) {
                                                                nearStoreProductModel!.products!.data![
                                                                index]
                                                                    .qtn = null;
                                                                print(
                                                                    " popularProduct.qtn====${nearStoreProductModel!.products!.data![index].qtn}");

                                                                productRemoveModel =
                                                                await graphQLService
                                                                    .cartProductRemove(nearStoreProductModel!.products!.data![
                                                                index]
                                                                    .id!);

                                                                print(
                                                                    "addProductModel====${nearStoreProductModel!.products!.data![index].id}");
                                                                if (productRemoveModel!
                                                                    .addtocartProductRemove ==
                                                                    "Success") {

                                                                  await nearStoreDecreaseProduct(
                                                                      nearStoreProductModel!.products!.data![
                                                                      index]
                                                                          .id,
                                                                      nearStoreProductModel!.products!.data![
                                                                      index]
                                                                          .image!
                                                                          .original,
                                                                      nearStoreProductModel!.products!.data![
                                                                      index]
                                                                          .salePrice
                                                                          .toString(),
                                                                      0,
                                                                      nearStoreProductModel!.products!.data![
                                                                      index]
                                                                          .name,
                                                                      nearStoreProductModel!.products!.data![
                                                                      index]
                                                                          .unit);

                                                                  //count = 0;
                                                                }
                                                                saveListInSharedPreferences();
                                                              }
                                                              else
                                                              {

                                                                await nearStoreDecreaseProduct(
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .id,
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .image!
                                                                        .original,
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .salePrice
                                                                        .toString(),
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .qtn,
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .name,
                                                                    nearStoreProductModel!.products!.data![
                                                                    index]
                                                                        .unit);
                                                              }

                                                              print(
                                                                  "qtn=====${nearStoreProductModel!.products!.data![index].qtn}");
                                                              saveListInSharedPreferences();
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: const Icon(
                                                              Icons.remove,
                                                              color: AppColor
                                                                  .backGroundColor),
                                                        ),
                                                        CustomText(
                                                          name: "${nearStoreProductModel!.products!.data![index].qtn}",
                                                          color:
                                                          AppColor.backGroundColor,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize:
                                                          SizeUtils.fSize_14(),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {

                                                            count = int.parse(nearStoreProductModel!.products!.data![index]
                                                                .qtn
                                                                .toString());

                                                            nearStoreProductModel!.products!.data![index]
                                                                .qtn = count + 1;
                                                            setState(() {});
                                                            await   nearStoreIncreaseProduct(
                                                                nearStoreProductModel!.products!.data![
                                                            index]
                                                                .id,
                                                                nearStoreProductModel!.products!.data![
                                                            index]
                                                                .image!
                                                                .original,
                                                                nearStoreProductModel!.products!.data![
                                                            index]
                                                                .salePrice
                                                                .toString(),
                                                                nearStoreProductModel!.products!.data![
                                                            index]
                                                                .qtn,
                                                                nearStoreProductModel!.products!.data![
                                                            index]
                                                                .name,
                                                                nearStoreProductModel!.products!.data![
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
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //       top: SizeUtils.verticalBlockSize * 1),
                                            //   child: Row(
                                            //     children: [
                                            //       // Padding(
                                            //       //   padding: const EdgeInsets.only(left: 3),
                                            //       //   child: Container(
                                            //       //     width: SizeUtils.horizontalBlockSize * 16,
                                            //       //     child: Column(
                                            //       //       crossAxisAlignment:
                                            //       //       CrossAxisAlignment.start,
                                            //       //       children: [
                                            //       //         CustomText(
                                            //       //           name:
                                            //       //           "Rp ${nearStoreProductModel!.products!.data![index].price}",
                                            //       //           color: AppColor.greenColor,
                                            //       //           fontSize: SizeUtils.fSize_12(),
                                            //       //           fontWeight: FontWeight.w600,
                                            //       //         ),
                                            //       //         CustomText(
                                            //       //           name:
                                            //       //           "Rp ${nearStoreProductModel!.products!.data![index].maxPrice}",
                                            //       //           color: AppColor.grayTextColor,
                                            //       //           fontSize: SizeUtils.fSize_11(),
                                            //       //           fontWeight: FontWeight.w500,
                                            //       //         )
                                            //       //       ],
                                            //       //     ),
                                            //       //   ),
                                            //       // ),
                                            //       // const SizedBox(
                                            //       //   width: 5,
                                            //       // ),
                                            //
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
                            );
                          },
                        ),
                        relatedRecommendedProduct==null?   RelatedProductView(relatedRecommendedProduct: relatedRecommendedProduct,token: token):SizedBox(),
                        PeopleBuyView(peopleBuyModel: peopleBuyModel,token: token,)
                        
                      ],
                    ),
                  ),
                ),
              ),
        

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
              //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              //
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //
              //           vertical: SizeUtils.verticalBlockSize * 1),
              //       child: GridView.builder(
              //         padding: EdgeInsets.zero,
              //         physics: const BouncingScrollPhysics(),
              //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 3, mainAxisSpacing: 10,
              //           childAspectRatio: 0.8,
              //           //childAspectRatio: 0.8,
              //           crossAxisSpacing: 20,
              //         ),
              //         shrinkWrap: true,
              //         itemCount: topOfferImage.length,
              //         itemBuilder: (context, index) {
              //           return GestureDetector(
              //             onTap: () {
              //               print("istapok");
              //               Get.to(ProductDetails());
              //               //  Get.offAll(const ProductDetails());
              //
              //               // Get.toNamed(Routes.productDetails);
              //               //   Get.toRe(Routes.productDetails);
              //             },
              //             child: Column(
              //               children: [
              //                 Image.asset(topOfferImage[index]),
              //                 CustomText(
              //                   name: topOfferName[index],
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: SizeUtils.fSize_12(),
              //                 )
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //     SizedBox(height: SizeUtils.verticalBlockSize*1,),
              //
              //     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         CustomText(name: "Recommend products",fontSize: SizeUtils.fSize_22(),fontWeight: FontWeight.w600,color: AppColor.blackColor,),
              //         CustomText(name: "See All",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w500,color: AppColor.orangeColor,),
              //
              //
              //       ],
              //     ),
              //     SizedBox(
              //       //height:280,
              //
              //       height: SizeUtils.verticalBlockSize * 40,
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: 4,
              //         physics: const BouncingScrollPhysics(),
              //         scrollDirection: Axis.horizontal,
              //         // padding: EdgeInsets.symmetric(
              //         //     horizontal: SizeUtils.horizontalBlockSize * 3),
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.all(0.0),
              //             child: Card(
              //               elevation: 0,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(15.0),
              //               ),
              //               child: Container(
              //                 // height: 100,
              //                 //   width: SizeUtils.horizontalBlockSize*40,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(15),
              //                   color: AppColor.backGroundColor,
              //                   boxShadow: const [
              //                     BoxShadow(
              //                       color: Color.fromRGBO(0, 0, 0, 0.08),
              //                       // Shadow color with opacity
              //                       offset: Offset(0, 3),
              //                       // X, Y offset
              //                       blurRadius: 8,
              //                       // Blur radius
              //                       spreadRadius: 2, // Spread radius
              //                     ),
              //                   ],
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Stack(
              //                       alignment: Alignment.topRight,
              //                       children: [
              //                         Image.asset("asset/images/coca_cola_icon.png",
              //                             fit: BoxFit.fill,
              //                             height: SizeUtils.verticalBlockSize * 23,
              //                             width: SizeUtils.horizontalBlockSize * 43),
              //                         Padding(
              //                           padding: const EdgeInsets.all(4.0),
              //                           child: Image.asset(
              //                             "asset/images/favorite.png",
              //                             //fit: BoxFit.fill,
              //                             height: SizeUtils.verticalBlockSize * 3,
              //                             //    width: SizeUtils.horizontalBlockSize*40
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                     Padding(
              //                       padding: EdgeInsets.only(
              //                           top: SizeUtils.verticalBlockSize * 1,
              //                           bottom: SizeUtils.verticalBlockSize * 3),
              //                       child: Row(
              //                         children: [
              //                           SizedBox(
              //                             width: SizeUtils.horizontalBlockSize * 2,
              //                           ),
              //                           CustomText(
              //                             name: "Fresh Carrot",
              //                             fontSize: SizeUtils.fSize_14(),
              //                             color: AppColor.grayColor,
              //                             fontWeight: FontWeight.w600,
              //                             textAlign: TextAlign.start,
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Row(
              //                       children: [
              //                         SizedBox(
              //                           width: SizeUtils.horizontalBlockSize * 1,
              //                         ),
              //                         //const SizedBox(width: 5,),
              //                         CustomText(
              //                           name: "Rp 12,000",
              //                           color: AppColor.greenColor,
              //                           fontSize: SizeUtils.fSize_13(),
              //                           fontWeight: FontWeight.w700,
              //                         ),
              //                         CustomText(
              //                           name: "/ kg",
              //                           color: AppColor.grayColor,
              //                           fontSize: SizeUtils.fSize_10(),
              //                           fontWeight: FontWeight.w400,
              //                         ),
              //                       ],
              //                     ),
              //                     Padding(
              //                       padding: EdgeInsets.only(
              //                           top: SizeUtils.verticalBlockSize * 1),
              //                       child: Row(
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.only(left: 3),
              //                             child: Column(
              //                               crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                               children: [
              //                                 CustomText(
              //                                   name: "Rp 18,000",
              //                                   color: AppColor.greenColor,
              //                                   fontSize: SizeUtils.fSize_12(),
              //                                   fontWeight: FontWeight.w600,
              //                                 ),
              //                                 CustomText(
              //                                   name: "Rp 18,000",
              //                                   color: AppColor.grayTextColor,
              //                                   fontSize: SizeUtils.fSize_11(),
              //                                   fontWeight: FontWeight.w500,
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             width: 5,
              //                           ),
              //                           index == 1
              //                               ? Padding(
              //                             padding: const EdgeInsets.symmetric(
              //                                 horizontal: 4),
              //                             child: Container(
              //                               height:
              //                               SizeUtils.verticalBlockSize *
              //                                   4.3,
              //                               width:
              //                               SizeUtils.horizontalBlockSize *
              //                                   20,
              //                               decoration: BoxDecoration(
              //                                 color: AppColor.greenColor,
              //                                 borderRadius:
              //                                 BorderRadius.circular(6),
              //                               ),
              //                               child: Padding(
              //                                 padding:
              //                                 const EdgeInsets.symmetric(
              //                                     horizontal: 4),
              //                                 child: Row(
              //                                     mainAxisAlignment:
              //                                     MainAxisAlignment
              //                                         .spaceBetween,
              //                                     children: [
              //                                       // SizedBox(width: 4,),
              //                                       const Icon(Icons.remove,
              //                                           color: AppColor
              //                                               .backGroundColor),
              //                                       CustomText(
              //                                         name: "1",
              //                                         color: AppColor
              //                                             .backGroundColor,
              //                                         fontWeight:
              //                                         FontWeight.w500,
              //                                         fontSize:
              //                                         SizeUtils.fSize_14(),
              //                                       ),
              //                                       const Icon(Icons.add,
              //                                           color: AppColor
              //                                               .backGroundColor),
              //                                     ]),
              //                               ),
              //                             ),
              //                           )
              //                               : Padding(
              //                             padding: const EdgeInsets.symmetric(
              //                                 horizontal: 4),
              //                             child: Container(
              //                               height:
              //                               SizeUtils.verticalBlockSize *
              //                                   4.3,
              //                               width:
              //                               SizeUtils.horizontalBlockSize *
              //                                   20,
              //                               decoration: BoxDecoration(
              //                                 color: AppColor.greenColor,
              //                                 borderRadius:
              //                                 BorderRadius.circular(6),
              //                               ),
              //                               child: Row(children: [
              //                                 const SizedBox(
              //                                   width: 4,
              //                                 ),
              //                                 const Icon(Icons.add,
              //                                     color:
              //                                     AppColor.backGroundColor),
              //                                 CustomText(
              //                                   name: "Add",
              //                                   color: AppColor.backGroundColor,
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: SizeUtils.fSize_14(),
              //                                 )
              //                               ]),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //
              //
              //
              //
              //   ],),
              // ),




            ],)
                ),
        ),
    );
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

  nearStoreAddProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    addProductModel = await graphQLService.addToCartProduct(productId!);

    await nearStoreProduct(productId, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }


  Future<void> nearStoreProduct(
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

  nearStoreDecreaseProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    await nearStoreProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
  }

  nearStoreIncreaseProduct(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {


    await nearStoreProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }
}
