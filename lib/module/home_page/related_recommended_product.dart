import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/related_recommended_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class RelatedProductView extends StatefulWidget {
  RelatedRecommendedData? relatedRecommendedProduct;
  String? token;
   RelatedProductView({required this.relatedRecommendedProduct,required this.token,super.key});

  @override
  State<RelatedProductView> createState() => _RelatedProductViewState();
}

class _RelatedProductViewState extends State<RelatedProductView> {
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  VariationsData?  variationsProductModel;
  GraphQLService graphQLService=GraphQLService();
  AddProductData? addProductModel;
  int count = 0;
  SharedPrefService sharedPrefService =SharedPrefService();

  ProductRemoveData? productRemoveModel;


  String token="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }
  List<NonVariationProductModel> nonVariationCartProduct = [];
  getAllProduct() async {

    token = sharedPrefService.getToken();
    await getListFromSharedPreferences();



    nonVariationCartProduct.forEach((element) {
      widget.relatedRecommendedProduct?.product?.relatedProducts
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
    print("widget.relatedRecommendedProduct======${widget.relatedRecommendedProduct!.product!.relatedProducts!.length}");
    return Column(children: [
      widget.relatedRecommendedProduct!.product!.relatedProducts!.isEmpty?SizedBox(): SizedBox(height: SizeUtils.verticalBlockSize*3,),
// SizedBox(height: 10,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Container(
//                 height:
//                 isTap &&  isExpandedReview?SizeUtils.verticalBlockSize * 94:
//
//                  isTap ? SizeUtils.verticalBlockSize * 80 : SizeUtils
//                      .verticalBlockSize * 8,
//                 decoration: const BoxDecoration(
//                   color: AppColor.backGroundColor,
//                   //   border:Border.all(color: AppColor.blackDarkColor,width: 1) ,
//                   borderRadius: BorderRadius.all(Radius.circular(6)),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: Offset(0, 0),
//                       blurRadius: 12,
//                       spreadRadius: 0,
//                       color: Color.fromRGBO(
//                           0, 0, 0, 0.25),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
//                   child: GestureDetector(onTap:() {
//
//                     isTap = !isTap;
//
//                     setState(() {
//
//                     });
//                   },
//                     child: Column(
//                       //crossAxisAlignment: CrossAxisAlignment.center,
//                      // mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                       mainAxisAlignment: isTap
//                           ? MainAxisAlignment.start
//                           : MainAxisAlignment.center,
//                       children: [
//                        // isTap ?   SizedBox(height: SizeUtils.verticalBlockSize*0.7,):SizedBox(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset(
//                               "asset/images/profile.png",
//                               width: SizeUtils.horizontalBlockSize * 12,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Check Product Reviews & Rattting",
//                                   style: GoogleFonts.poppins(
//                                       color: AppColor.blackDarkColor,
//                                       fontSize: SizeUtils.fSize_13(),
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "4.5",
//                                       style: GoogleFonts.poppins(
//                                           color: AppColor.blackColor,
//                                           fontSize: SizeUtils.fSize_11(),
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     const SizedBox(
//                                       width: 1,
//                                     ),
//                                     RatingBar.builder(
//                                       initialRating: 4.5,
//                                       minRating: 0,
//                                       direction: Axis.horizontal,
//                                       allowHalfRating: true,
//                                       itemCount: 5,
//                                       itemSize: 20,
//                                       ignoreGestures: true,
//                                       itemBuilder: (context, _) =>
//                                       const Icon(
//                                         Icons.star,
//                                         color: AppColor.yellowColor,
//                                       ),
//                                       onRatingUpdate: (rating) {
//                                         print(
//                                             rating); // Use the updated rating here
//                                       },
//                                     ),
//
//
//                                     Text(
//                                       "(89 reviews)",
//                                       style: GoogleFonts.poppins(
//                                           color: AppColor.blackReviewColor,
//                                           fontSize: SizeUtils.fSize_10(),
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Image.asset( isTap ?"asset/images/arrow_down.png":
//                             "asset/images/arrorw_next.png",
//                               width: SizeUtils.horizontalBlockSize * 9,
//                               height: SizeUtils.verticalBlockSize*5,
//                             ),
//                           ],
//                         ),
//                         isTap ?   SizedBox(height: SizeUtils.verticalBlockSize*2,):SizedBox(),
//
//
//                         isTap ?   Container(height:  isExpandedReview?SizeUtils.verticalBlockSize * 80:SizeUtils.verticalBlockSize*68,
//                           child: ListView.builder(shrinkWrap: true,itemCount: isExpandedReview?totalReview:3,scrollDirection: Axis.vertical,
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4),
//                               child: Column(
//                                 children: [
//                                   Container(decoration: BoxDecoration(
//                                       color: AppColor.containerBackGroundColor,
//                                       borderRadius: BorderRadius.circular(6)),
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                                         child: Column(children: [
//
//                                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//
//                                               Row(
//                                                 children: [
//                                                   Image.asset("asset/images/list_profile.png",
//                                                     width: SizeUtils.horizontalBlockSize * 10,
//                                                     height: SizeUtils.verticalBlockSize * 5,),
//                                                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
//                                                   Column(children: [
//                                                     Text(
//                                                       "Haylie Aminoff",
//                                                       style: GoogleFonts.poppins(
//                                                           color: AppColor.blackColor,
//                                                           fontSize: SizeUtils.fSize_12(),
//                                                           fontWeight: FontWeight.w600),
//                                                     ),
//
//                                                     Text(
//                                                       "2 days ago",
//                                                       style: GoogleFonts.poppins(
//                                                           color: AppColor.blackReviewColor,
//                                                           fontSize: SizeUtils.fSize_10(),
//                                                           fontWeight: FontWeight.w500),
//                                                     ),
//                                                   ],),
//                                                 ],
//                                               ),
//
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "4.5",
//                                                     style: GoogleFonts.poppins(
//                                                         color: AppColor.blackColor,
//                                                         fontSize: SizeUtils.fSize_12(),
//                                                         fontWeight: FontWeight.w500),
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 1,
//                                                   ),
//                                                   RatingBar.builder(
//                                                     initialRating: 4.5,
//                                                     minRating: 0,
//                                                     direction: Axis.horizontal,
//                                                     allowHalfRating: true,
//                                                     itemCount: 5,
//                                                     itemSize: 20,
//                                                     ignoreGestures: true,
//                                                     itemBuilder: (context, _) =>
//                                                     const Icon(
//                                                       Icons.star,
//                                                       color: AppColor.yellowColor,
//                                                     ),
//                                                     onRatingUpdate: (rating) {
//                                                       print(
//                                                           rating); // Use the updated rating here
//                                                     },
//                                                   ),
//                                                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
//                                                 ],
//                                               ),
//
//
//                                             ],),
//                                           SizedBox(height: SizeUtils.verticalBlockSize * 1,),
//                                           Container(height: 1,
//                                             decoration: BoxDecoration(color: AppColor.dividerColor),),
//                                           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
//
//                                           Text(
//                                             "Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy",
//                                             style: GoogleFonts.poppins(
//                                                 color: AppColor.blackReviewColor,
//                                                 fontSize: SizeUtils.fSize_11(),
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
//
//                                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1,horizontal: SizeUtils.horizontalBlockSize * 1),
//                                                     child: Image.asset("asset/images/list_items.png",
//                                                       height: SizeUtils.verticalBlockSize * 6,
//                                                       width: SizeUtils.horizontalBlockSize * 12,),
//                                                   )),
//                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxContainerColor,borderRadius: BorderRadius.circular(6)),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize*1,left: SizeUtils.horizontalBlockSize *1,right: SizeUtils.horizontalBlockSize*1),
//
//                                                     child: Image.asset("asset/images/list_items.png",
//                                                       height: SizeUtils.verticalBlockSize * 6,
//                                                       width: SizeUtils.horizontalBlockSize * 12,),
//                                                   )),
//                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxItemColor,borderRadius: BorderRadius.circular(6)),
//                                               ),
//                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxYellowColor,borderRadius: BorderRadius.circular(6)),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1.5,horizontal: SizeUtils.horizontalBlockSize * 1),
//                                                     child: Image.asset("asset/images/list_items.png",
//                                                       height: SizeUtils.verticalBlockSize * 6,
//                                                       width: SizeUtils.horizontalBlockSize * 12,),
//                                                   )),
//                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxBlackColor,borderRadius: BorderRadius.circular(6)),
//                                                   child: Image.asset("asset/images/list_items.png",
//                                                     height: SizeUtils.verticalBlockSize * 6,
//                                                     width: SizeUtils.horizontalBlockSize * 12,
//                                                   )),
//                                             ],
//                                           ),
//
//                                           SizedBox(height: SizeUtils.verticalBlockSize*3,)
//                                         ],),
//                                       )
//
//                                   ),
//                                   SizedBox(height: SizeUtils.verticalBlockSize*2,)
//                                 ],
//                               ),
//                             );
//
//                           },),
//                         ):SizedBox(),
//                         isTap && totalReview>3?GestureDetector(onTap: () {
//
//                           isExpandedReview=!isExpandedReview;
//                           setState(() {
//
//                           });
//                         },
//                           child: Align(alignment: Alignment.bottomLeft,
//                             child: Text(
//                               isExpandedReview ? 'Read less' : 'Read more',
//                               style: GoogleFonts.poppins(
//                                   color: AppColor.blackTextColor,
//                                   fontSize: SizeUtils.fSize_16(),
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                         ):SizedBox(),
//
//
//
//
//
//
//                         // isTap ?     Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 4),
//                         //   child: Container(decoration: BoxDecoration(
//                         //       color: AppColor.containerBackGroundColor,
//                         //       borderRadius: BorderRadius.circular(6)),
//                         //       child: Padding(
//                         //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                         //         child: Column(children: [
//                         //
//                         //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //             children: [
//                         //
//                         //               Row(
//                         //                 children: [
//                         //                   Image.asset("asset/images/list_profile.png",
//                         //                     width: SizeUtils.horizontalBlockSize * 10,
//                         //                     height: SizeUtils.verticalBlockSize * 5,),
//                         //                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
//                         //                   Column(children: [
//                         //                     Text(
//                         //                       "Haylie Aminoff",
//                         //                       style: GoogleFonts.poppins(
//                         //                           color: AppColor.blackColor,
//                         //                           fontSize: SizeUtils.fSize_12(),
//                         //                           fontWeight: FontWeight.w600),
//                         //                     ),
//                         //
//                         //                     Text(
//                         //                       "2 days ago",
//                         //                       style: GoogleFonts.poppins(
//                         //                           color: AppColor.blackReviewColor,
//                         //                           fontSize: SizeUtils.fSize_10(),
//                         //                           fontWeight: FontWeight.w500),
//                         //                     ),
//                         //                   ],),
//                         //                 ],
//                         //               ),
//                         //
//                         //               Row(
//                         //                 children: [
//                         //                   Text(
//                         //                     "4.5",
//                         //                     style: GoogleFonts.poppins(
//                         //                         color: AppColor.blackColor,
//                         //                         fontSize: SizeUtils.fSize_12(),
//                         //                         fontWeight: FontWeight.w500),
//                         //                   ),
//                         //                   const SizedBox(
//                         //                     width: 1,
//                         //                   ),
//                         //                   RatingBar.builder(
//                         //                     initialRating: 4.5,
//                         //                     minRating: 0,
//                         //                     direction: Axis.horizontal,
//                         //                     allowHalfRating: true,
//                         //                     itemCount: 5,
//                         //                     itemSize: 20,
//                         //                     ignoreGestures: true,
//                         //                     itemBuilder: (context, _) =>
//                         //                     const Icon(
//                         //                       Icons.star,
//                         //                       color: AppColor.yellowColor,
//                         //                     ),
//                         //                     onRatingUpdate: (rating) {
//                         //                       print(
//                         //                           rating); // Use the updated rating here
//                         //                     },
//                         //                   ),
//                         //                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
//                         //                 ],
//                         //               ),
//                         //
//                         //
//                         //             ],),
//                         //           SizedBox(height: SizeUtils.verticalBlockSize * 1,),
//                         //           Container(height: 1,
//                         //             decoration: BoxDecoration(color: AppColor.dividerColor),),
//                         //           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
//                         //
//                         //           Text(
//                         //             "Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy",
//                         //             style: GoogleFonts.poppins(
//                         //                 color: AppColor.blackReviewColor,
//                         //                 fontSize: SizeUtils.fSize_11(),
//                         //                 fontWeight: FontWeight.w400),
//                         //           ),
//                         //           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
//                         //
//                         //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //             children: [
//                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
//                         //                   child: Padding(
//                         //                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1,horizontal: SizeUtils.horizontalBlockSize * 1),
//                         //                     child: Image.asset("asset/images/list_items.png",
//                         //                       height: SizeUtils.verticalBlockSize * 6,
//                         //                       width: SizeUtils.horizontalBlockSize * 12,),
//                         //                   )),
//                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxContainerColor,borderRadius: BorderRadius.circular(6)),
//                         //                   child: Padding(
//                         //                     padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize*1,left: SizeUtils.horizontalBlockSize *1,right: SizeUtils.horizontalBlockSize*1),
//                         //
//                         //                     child: Image.asset("asset/images/list_items.png",
//                         //                       height: SizeUtils.verticalBlockSize * 6,
//                         //                       width: SizeUtils.horizontalBlockSize * 12,),
//                         //                   )),
//                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxItemColor,borderRadius: BorderRadius.circular(6)),
//                         //               ),
//                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxYellowColor,borderRadius: BorderRadius.circular(6)),
//                         //                   child: Padding(
//                         //                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1.5,horizontal: SizeUtils.horizontalBlockSize * 1),
//                         //                     child: Image.asset("asset/images/list_items.png",
//                         //                       height: SizeUtils.verticalBlockSize * 6,
//                         //                       width: SizeUtils.horizontalBlockSize * 12,),
//                         //                   )),
//                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxBlackColor,borderRadius: BorderRadius.circular(6)),
//                         //                   child: Image.asset("asset/images/list_items.png",
//                         //                     height: SizeUtils.verticalBlockSize * 6,
//                         //                     width: SizeUtils.horizontalBlockSize * 12,
//                         //                   )),
//                         //             ],
//                         //           ),
//                         //
//                         //           SizedBox(height: SizeUtils.verticalBlockSize*3,)
//                         //         ],),
//                         //       )
//                         //
//                         //   ),
//                         // ) : SizedBox()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
// SizedBox(height: SizeUtils.verticalBlockSize*3,)
// ,

      widget.relatedRecommendedProduct!.product!.relatedProducts!.isEmpty?SizedBox():     Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              name: "Related products",
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

      widget.relatedRecommendedProduct!.product!.relatedProducts!.isEmpty?SizedBox():      SizedBox(height: SizeUtils.verticalBlockSize*1,),
      widget.relatedRecommendedProduct!.product!.relatedProducts!.isEmpty?SizedBox():  SizedBox(
        //height:280,

        height: SizeUtils.verticalBlockSize * 40,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.relatedRecommendedProduct!.product!.relatedProducts!.length,
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
                              // Get.to(const ProductDetails(),arguments:{
                              //   'productId': widget.popularProductModel!.popularProducts![index].id,
                              //   'productSlug':  widget.popularProductModel!.popularProducts![index].slug,
                              //
                              // });
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              child: Image.network(
                                  "${ widget.relatedRecommendedProduct!.product!.relatedProducts![index].image!.original}",
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
                                    "popularProductModel!.popularProducts![index].inWishlist======${widget.relatedRecommendedProduct!.product!.relatedProducts![index].id}");
                                print("like");

                                if (widget.token != null) {
                                  // popularProductModel!.popularProducts![index].inWishlist =
                                  // !(popularProductModel!.popularProducts![index].inWishlist ?? false);

                                  toggleWishListModel =
                                  await graphQLService.wishListToggle(
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].id!,
                                      widget. token ?? "");
                                  print(
                                      "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                                  inWishListModel =
                                  await graphQLService.inWishList(
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].id!,
                                      widget.token ?? "");
                                  print(
                                      "inWishListModelget========${inWishListModel!.inWishlist}");

                                  widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                      .inWishlist =
                                      toggleWishListModel!.toggleWishlist;
                                  setState(() {});
                                } else {
                                  Get.toNamed(Routes.logInScreen);
                                }

                                print(
                                    "popularProductModel!.popularProducts![index].inWishlist======${widget.relatedRecommendedProduct!.product!.relatedProducts![index].id}");
                                print(
                                    "popularProductModel!.popularProducts![index].inWishlist======${widget.relatedRecommendedProduct!.product!.relatedProducts![index].inWishlist}");
                              },
                              child: Image.asset(
                                widget.relatedRecommendedProduct!.product!.relatedProducts![index].inWishlist ==
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
                                "${widget.relatedRecommendedProduct!.product!.relatedProducts![index].name}",
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
                            "Rp${widget.relatedRecommendedProduct!.product!.relatedProducts![index].salePrice}",
                            color: AppColor.greenColor,
                            fontSize: SizeUtils.fSize_13(),
                            fontWeight: FontWeight.w700,
                          ),
                          CustomText(
                            name:
                            "/ ${widget.relatedRecommendedProduct!.product!.relatedProducts![index].unit}",
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
                                      "Rp ${widget.relatedRecommendedProduct!.product!.relatedProducts![index].price}",
                                      color: AppColor.greenColor,
                                      fontSize: SizeUtils.fSize_12(),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      name:
                                      "Rp ${widget.relatedRecommendedProduct!.product!.relatedProducts![index].maxPrice}",
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
                            widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn ==
                                null ||widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn ==
                                0
                                ? GestureDetector(
                              onTap: () async {
                                print("tap");

                                if(token!="")
                                {
                                  print("tap");
                                  variationsProductModel =
                                  await graphQLService
                                      .variationsProduct(
                                      widget.token ?? "",
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                          .id!);

                                  if (variationsProductModel!
                                      .product!.variations!.isEmpty) {
                                    count = int.parse(
                                        "${widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn == null ? 0 : widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn}");

                                    setState(() {
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                          .qtn = count + 1;
                                    });
                                    await relatedAddProduct(
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].id,
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                          .image!
                                          .original,
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                          .salePrice
                                          .toString(),
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn,
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].name,
                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].unit,
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

                                            if ( widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn != null &&
                                                int.parse( widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn.toString()) != 0) {

                                              print("get to popular");
                                              count = int.parse( widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn.toString());
                                              print("count=====$count");
                                              widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn = count - 1;

                                              if ( widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn == 0) {
                                                print("get to popular10");
                                                widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn = null;
                                                print(
                                                    " popularProduct.qtn====${ widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn}");


                                                productRemoveModel = await graphQLService.cartProductRemove( widget.relatedRecommendedProduct!.product!.relatedProducts![index].id!);

                                                print(
                                                    "addProductModel====${ widget.relatedRecommendedProduct!.product!.relatedProducts![index].id}");
                                                if (productRemoveModel!.addtocartProductRemove == "Success") {
                                                  print("get to popular100");
                                                  await relatedDecreaseProduct(
                                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].id,
                                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].image!.original,
                                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].salePrice.toString(),
                                                      0,
                                                      //       widget.popularProductModel!.popularProducts![index].qtn,
                                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].name,
                                                      widget.relatedRecommendedProduct!.product!.relatedProducts![index].unit);
                                                  // nonVariationCartProduct.removeWhere((element) => element.productId == widget.popularProductModel!.popularProducts![index].id);

                                                  //count = 0;
                                                }
                                                saveListInSharedPreferences();
                                              } else {
                                                print("get to popular1000");
                                                setState(() {});
                                                await relatedDecreaseProduct(
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].id,
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].image!.original,
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].salePrice.toString(),
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn,
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].name,
                                                    widget.relatedRecommendedProduct!.product!.relatedProducts![index].unit);
                                                saveListInSharedPreferences();
                                              }

                                              print(
                                                  "qtn=====${widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn}");
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
                                          name: "${widget.relatedRecommendedProduct!.product!.relatedProducts![index].qtn}",
                                          color:
                                          AppColor.backGroundColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          SizeUtils.fSize_14(),
                                        ),
                                        GestureDetector(
                                          onTap: () async {

                                            count = int.parse(widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                                .qtn
                                                .toString());

                                            widget.relatedRecommendedProduct!.product!.relatedProducts![index]
                                                .qtn = count + 1;
                                            setState(() {});
                                            await relatedIncreaseProduct(
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
                                            index]
                                                .id,
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
                                            index]
                                                .image!
                                                .original,
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
                                            index]
                                                .salePrice
                                                .toString(),
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
                                            index]
                                                .qtn,
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
                                            index]
                                                .name,
                                            widget.relatedRecommendedProduct!.product!.relatedProducts![
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

      widget.relatedRecommendedProduct!.product!.relatedProducts!.isEmpty?SizedBox():    SizedBox(height: SizeUtils.verticalBlockSize*1,),
      
      
      
    ],);
  }

  getListFromSharedPreferences() {


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
  Future<void> relatedAddProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    addProductModel = await graphQLService.addToCartProduct(productId!);

    await storeRelatedProduct(productId, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }


  Future<void> storeRelatedProduct(
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

  Future<void> relatedDecreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeRelatedProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);
  }

  relatedIncreaseProduct(
      String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storeRelatedProduct(productId!, productImage, productPrice,
        productQuantity, productName, productUnit);

    await saveListInSharedPreferences();
  }
}
