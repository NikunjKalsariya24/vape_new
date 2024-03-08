import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/category_details_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/product_details_view_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variation_product_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());
  GraphQLService graphQLService = GraphQLService();
  SharedPrefService sharedPrefService = SharedPrefService();
  Map<String, dynamic> data = Get.arguments;
  String? slug;

  List<NonVariationProductModel> nonVariationCartProduct = [];
  List<VariationProductModel> variationCartProduct = [];
  String? imageGet;
  CategoryDetailsData? categoryDetailsModel;
  bool isCategory = false;
  String token="";
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  int count = 0;
  VariationsData? variationsProductModel;
  ProductRemoveData? productRemoveModel;
  AddProductData? addProductModel;

  ProductDetailsViewData? productDetailsViewModel;

  String? longText;
  bool isExpanded = false;

  int selectedIndex = 0;

  int cnt=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    slug = data['slug'];
    print("slug====${slug}");
    imageGet = data['image'];
    token = sharedPrefService.getToken();
    getCategoryDetails();

    bottomBarController.pageNewIndex.value = (-1);
  }

  getCategoryDetails() async {
    setState(() {
      isCategory = true;
    });
    print("token=====${token}");
    categoryDetailsModel =
        await graphQLService.categoryDetails(token, "$slug");

    getAllProduct();
    setState(() {
      isCategory = false;
    });
  }

  getAllProduct() async {
    await getListFromSharedPreferences();
    nonVariationCartProduct.forEach((element) {
      categoryDetailsModel!.categories!.data![0].products!
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
    print("token=====${token}");
    return Obx(
      () =>
          //child:
          Scaffold(
        backgroundColor: AppColor.backGroundColor,
        bottomNavigationBar: AppBottomBar(bottomBar: "0"),
        body: bottomBarController.pageNewIndex.value != (-1)
            ? bottomBarController.pages[bottomBarController.pageNewIndex.value]
            : isCategory
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 6,
                    ),
                    Image.network(imageGet!,
                        height: SizeUtils.verticalBlockSize * 35,
                        width: double.infinity,
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
                                itemCount: categoryDetailsModel!
                                    .categories!.data![0].products!.length,
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

                                              // Shadow color with opacity
                                              offset: Offset(0, 1),
                                              // X, Y offset
                                              blurRadius: 1,
                                              // Blur radius
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                              Routes
                                                                  .productDetails,
                                                              arguments: {
                                                            'productId':
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .id,
                                                            'productSlug':
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .slug,
                                                          })!
                                                          .then((value) {
                                                        getAllProduct();
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                      child: Image.network(
                                                          "${categoryDetailsModel!.categories!.data![0].products![index].image!.original}",
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        print(
                                                            "popularProductModel!.popularProducts![index].inWishlist======${categoryDetailsModel!.categories!.data![0].products![index].id}");
                                                        print("like");

                                                        if (token  != "") {
                                                          // popularProductModel!.popularProducts![index].inWishlist =
                                                          // !(popularProductModel!.popularProducts![index].inWishlist ?? false);

                                                          toggleWishListModel =
                                                              await graphQLService.wishListToggle(
                                                                  categoryDetailsModel!
                                                                      .categories!
                                                                      .data![0]
                                                                      .products![
                                                                          index]
                                                                      .id!,
                                                                  token ?? "");
                                                          print(
                                                              "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                                                          inWishListModel =
                                                              await graphQLService.inWishList(
                                                                  categoryDetailsModel!
                                                                      .categories!
                                                                      .data![0]
                                                                      .products![
                                                                          index]
                                                                      .id!,
                                                                  token ?? "");
                                                          print(
                                                              "inWishListModelget========${inWishListModel!.inWishlist}");
                                                          categoryDetailsModel!
                                                                  .categories!
                                                                  .data![0]
                                                                  .products![index]
                                                                  .inWishlist =
                                                              toggleWishListModel!
                                                                  .toggleWishlist;
                                                          setState(() {});
                                                        } else {
                                                          Get.toNamed(Routes
                                                              .logInScreen);
                                                        }

                                                        print(
                                                            "popularProductModel!.popularProducts![index].inWishlist======${categoryDetailsModel!.categories!.data![0].products![index].id}");
                                                        print(
                                                            "popularProductModel!.popularProducts![index].inWishlist======${categoryDetailsModel!.categories!.data![0].products![index].inWishlist}");
                                                      },
                                                      child: Image.asset(
                                                        categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .inWishlist ==
                                                                true
                                                            ? "asset/images/like_icon.png"
                                                            : "asset/images/favorite.png",
                                                        //fit: BoxFit.fill,
                                                        height: SizeUtils
                                                                .verticalBlockSize *
                                                            3,
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
                                                  Container(width: SizeUtils.horizontalBlockSize*40,
                                                    child: CustomText(
                                                      name:
                                                          "${categoryDetailsModel!.categories!.data![0].products![index].name}",
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
                                                      "Rp ${categoryDetailsModel!.categories!.data![0].products![index].salePrice}",
                                                  color: AppColor.greenColor,
                                                  fontSize:
                                                      SizeUtils.fSize_13(),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                CustomText(
                                                  name:
                                                      "/ ${categoryDetailsModel!.categories!.data![0].products![index].unit}",
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
                                                    1,
                                                bottom: SizeUtils
                                                        .verticalBlockSize *
                                                    1,
                                              ),
                                              child: Row(
                                                children: [
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           left: 3),
                                                  //   child: Container(
                                                  //     width: SizeUtils
                                                  //             .horizontalBlockSize *
                                                  //         16,
                                                  //     child: Column(
                                                  //       crossAxisAlignment:
                                                  //           CrossAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         CustomText(
                                                  //           name:
                                                  //               "Rp ${categoryDetailsModel!.categories!.data![0].products![index].maxPrice}",
                                                  //           color: AppColor
                                                  //               .greenColor,
                                                  //           fontSize: SizeUtils
                                                  //               .fSize_12(),
                                                  //           fontWeight:
                                                  //               FontWeight.w600,
                                                  //         ),
                                                  //         CustomText(
                                                  //           name:
                                                  //               "Rp ${categoryDetailsModel!.categories!.data![0].products![index].price}",
                                                  //           color: AppColor
                                                  //               .grayTextColor,
                                                  //           fontSize: SizeUtils
                                                  //               .fSize_11(),
                                                  //           fontWeight:
                                                  //               FontWeight.w500,
                                                  //         ),
                                                  //         const SizedBox(
                                                  //           height: 5,
                                                  //         )
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // const SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                  // categoryDetailsModel!
                                                  //             .categories!
                                                  //             .data![0]
                                                  //             .products![index]
                                                  //             .unit !=
                                                  //         0
                                                  //     ? Column(
                                                  //         children: [
                                                  //           Padding(
                                                  //             padding:
                                                  //                 const EdgeInsets
                                                  //                     .symmetric(
                                                  //                     horizontal:
                                                  //                         4),
                                                  //             child: Container(
                                                  //               height: SizeUtils
                                                  //                       .verticalBlockSize *
                                                  //                   4.3,
                                                  //               width: SizeUtils
                                                  //                       .horizontalBlockSize *
                                                  //                   24,
                                                  //               decoration:
                                                  //                   BoxDecoration(
                                                  //                 color: AppColor
                                                  //                     .greenColor,
                                                  //                 borderRadius:
                                                  //                     BorderRadius
                                                  //                         .circular(
                                                  //                             6),
                                                  //               ),
                                                  //               child: Padding(
                                                  //                 padding: const EdgeInsets
                                                  //                     .symmetric(
                                                  //                     horizontal:
                                                  //                         0),
                                                  //                 child: Row(
                                                  //                     mainAxisAlignment:
                                                  //                         MainAxisAlignment
                                                  //                             .spaceBetween,
                                                  //                     children: [
                                                  //                       // SizedBox(width: 4,),
                                                  //                       const Icon(
                                                  //                           Icons
                                                  //                               .remove,
                                                  //                           color:
                                                  //                               AppColor.backGroundColor),
                                                  //                       CustomText(
                                                  //                         name:
                                                  //                             "${categoryDetailsModel!.categories!.data![0].products![index].quantity}",
                                                  //                         color:
                                                  //                             AppColor.backGroundColor,
                                                  //                         fontWeight:
                                                  //                             FontWeight.w500,
                                                  //                         fontSize:
                                                  //                             SizeUtils.fSize_14(),
                                                  //                       ),
                                                  //                       const Icon(
                                                  //                           Icons
                                                  //                               .add,
                                                  //                           color:
                                                  //                               AppColor.backGroundColor),
                                                  //                     ]),
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           const SizedBox(
                                                  //             height: 5,
                                                  //           )
                                                  //         ],
                                                  //       )
                                                  //     : Column(
                                                  //         children: [
                                                  //           Padding(
                                                  //             padding:
                                                  //                 const EdgeInsets
                                                  //                     .symmetric(
                                                  //                     horizontal:
                                                  //                         4),
                                                  //             child:
                                                  //                 GestureDetector(
                                                  //               onTap: () {
                                                  //                 //getBottomSheet(context);
                                                  //               },
                                                  //               child:
                                                  //                   Container(
                                                  //                 height: SizeUtils
                                                  //                         .verticalBlockSize *
                                                  //                     4.3,
                                                  //                 width: SizeUtils
                                                  //                         .horizontalBlockSize *
                                                  //                     20,
                                                  //                 decoration:
                                                  //                     BoxDecoration(
                                                  //                   color: AppColor
                                                  //                       .greenColor,
                                                  //                   borderRadius:
                                                  //                       BorderRadius
                                                  //                           .circular(6),
                                                  //                 ),
                                                  //                 child: Row(
                                                  //                     children: [
                                                  //                       const SizedBox(
                                                  //                         width:
                                                  //                             4,
                                                  //                       ),
                                                  //                       const Icon(
                                                  //                           Icons
                                                  //                               .add,
                                                  //                           color:
                                                  //                               AppColor.backGroundColor),
                                                  //                       CustomText(
                                                  //                         name:
                                                  //                             "Add",
                                                  //                         color:
                                                  //                             AppColor.backGroundColor,
                                                  //                         fontWeight:
                                                  //                             FontWeight.w500,
                                                  //                         fontSize:
                                                  //                             SizeUtils.fSize_14(),
                                                  //                       )
                                                  //                     ]),
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           const SizedBox(
                                                  //             height: 5,
                                                  //           )
                                                  //         ],
                                                  //       )
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                "Rp ${categoryDetailsModel!.categories!.data![0].products![index].price}",
                                                            color: AppColor
                                                                .greenColor,
                                                            fontSize: SizeUtils
                                                                .fSize_12(),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          CustomText(
                                                            name:
                                                                "Rp ${categoryDetailsModel!.categories!.data![0].products![index].maxPrice}",
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
                                                  categoryDetailsModel!
                                                              .categories!
                                                              .data![0]
                                                              .products![index]
                                                              .qtn ==
                                                          null ||   categoryDetailsModel!
                                                      .categories!
                                                      .data![0]
                                                      .products![index]
                                                      .qtn ==
                                                      0
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            print("tap");

                                                            variationsProductModel =
                                                                await graphQLService.variationsProduct(
                                                                    token ?? "",
                                                                    categoryDetailsModel!
                                                                        .categories!
                                                                        .data![
                                                                            0]
                                                                        .products![
                                                                            index]
                                                                        .id!);

                                                            if (variationsProductModel!
                                                                .product!
                                                                .variations!
                                                                .isEmpty) {
                                                              count = int.parse(
                                                                  "${categoryDetailsModel!.categories!.data![0].products![index].qtn == null ? 0 : categoryDetailsModel!.categories!.data![0].products![index].qtn}");

                                                              setState(() {
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .qtn = count + 1;
                                                              });
                                                              await categoryAddProduct(
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .id,
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .image!
                                                                    .original,
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .salePrice
                                                                    .toString(),
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .qtn,
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .name,
                                                                categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![
                                                                        index]
                                                                    .unit,
                                                              );
                                                            }
                                                            else
                                                              {

                                                                productDetailsViewModel=await graphQLService.productDetailsView(token??"", "${  categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![index].id}", "${  categoryDetailsModel!
                                                                    .categories!
                                                                    .data![0]
                                                                    .products![index].slug }", "en");
                                                                getBottomSheet(productDetailsViewModel);
                                                                print("variation product");
                                                              }
                                                          },
                                                          child: Padding(
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
                                                                      width: 4,
                                                                    ),
                                                                    const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: AppColor
                                                                            .backGroundColor),
                                                                    CustomText(
                                                                      name:
                                                                          "Add",
                                                                      color: AppColor
                                                                          .backGroundColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          SizeUtils
                                                                              .fSize_14(),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
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
                                                                22,
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
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        print(
                                                                            "tap");
                                                                        if (categoryDetailsModel!.categories!.data![0].products![index].qtn !=
                                                                                null &&
                                                                            int.parse(categoryDetailsModel!.categories!.data![0].products![index].qtn.toString()) !=
                                                                                0) {
                                                                          count = int.parse(categoryDetailsModel!
                                                                              .categories!
                                                                              .data![0]
                                                                              .products![index]
                                                                              .qtn
                                                                              .toString());
                                                                          print(
                                                                              "count=====$count");
                                                                          categoryDetailsModel!
                                                                              .categories!
                                                                              .data![0]
                                                                              .products![index]
                                                                              .qtn = count - 1;

                                                                          if (categoryDetailsModel!.categories!.data![0].products![index].qtn ==
                                                                              0) {
                                                                            categoryDetailsModel!.categories!.data![0].products![index].qtn =
                                                                                null;
                                                                            print(" popularProduct.qtn====${categoryDetailsModel!.categories!.data![0].products![index].qtn}");


                                                                            productRemoveModel =
                                                                                await graphQLService.cartProductRemove(categoryDetailsModel!.categories!.data![0].products![index].id!);

                                                                            print("addProductModel====${categoryDetailsModel!.categories!.data![0].products![index].id}");
                                                                            if (productRemoveModel!.addtocartProductRemove ==
                                                                                "Success") {
                                                                              await categoryDecreaseProduct(
                                                                                  categoryDetailsModel!.categories!.data![0].products![index].id,
                                                                                  categoryDetailsModel!.categories!.data![0].products![index].image!.original,
                                                                                  categoryDetailsModel!.categories!.data![0].products![index].salePrice.toString(),
                                                                                  0,
                                                                                  categoryDetailsModel!.categories!.data![0].products![index].name,
                                                                                  categoryDetailsModel!.categories!.data![0].products![index].unit);

                                                                              //count = 0;
                                                                            }
                                                                            saveListInSharedPreferences();
                                                                          } else {

                                                                            await categoryDecreaseProduct(
                                                                                categoryDetailsModel!.categories!.data![0].products![index].id,
                                                                                categoryDetailsModel!.categories!.data![0].products![index].image!.original,
                                                                                categoryDetailsModel!.categories!.data![0].products![index].salePrice.toString(),
                                                                                categoryDetailsModel!.categories!.data![0].products![index].qtn,
                                                                                categoryDetailsModel!.categories!.data![0].products![index].name,
                                                                                categoryDetailsModel!.categories!.data![0].products![index].unit);
                                                                          }

                                                                          print(
                                                                              "qtn=====${categoryDetailsModel!.categories!.data![0].products![index].qtn}");
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
                                                                          "${categoryDetailsModel!.categories!.data![0].products![index].qtn}",
                                                                      color: AppColor
                                                                          .backGroundColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          SizeUtils
                                                                              .fSize_14(),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        count = int.parse(categoryDetailsModel!
                                                                            .categories!
                                                                            .data![0]
                                                                            .products![index]
                                                                            .qtn
                                                                            .toString());

                                                                        categoryDetailsModel!
                                                                            .categories!
                                                                            .data![0]
                                                                            .products![index]
                                                                            .qtn = count + 1;
                                                                        setState(
                                                                            () {});
                                                                        await categoryIncreaseProduct(
                                                                            categoryDetailsModel!.categories!.data![0].products![index].id,
                                                                            categoryDetailsModel!.categories!.data![0].products![index].image!.original,
                                                                            categoryDetailsModel!.categories!.data![0].products![index].salePrice.toString(),
                                                                            categoryDetailsModel!.categories!.data![0].products![index].qtn,
                                                                            categoryDetailsModel!.categories!.data![0].products![index].name,
                                                                            categoryDetailsModel!.categories!.data![0].products![index].unit);
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .add,
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
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
      ),
    );
  }

  getListFromSharedPreferences() async {
    final saveListJson = sharedPrefService.nonVariationProductGet();
    print("saveListJson====${saveListJson}");
    if (saveListJson != "") {
      final List<dynamic> decodedList = json.decode(saveListJson);

      sharedPrefService.nonVariationRemove();

      nonVariationCartProduct.clear();
      nonVariationCartProduct = decodedList
          .map((item) => NonVariationProductModel.fromJson(item))
          .toList();
    } else {
      nonVariationCartProduct = [];
    }
  }

  categoryAddProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storeCategoryProduct(productId, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

  Future<void> storeCategoryProduct(
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

  categoryDecreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeCategoryProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);
  }

  categoryIncreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeCategoryProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }

  Future<void> getBottomSheet(ProductDetailsViewData? productDetailsViewModel)  async {
    if(productDetailsViewModel != null)
    {
      longText=productDetailsViewModel!.product?.description??"";
      print("longText====${longText}");
    await   getFromSharedPreferencesVariation();

      variationCartProduct.forEach((element) {

        productDetailsViewModel!.product!.attributeslist![0].data!.forEach((productDetailsViewElement) {


          if(element.productVariationId==productDetailsViewElement.avId)
            {

              print("in to if===${selectedIndex}");
              print("element.productQuantity===${element.productQuantity}");

              productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity =element.productQuantity;
              setState(() {

              });


            }


        });
     
      });
      // getAllProduct();

    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColor.backGroundColor, builder: (BuildContext context) {

          return StatefulBuilder(builder: (context, setState) {

            return Container(height: SizeUtils.verticalBlockSize*60,width: double.infinity,     decoration: BoxDecoration(
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
            ),child:Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 3),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 3,
                    ),

                    CustomText(
                        name: "${productDetailsViewModel!.product!.name}",
                        fontSize: SizeUtils.fSize_24(),
                        fontWeight: FontWeight.w600),
                    longText!.length >110?
                    Text(
                      isExpanded
                          ? longText!
                          : longText!.substring(0, 110) + '...',
                      //textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: AppColor.bottomsSheetTexColor,
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w400),
                    ): Text( longText!,

                      style: GoogleFonts.poppins(
                          color: AppColor.bottomsSheetTexColor,
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w400),
                    ),


                    longText!.length >110?    Text(
                      isExpanded
                          ? longText!
                          : longText!.substring(0, 110) + '...',

                      style: GoogleFonts.poppins(
                          color: AppColor.bottomsSheetTexColor,
                          fontSize: SizeUtils.fSize_16(),
                          fontWeight: FontWeight.w400),
                    ):const SizedBox(),

                    longText!.length >110?        GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Read less' : 'Read more',
                        style: GoogleFonts.poppins(
                            color: AppColor.blackTextColor,
                            fontSize: SizeUtils.fSize_16(),
                            fontWeight: FontWeight.w700),
                      ),
                    ):const SizedBox(),

                    SizedBox(height: SizeUtils.verticalBlockSize*1,),
                    productDetailsViewModel!.product!.variations!.isEmpty?const SizedBox():

                    ListView.builder(itemCount: productDetailsViewModel!.product!.attributeslist!.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {

                      return Column(crossAxisAlignment:CrossAxisAlignment.start,children: [


                        CustomText(name: "${productDetailsViewModel!.product!.attributeslist![index].key} :",fontSize: SizeUtils.fSize_16(),color: AppColor.blackColor,fontWeight: FontWeight.w600),
                        SizedBox(height: SizeUtils.verticalBlockSize*1),


                        GridView.builder(shrinkWrap: true,itemCount:productDetailsViewModel!.product!.attributeslist![index].data!.length,physics: NeverScrollableScrollPhysics() ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: SizeUtils.verticalBlockSize*6), itemBuilder: (context, newIndex) {
                          return GestureDetector(onTap: () {

                            selectedIndex=newIndex;
                            productDetailsViewModel!.product!.qtn=0;
                            setState(() {

                            });
                          },
                            child: Container( decoration: BoxDecoration(color:
                            selectedIndex==newIndex?AppColor.grayTextColor:AppColor.backGroundColor,
                                borderRadius: BorderRadius.circular(6),border: Border.all(color: AppColor.blackColor)
                            ),child: Center(
                              child: CustomText(
                                  name: "${productDetailsViewModel!.product!.attributeslist![index].data![newIndex].avValue}",fontSize: SizeUtils.fSize_16(),color: AppColor.blackColor
                              ),
                            ),),
                          );

                        },),

                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 3,
                        ),
                        Row(
                          children: [
                            CustomText(
                              name: "\$ ${productDetailsViewModel!.product!.salePrice}",
                              color: AppColor.orangeColor,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeUtils.fSize_20(),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 6,
                            ),
                            CustomText(
                              name: "\$ ${productDetailsViewModel!.product!.maxPrice}",
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


                      ],);
                    },),
                    Row(
                      children: [
                        productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity==null ?  GestureDetector(onTap: () async {


                          print("productDetailsViewModel!.product!.qtn===${productDetailsViewModel!.product!.qtn}");


                          cnt = int.parse(productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity ?? "0");
                          productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity = (cnt + 1).toString();

                          await storeVariationAddProduct(productDetailsViewModel!.product!.id!, productDetailsViewModel!.product!.image!.original, productDetailsViewModel!.product!.salePrice==null?"0": productDetailsViewModel!.product!.salePrice,
                              productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity , productDetailsViewModel!.product!.name ,
                              productDetailsViewModel!.product!.unit, productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].avId,productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].avValue);

                           setState(() {});
                        },
                          child: Container(
                            height: SizeUtils.verticalBlockSize * 6,
                            width: SizeUtils.horizontalBlockSize * 35,
                            decoration: BoxDecoration(
                                color: AppColor.greenColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row( mainAxisAlignment: MainAxisAlignment.center,children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: SizeUtils.horizontalBlockSize * 3),
                                child: const Icon(Icons.add,
                                    color: AppColor.backGroundColor),
                              ),
                              CustomText(
                                name: "Add",
                                fontSize: SizeUtils.fSize_18(),
                                fontWeight: FontWeight.w700,
                                color: AppColor.backGroundColor,
                              )
                            ],),
                          ),
                        ) : Container(
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
                                    onTap: () async {
                                      if (token != "") {
                                        cnt = int.parse(
                                            productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity == null
                                                ? "0"
                                                : productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity);

                                        productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity =
                                            (cnt - 1).toString();
                                  //      addProductModel = await graphQLService.addToCartProduct(   productDetailsViewModel!.product!.id!);
                                        await storeVariationAddProduct(productDetailsViewModel!.product!.id!, productDetailsViewModel!.product!.image!.original, productDetailsViewModel!.product!.salePrice,
                                            productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity , productDetailsViewModel!.product!.name ,
                                            productDetailsViewModel!.product!.unit, productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].avId,productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].avValue);


                                        setState(() {

                                        });

                                      }

                                      else {
                                        Get.toNamed(Routes.logInScreen);
                                      }
                                    },
                                    child: const Icon(Icons.remove,
                                        color: AppColor.backGroundColor),
                                  ),
                                ),
                                CustomText(
                                  name:  productDetailsViewModel!.product!.attributeslist![0].data![selectedIndex].attributeQuantity.toString(),
                                  //productDetailsViewModel!.product!.qtn.toString(),
                                  color: AppColor.backGroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeUtils.fSize_14(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeUtils.horizontalBlockSize * 3),
                                  child: GestureDetector(
                                    onTap: () async {
                                      print("tapyp");

                                      cnt=int.parse(productDetailsViewModel!.product!.qtn==null?"0":productDetailsViewModel!.product!.qtn);

                                      productDetailsViewModel!.product!.qtn=(cnt+1).toString();
                                      setState(() {

                                      });
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
                                  horizontal: SizeUtils.horizontalBlockSize *
                                      4),
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
                    ),
                  ],
                ),
              ),
            ) ,);
          },

          );







    }
    );
  }

  Future<void>   storeVariationAddProduct(String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit, String? productVariationId,String? productVariation) async {

    await storeVariationProduct(productId, productImage, productPrice,
        productQuantity, productName, productUnit,productVariationId,productVariation);



   await saveListInSharedPreferencesVariation();
    // setState(() {
    //
    // });

  }

  storeVariationProduct(String? productId, String? productImage, String productPrice, productQuantity, String? productName, String? productUnit, String? productVariationId,String? productVariation) async {




    await getFromSharedPreferencesVariation();


    List<VariationProductModel> updatedVariationItems = [];

    if (productId != null) {
      if (variationCartProduct.isEmpty) {

        variationCartProduct.add(VariationProductModel(productId: productId,productImage:productImage ,productPrice: productPrice,productQuantity: productQuantity,productUnit:productUnit ,productTitle:productName ,productVariationId: productVariationId,productVariation:productVariation ));


      } else {
        bool foundMatchingItem = false;
        print("foundMatchingItem1");
        for (VariationProductModel element in variationCartProduct) {
          print("foundMatchingItem10");
          if (element.productVariationId==productVariationId) {

            element.productQuantity = productQuantity;



          // radioButtonAttributeid ==productVariation
          //     selectedRadioButtonAttributeId &&
          //     element.checkBoxOneAttributeid == getListoneAttributeId &&
          //     element.checkBoxTwoAttributeid == getListtwoAttributeId) {
          //   print("foundMatchingItem100");
          //   element.customizationSubmenuQuantity = selectedRadioButtonQuantity;
          //   element.customizationSubmenuTotalPrice = submenuItemsTotal;
          //   print(
          //       "foundMatchingItem1000=====${element.customizationSubmenuQuantity}");

            foundMatchingItem = true;
            break;
          }
        }

        if (!foundMatchingItem) {
          print("foundMatchingItem200");
          variationCartProduct.add(VariationProductModel(productId: productId,productImage:productImage ,productPrice: productPrice,productQuantity: productQuantity,productUnit:productUnit ,productVariationId: productVariationId,productTitle:productName ,productVariation:productVariation ));

              //
              // CustomizationSubmenuPrafrance(
              // submenuId: selectedSubmenuId,
              // submenuType: selectedSubmenuType,
              // submenuTitle: selectedSubmenuTitle,
              // radioButtonAttributeid: selectedRadioButtonAttributeId,
              // radioButtonAttributeName: selectedRadioButtonTitle,
              // checkBoxOneAttributeid: getListoneAttributeId,
              // checkBoxOneAttributeName: getListoneTitle,
              // checkBoxTwoAttributeid: getListtwoAttributeId,
              // checkBoxTwoAttributeName: getListtwoTitle,
              // customizationSubmenuPrice: totalGetPriceAttribute,
              // customizationSubmenuQuantity: selectedRadioButtonQuantity,
              // customizationSubmenuTotalPrice: submenuItemsTotal));
          //storeCustomisationItems = updatedCustomisationItems;
        }
      }
      print("foundMatchingItem20000");
      // Assign the updated list to storeCustomisationItems
    }

    print("Added to storedataCustomisation: ${variationCartProduct.length}");
    if (variationCartProduct.isNotEmpty) {
      print(
          "Added to storedataCustomisation: ${variationCartProduct[0].productQuantity}");
    }


  }

  getFromSharedPreferencesVariation() {
    print("storedataCustomisation on screeen");


    final savedListJson = sharedPrefService.variationProductGet();

    print("savedListJsonview=======$savedListJson");

    if (savedListJson != "") {
      final List<dynamic> decodedList = json.decode(savedListJson);
      // sharedPrefService.variationRemove();
      // variationCartProduct.clear();
      variationCartProduct = decodedList
          .map((itemData) => VariationProductModel
          .fromJson(itemData))
          .toList();

      print("getstoredataCustomisationList========$variationCartProduct");
      print(
          "getstoredataCustomisationList========${variationCartProduct!.length}");

      // for (int i = 0; i < variationCartProduct!.length; i++) {
      //   print(
      //       "storedataCustomisationIdget=====${variationCartProduct![i].productId}");
      //   print(
      //       "storedataCustomisationIdget=====${variationCartProduct![i].productQuantity}");
      // }

    } else {

      return;
    }
  }

  saveListInSharedPreferencesVariation() {
    print("get1");
   // final prefs = await SharedPreferences.getInstance();
    // storedataCustomisation!.clear();
    print("get10");
    final saveListJson = json
        .encode(variationCartProduct!.map((item) => item.toJson()).toList());
    print("get100");
    print("saveListJsonCustomisation====$saveListJson");
    sharedPrefService.variationProduct(saveListJson);

  //  prefs.setString('storeCustomisation', saveListJson);
    print("saveokokokokCustomisation");
    print("get1000");
    String? custmizeppppp =    sharedPrefService.variationProductGet();
    print("custmizeppppp===========$custmizeppppp");
  }
}
