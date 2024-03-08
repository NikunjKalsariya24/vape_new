import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vape/model/add_product_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/nonvariation_product_model.dart';
import 'package:vape/model/people_buy_model.dart';
import 'package:vape/model/popular_product_model.dart';
import 'package:vape/model/produc_remove_model.dart';
import 'package:vape/model/product_details_view_model.dart';
import 'package:vape/model/rating_product_model.dart';
import 'package:vape/model/related_recommended_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/model/variations_product_model.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/module/home_page/product_home_page.dart';
import 'package:vape/module/home_page/profile/profile_screen.dart';
import 'package:vape/module/home_page/related_recommended_product.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import '../cart_page/cart_screen.dart';
import 'item_screen.dart';
import 'massage_screen.dart';
import 'people_alsobuy_view.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
   String? longText ;


  int subItemSelected = 1;

  bool isExpanded = false;

  int isSelect = 1;

  int isSelectKg = 1;

  int itemQuantity = 1;
  int cont=0;

  bool isTap = false;

  int totalReview=10;
  String? productId;
  String? productSlug;

  BottomBarController bottomBarController=Get.put(BottomBarController());
  Map<String, dynamic> data = Get.arguments;
  bool isExpandedReview=false;
  ProductDetailsViewData? productDetailsViewModel;
  GraphQLService graphQLService=GraphQLService();
  SharedPrefService sharedPrefService=SharedPrefService();
   RelatedRecommendedData? relatedRecommendedProduct;
   ToggleWishData? toggleWishListModel;
   InWishListData? inWishListModel;
   VariationsData?  variationsProductModel;
   AddProductData? addProductModel;
   RatingProductData? ratingProductModel;

  String? token;

  bool isProductView=false;

   int count = 0;

   ProductRemoveData? productRemoveModel;
   PeopleBuyData? peopleBuyModel;
  // final pages = [
  //   ProductHomePage(),
  //   const ItemScreen(),
  //   const CartScreen(),
  //   const MassageScreen(),
  //   const ProfileScreen(),
  // ];

   int selectedIndex = 0;

  String? commentDate;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = sharedPrefService.getToken();
    productId=data['productId'];
    productSlug=data['productSlug'];
    print("productId=====${productId}");
    print("productSlug=====${productSlug}");
    bottomBarController.pageNewIndex.value=(-1);
    getProductDetails();

  }
   bool isExpanded1 = false;

  getProductDetails() async {

    setState(() {
      isProductView=true;
    });
    productDetailsViewModel=await graphQLService.productDetailsView(token??"", "$productId", "$productSlug", "en");
    print("productDetailsViewModel=====${productDetailsViewModel?.product}");
    if(productDetailsViewModel != null)
      {
        longText=productDetailsViewModel!.product?.description??"";
        print("longText====${longText}");


        getAllProduct();

      }

    relatedRecommendedProduct=await graphQLService.relatedRecommendedProduct(token??"", productSlug!);
    print("relatedRecommendedProduct========${relatedRecommendedProduct!.product!.relatedProducts!.length}");
    peopleBuyModel = await graphQLService.peopleBuy(token ?? "", "Grocery");

    ratingProductModel=await graphQLService.ratingProduct(token!, 5, 1, "3");

    setState(() {
      isProductView=false;

    });
    if (relatedRecommendedProduct == null) {
      setState(() {
        isProductView=false;

      });

      print("Related recommended product is null");

    }
  }

   getAllProduct() async {
     await  getListFromSharedPreferences();
     nonVariationCartProduct.forEach((element) {

       if(  productId==element.productId)
         {
           productDetailsViewModel!.product!.qtn=element.productQuantity;
print("productDetailsViewModel!.product!.qtn======${ productDetailsViewModel!.product!.qtn}");
           setState(() {

           });

         }
       // widget.popularProductModel?.popularProducts
       //     ?.forEach((elementPopularProduct) {
       //   if (element.id == elementPopularProduct.id) {
       //     elementPopularProduct.qtn = element.qtn;
       //   }
       //
       //   setState(() {});
       // });
     });
   }
   List<NonVariationProductModel> nonVariationCartProduct = [];
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
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Obx(() =>
          //child:
          Scaffold(
            backgroundColor: AppColor.backGroundColor,
            bottomNavigationBar:AppBottomBar(bottomBar: "0"),

            // Container(
            //   height: SizeUtils.verticalBlockSize * 8,
            //   decoration:  BoxDecoration(
            //     borderRadius: const BorderRadius.only(
            //         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            //     color: AppColor.blackLightColor.withOpacity(0.10),
            //
            //
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: SizeUtils.horizontalBlockSize * 6),
            //     child: Center(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //
            //           GestureDetector(onTap: () {
            //             bottomBarController.pageNewIndex.value = 0;
            //           },
            //             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //               Image.asset(
            //                 bottomBarController.pageNewIndex.value==1 ||   bottomBarController.pageNewIndex.value==2 ||   bottomBarController.pageNewIndex.value==3
            //                     ||   bottomBarController.pageNewIndex.value==4?"asset/images/unselected_home.png":
            //                     "asset/images/selected_home.png",
            //                 height: 25,
            //                 fit: BoxFit.contain,
            //
            //               ),
            //               bottomBarController.pageNewIndex.value==1 ||   bottomBarController.pageNewIndex.value==2 ||   bottomBarController.pageNewIndex.value==3
            //                   ||   bottomBarController.pageNewIndex.value==4?SizedBox():      CustomText(
            //                 name: "Home",
            //                 color: AppColor.orangeColor,
            //                 fontSize: SizeUtils.fSize_12(),
            //                 fontWeight: FontWeight.w500,
            //               )
            //
            //             ]),
            //           )
            //           ,
            //           customBottomBarContainer(
            //               onTap: () {
            //                 bottomBarController.pageNewIndex.value = 1;
            //               },
            //               selectedImageName: "asset/images/selected_favorite.png",
            //               unSelectedImageName: "asset/images/unselected_favorite.png",
            //               textName: "Wishlist",
            //               selectedIndex: 1),
            //           customBottomBarContainer(
            //               onTap: () {
            //                 bottomBarController.pageNewIndex.value = 2;
            //               },
            //               selectedImageName: "asset/images/slected_cart.png",
            //               unSelectedImageName: "asset/images/unselected_bag.png",
            //               textName: "Cart",
            //               selectedIndex: 2),
            //           customBottomBarContainer(
            //               onTap: () {
            //                 bottomBarController.pageNewIndex.value = 3;
            //               },
            //               selectedImageName: "asset/images/selected_support.png",
            //               unSelectedImageName:
            //               "asset/images/unselected_massage.png",
            //               textName: "Support",
            //               selectedIndex: 3),
            //           customBottomBarContainer(
            //               onTap: () {
            //                 bottomBarController.pageNewIndex.value = 4;
            //               },
            //               selectedImageName: "asset/images/selected_profile.png",
            //               unSelectedImageName:
            //               "asset/images/unselected_profile.png",
            //               textName: "Profile",
            //               selectedIndex: 4),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            body:bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:


            isProductView?const Center(child: CircularProgressIndicator()):   SingleChildScrollView(
              child: Column(
                  children: [
              Padding(
              padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //    SizedBox(height: SizeUtils.verticalBlockSize*2,),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeUtils.verticalBlockSize * 1),
                      child: Image.network("${productDetailsViewModel!.product!.image!.original}",
                          height: SizeUtils.verticalBlockSize * 35,
                          fit: BoxFit.contain),
                    ),
                  ),

                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 10,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productDetailsViewModel!.product!.gallery!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                subItemSelected = index;
                                setState(() {});
                              },
                              child: subItemSelected == index
                                  ? DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                child: Container(
                                  height:
                                  SizeUtils.verticalBlockSize * 8,
                                  width: SizeUtils.horizontalBlockSize *
                                      17.0,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${productDetailsViewModel!.product!.gallery![index].original}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                                  : Container(
                                  width: SizeUtils.horizontalBlockSize *
                                      17.0,
                                  height: SizeUtils.verticalBlockSize * 8,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        "${productDetailsViewModel!.product!.gallery![index].original}",
                                        fit: BoxFit.contain),
                                  )),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 1,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 2,
                  ),
                  Text(
                     "${productDetailsViewModel!.product!.name}",
                    style: GoogleFonts.inter(
                        color: AppColor.blackTextColor,
                        fontSize: SizeUtils.fSize_20(),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),

                  Text(
                    "${productDetailsViewModel!.product!.slug}",
                    style: GoogleFonts.inter(
                        color: AppColor.blackTextColor,
                        fontSize: SizeUtils.fSize_13(),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Row(
                    children: [
                      Text(
                        "${productDetailsViewModel!.product!.ratings}",
                        style: GoogleFonts.poppins(
                            color: AppColor.bottomsSheetTexColor,
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      RatingBar.builder(
                        initialRating: double.parse("${productDetailsViewModel!.product!.ratings}") ,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        ignoreGestures: true,
                        itemBuilder: (context, _) =>
                        const Icon(
                          Icons.star,
                          color: AppColor.yellowColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating); // Use the updated rating here
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Text(
                    "\$${"${productDetailsViewModel!.product!.salePrice}"}",
                    style: GoogleFonts.inter(
                        color: AppColor.blackTextColor,
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),

                  Text(
                    "Descriptions",
                    style: GoogleFonts.inter(
                        color: AppColor.blackTextColor,
                        fontSize: SizeUtils.fSize_20(),
                        fontWeight: FontWeight.w800),
                  ),


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
                    // isExpanded
                    //     ? longText!
                    //     : longText!.substring(0, 110) + '...',
                    //textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                        color: AppColor.bottomsSheetTexColor,
                        fontSize: SizeUtils.fSize_16(),
                        fontWeight: FontWeight.w400),
                  ),

                  //
                  longText!.length >110?    Text(
                    isExpanded
                        ? longText!
                        : longText!.substring(0, 110) + '...',
                    //textAlign: TextAlign.justify,
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

                      ListView.builder(itemCount: productDetailsViewModel!.product!.attributeslist!.length,shrinkWrap: true,itemBuilder: (context, index) {

                        return Column(crossAxisAlignment:CrossAxisAlignment.start,children: [


                            CustomText(name: "${productDetailsViewModel!.product!.attributeslist![index].key} :",fontSize: SizeUtils.fSize_16(),color: AppColor.blackColor,fontWeight: FontWeight.w600),
                                                          SizedBox(height: SizeUtils.verticalBlockSize*1),


                            GridView.builder(shrinkWrap: true,itemCount:productDetailsViewModel!.product!.attributeslist![index].data!.length ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: SizeUtils.verticalBlockSize*6), itemBuilder: (context, newIndex) {
                              return GestureDetector(onTap: () {

                                selectedIndex=newIndex;
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


                        ],);
                      },),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       top: SizeUtils.verticalBlockSize * 2,
                  //       bottom: SizeUtils.verticalBlockSize * 2),
                  //   child: SizedBox(
                  //     height: 60,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       shrinkWrap: true,
                  //       itemCount: circleColor.length,
                  //       itemBuilder: (context, index) {
                  //         return SizedBox(
                  //           height: 60,
                  //           width: 65,
                  //           child: Row(
                  //             children: [
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   isSelect = index;
                  //                   setState(() {});
                  //                 },
                  //                 child: isSelect == index
                  //                     ? DottedBorder(
                  //                   color: Colors.black,
                  //                   strokeWidth: 2,
                  //                   borderType: BorderType.Circle,
                  //                   dashPattern: [5, 2],
                  //                   child: Container(
                  //                     height: 45,
                  //                     width: 45,
                  //                     decoration: BoxDecoration(
                  //                       shape: BoxShape.circle,
                  //                       color: circleColor[index],
                  //                     ),
                  //                   ),
                  //                 )
                  //                     : Container(
                  //                   height: 45,
                  //                   width: 45,
                  //                   decoration: BoxDecoration(
                  //                     color: circleColor[index],
                  //                     shape: BoxShape.circle,
                  //                     border: Border.all(
                  //                       color: Colors.transparent,
                  //                       width: 2.0,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               // SizedBox(width: SizeUtils.horizontalBlockSize*3,)
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: SizeUtils.verticalBlockSize * 6,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 4,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: EdgeInsets.only(
                  //             right: SizeUtils.horizontalBlockSize * 3),
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               isSelectKg = index;
                  //             });
                  //           },
                  //           child: Container(
                  //               height: SizeUtils.verticalBlockSize * 3,
                  //               width: SizeUtils.horizontalBlockSize * 20,
                  //               decoration: isSelectKg == index
                  //                   ? BoxDecoration(
                  //                   border: Border.all(
                  //                       color: AppColor.greenBorderColor,
                  //                       width: 1.5),
                  //                   borderRadius:
                  //                   BorderRadius.circular(6),
                  //                   color: AppColor.orangeShadowColor)
                  //                   : BoxDecoration(
                  //                   borderRadius:
                  //                   BorderRadius.circular(6),
                  //                   color: AppColor.blackShadowColor),
                  //               child: Center(
                  //                   child: CustomText(
                  //                     name: "1 KG",
                  //                     color: isSelectKg == index
                  //                         ? AppColor.orangeColor
                  //                         : AppColor.blackColor,
                  //                     fontWeight: isSelectKg == index
                  //                         ? FontWeight.w600
                  //                         : FontWeight.w400,
                  //                     fontSize: isSelectKg == index
                  //                         ? SizeUtils.fSize_20()
                  //                         : SizeUtils.fSize_18(),
                  //                   ))),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

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

                  // productDetailsViewModel!.product!.qtn==null?   Row(
                  //   children: [
                  //     Container(
                  //         height: SizeUtils.verticalBlockSize * 6,
                  //         width: SizeUtils.horizontalBlockSize * 35,
                  //         decoration: BoxDecoration(
                  //             color: AppColor.greenColor,
                  //             borderRadius: BorderRadius.circular(6)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: EdgeInsets.only(
                  //                   right: SizeUtils.horizontalBlockSize * 3),
                  //               child: GestureDetector(
                  //                 onTap: () {
                  //                   if (itemQuantity >= 0) {
                  //                     setState(() {
                  //                       itemQuantity = itemQuantity + 1;
                  //                     });
                  //                   }
                  //                 },
                  //                 child: const Icon(Icons.add,
                  //                     color: AppColor.backGroundColor),
                  //               ),
                  //             ),
                  //            CustomText(
                  //               name: "Add",
                  //               fontSize: SizeUtils.fSize_18(),
                  //               fontWeight: FontWeight.w700,
                  //               color: AppColor.backGroundColor,
                  //             )
                  //
                  //           ],
                  //         )),
                  //     // Expanded(
                  //     //     child: Padding(
                  //     //       padding: EdgeInsets.symmetric(
                  //     //           horizontal: SizeUtils.horizontalBlockSize *
                  //     //               4),
                  //     //       child: Container(
                  //     //           height: SizeUtils.verticalBlockSize * 6,
                  //     //           decoration: BoxDecoration(
                  //     //             color: AppColor.yellowCircleColor,
                  //     //             borderRadius: BorderRadius.circular(6),
                  //     //           ),
                  //     //           child: Center(
                  //     //               child: CustomText(
                  //     //                 name: "Add to cart",
                  //     //                 fontSize: SizeUtils.fSize_18(),
                  //     //                 fontWeight: FontWeight.w700,
                  //     //                 color: AppColor.backGroundColor,
                  //     //               ))),
                  //     //     ))
                  //   ],
                  // ):
                 Row(
                    children: [
                      productDetailsViewModel!.product!.qtn==null ||   productDetailsViewModel!.product!.qtn==0?  GestureDetector(onTap: () async {


                        variationsProductModel =
                            await graphQLService
                            .variationsProduct(
                            token ?? "",
                            productDetailsViewModel!.product!
                                .id!);

                        if (variationsProductModel!
                            .product!.variations!.isEmpty) {
                          count = int.parse(
                              "${ productDetailsViewModel!.product!.qtn == null ? 0 : productDetailsViewModel!.product!.qtn}");

                          setState(() {
                            productDetailsViewModel!.product!
                                .qtn = count + 1;
                          });
                          await addProductDetails(
                          productDetailsViewModel!.product!.id,
                          productDetailsViewModel!.product!
                              .image!
                              .original,
                          productDetailsViewModel!.product!
                              .salePrice
                              .toString(),
                          productDetailsViewModel!.product!.qtn,
                          productDetailsViewModel!.product!.name,
                          productDetailsViewModel!.product!.unit,
                          );
                        }
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


                                    print("tap");
                                    if (   productDetailsViewModel!.product!
                                        .qtn !=
                                        null &&
                                        int.parse(   productDetailsViewModel!.product!
                                            .qtn
                                            .toString()) !=
                                            0) {
                                      count = int.parse(   productDetailsViewModel!.product!
                                          .qtn
                                          .toString());
                                      print("count=====$count");
                                      productDetailsViewModel!.product!
                                          .qtn = count - 1;

                                      if (   productDetailsViewModel!.product!
                                          .qtn ==
                                          0) {
                                        productDetailsViewModel!.product!
                                            .qtn = null;
                                        print(
                                            " popularProduct.qtn====${   productDetailsViewModel!.product!.qtn}");

                                        productRemoveModel =
                                            await graphQLService
                                            .cartProductRemove(   productDetailsViewModel!.product!
                                            .id!);

                                        print(
                                            "addProductModel====${   productDetailsViewModel!.product!.id}");
                                        if (productRemoveModel!
                                            .addtocartProductRemove ==
                                            "Success") {

                                          await decreaseProductDetails(
                                              productDetailsViewModel!.product!
                                                  .id,
                                              productDetailsViewModel!.product!
                                                  .image!
                                                  .original,
                                              productDetailsViewModel!.product!
                                                  .salePrice
                                                  .toString(),0,
                                              // productDetailsViewModel!.product!
                                              //     .qtn,
                                              productDetailsViewModel!.product!
                                                  .name,
                                              productDetailsViewModel!.product!
                                                  .unit);

                                          // nonVariationCartProduct
                                          //     .removeWhere((element) =>
                                          // element
                                          //     .productId ==
                                          //     productDetailsViewModel!.product!
                                          //         .id);

                                          //count = 0;
                                        }
                                      } else {

                                        await decreaseProductDetails(
                                            productDetailsViewModel!.product!
                                            .id,
                                            productDetailsViewModel!.product!
                                            .image!
                                            .original,
                                            productDetailsViewModel!.product!
                                            .salePrice
                                            .toString(),
                                            productDetailsViewModel!.product!
                                            .qtn,
                                            productDetailsViewModel!.product!
                                            .name,
                                            productDetailsViewModel!.product!
                                            .unit);
                                      }

                                      print(
                                          "qtn=====${   productDetailsViewModel!.product!.qtn}");
                                      saveListInSharedPreferences();
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: const Icon(Icons.remove,
                                      color: AppColor.backGroundColor),
                                ),
                              ),
                              CustomText(
                                name:   productDetailsViewModel!.product!.qtn.toString(),
                                color: AppColor.backGroundColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeUtils.fSize_14(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: SizeUtils.horizontalBlockSize * 3),
                                child: GestureDetector(
                                  onTap: () async {
                                    count = int.parse( productDetailsViewModel!.product!
                                        .qtn
                                        .toString());

                                    productDetailsViewModel!.product!
                                        .qtn = count + 1;
                                    setState(() {});
                                    await increaseProductDetails(
                                    productDetailsViewModel!.product!
                                        .id,
                                    productDetailsViewModel!.product!
                                        .image!
                                        .original,
                                    productDetailsViewModel!.product!
                                        .salePrice
                                        .toString(),
                                    productDetailsViewModel!.product!
                                        .qtn,
                                    productDetailsViewModel!.product!
                                        .name,
                                    productDetailsViewModel!.product!
                                        .unit);

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

                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 2,
                  ),
                ],

                // Image.asset("name")
              ),
            ),
            Padding(  padding: const EdgeInsets.symmetric(horizontal: 8),
              child:  Container(   padding: EdgeInsets.zero, decoration: BoxDecoration(
                color: AppColor.backGroundColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 12,
                    spreadRadius: 0,
                    color: Color.fromRGBO(
                        0, 0, 0, 0.25),
                  ),
                ],),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),childrenPadding: EdgeInsets.zero,
                  shape: const OutlineInputBorder(borderSide: BorderSide.none), leading:   Image.asset(
                  "asset/images/profile.png",
                  width: SizeUtils.horizontalBlockSize * 12,
                ),trailing:  Image.asset( isExpanded1 ?"asset/images/arrow_down.png":
                "asset/images/arrorw_next.png",
                  width: SizeUtils.horizontalBlockSize * 9,
                  height: SizeUtils.verticalBlockSize*5,
                ),
                  onExpansionChanged: (value) {
                    print("value=====${value}");
                    setState(() {
                      isExpanded1 = value;
                    });
                  },
                  //subtitle:    Text('Title 1'),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Check Product Reviews & Rattting",
                        style: GoogleFonts.poppins(
                            color: AppColor.blackDarkColor,
                            fontSize: SizeUtils.fSize_12(),
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "4.5",
                            style: GoogleFonts.poppins(
                                color: AppColor.blackColor,
                                fontSize: SizeUtils.fSize_11(),
                                fontWeight: FontWeight.w700),
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
                            itemBuilder: (context, _) =>
                            const Icon(
                              Icons.star,
                              color: AppColor.yellowColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(
                                  rating); // Use the updated rating here
                            },
                          ),


                          Text(
                            "(89 reviews)",
                            style: GoogleFonts.poppins(
                                color: AppColor.blackReviewColor,
                                fontSize: SizeUtils.fSize_10(),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    ListView.builder(shrinkWrap: true,itemCount: ratingProductModel!.reviews!.data!.length,scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {

                        DateTime dateTime = DateTime.parse(ratingProductModel!.reviews!.data![index].createdAt.toString());
                        DateTime now = DateTime.now();
                        // Calculate the difference between the two dates
                        Duration difference = now.difference(dateTime);


                        int days = difference.inDays;


                         commentDate = '$days day${days != 1 ? 's' : ''} ago';

                        print("message====${commentDate}");

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Container(decoration: BoxDecoration(
                                  color: AppColor.containerBackGroundColor,
                                  borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(
                                            children: [
                                              Image.network("${ratingProductModel!.reviews!.data![index].user!.profile!.avatar!.original}",
                                                width: SizeUtils.horizontalBlockSize * 10,
                                                height: SizeUtils.verticalBlockSize * 5,),
                                              SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
                                              Column(children: [
                                                Text(
                                                  "${ratingProductModel!.reviews!.data![index].user!.name}",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor.blackColor,
                                                      fontSize: SizeUtils.fSize_12(),
                                                      fontWeight: FontWeight.w600),
                                                ),

                                                Text(
                                                  "${commentDate}",
                                                  style: GoogleFonts.poppins(
                                                      color: AppColor.blackReviewColor,
                                                      fontSize: SizeUtils.fSize_10(),
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                "${ratingProductModel!.reviews!.data![index].rating}",
                                                style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: SizeUtils.fSize_12(),
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 1,
                                              ),
                                              RatingBar.builder(
                                                initialRating:double.parse("${ratingProductModel!.reviews!.data![index].rating}"),
                                                minRating: 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 20,
                                                ignoreGestures: true,
                                                itemBuilder: (context, _) =>
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColor.yellowColor,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(
                                                      rating); // Use the updated rating here
                                                },
                                              ),
                                              SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
                                            ],
                                          ),


                                        ],),
                                      SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                                      Container(height: 1,
                                        decoration: const BoxDecoration(color: AppColor.dividerColor),),
                                      SizedBox(height: SizeUtils.verticalBlockSize * 2,),

                                      Text(
                                        "${ratingProductModel!.reviews!.data![index].comment}",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.blackReviewColor,
                                            fontSize: SizeUtils.fSize_11(),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: SizeUtils.verticalBlockSize * 2,),

                                      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
                                      //         child: Padding(
                                      //           padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1,horizontal: SizeUtils.horizontalBlockSize * 1),
                                      //           child: Image.asset("asset/images/list_items.png",
                                      //             height: SizeUtils.verticalBlockSize * 6,
                                      //             width: SizeUtils.horizontalBlockSize * 12,),
                                      //         )),
                                      //     Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxContainerColor,borderRadius: BorderRadius.circular(6)),
                                      //         child: Padding(
                                      //           padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize*1,left: SizeUtils.horizontalBlockSize *1,right: SizeUtils.horizontalBlockSize*1),
                                      //
                                      //           child: Image.asset("asset/images/list_items.png",
                                      //             height: SizeUtils.verticalBlockSize * 6,
                                      //             width: SizeUtils.horizontalBlockSize * 12,),
                                      //         )),
                                      //     Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxItemColor,borderRadius: BorderRadius.circular(6)),
                                      //     ),
                                      //     Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxYellowColor,borderRadius: BorderRadius.circular(6)),
                                      //         child: Padding(
                                      //           padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1.5,horizontal: SizeUtils.horizontalBlockSize * 1),
                                      //           child: Image.asset("asset/images/list_items.png",
                                      //             height: SizeUtils.verticalBlockSize * 6,
                                      //             width: SizeUtils.horizontalBlockSize * 12,),
                                      //         )),
                                      //     Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxBlackColor,borderRadius: BorderRadius.circular(6)),
                                      //         child: Image.asset("asset/images/list_items.png",
                                      //           height: SizeUtils.verticalBlockSize * 6,
                                      //           width: SizeUtils.horizontalBlockSize * 12,
                                      //         )),
                                      //   ],
                                      // ),
                                      //
                                      // SizedBox(height: SizeUtils.verticalBlockSize*3,)
                                    ],),
                                  )

                              ),
                              SizedBox(height: SizeUtils.verticalBlockSize*2,)
                            ],
                          ),
                        );

                      },),

                  ],
                ),
              ),
            ),


                    RelatedProductView(relatedRecommendedProduct: relatedRecommendedProduct,token: token),
//
//                     relatedRecommendedProduct==null?SizedBox(): SizedBox(height: SizeUtils.verticalBlockSize*3,),
// // SizedBox(height: 10,),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 8),
// //               child: Container(
// //                 height:
// //                 isTap &&  isExpandedReview?SizeUtils.verticalBlockSize * 94:
// //
// //                  isTap ? SizeUtils.verticalBlockSize * 80 : SizeUtils
// //                      .verticalBlockSize * 8,
// //                 decoration: const BoxDecoration(
// //                   color: AppColor.backGroundColor,
// //                   //   border:Border.all(color: AppColor.blackDarkColor,width: 1) ,
// //                   borderRadius: BorderRadius.all(Radius.circular(6)),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       offset: Offset(0, 0),
// //                       blurRadius: 12,
// //                       spreadRadius: 0,
// //                       color: Color.fromRGBO(
// //                           0, 0, 0, 0.25),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Padding(
// //                   padding:
// //                   const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
// //                   child: GestureDetector(onTap:() {
// //
// //                     isTap = !isTap;
// //
// //                     setState(() {
// //
// //                     });
// //                   },
// //                     child: Column(
// //                       //crossAxisAlignment: CrossAxisAlignment.center,
// //                      // mainAxisAlignment:MainAxisAlignment.spaceBetween,
// //                       mainAxisAlignment: isTap
// //                           ? MainAxisAlignment.start
// //                           : MainAxisAlignment.center,
// //                       children: [
// //                        // isTap ?   SizedBox(height: SizeUtils.verticalBlockSize*0.7,):SizedBox(),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Image.asset(
// //                               "asset/images/profile.png",
// //                               width: SizeUtils.horizontalBlockSize * 12,
// //                             ),
// //                             Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 Text(
// //                                   "Check Product Reviews & Rattting",
// //                                   style: GoogleFonts.poppins(
// //                                       color: AppColor.blackDarkColor,
// //                                       fontSize: SizeUtils.fSize_13(),
// //                                       fontWeight: FontWeight.w500),
// //                                 ),
// //                                 Row(
// //                                   children: [
// //                                     Text(
// //                                       "4.5",
// //                                       style: GoogleFonts.poppins(
// //                                           color: AppColor.blackColor,
// //                                           fontSize: SizeUtils.fSize_11(),
// //                                           fontWeight: FontWeight.w700),
// //                                     ),
// //                                     const SizedBox(
// //                                       width: 1,
// //                                     ),
// //                                     RatingBar.builder(
// //                                       initialRating: 4.5,
// //                                       minRating: 0,
// //                                       direction: Axis.horizontal,
// //                                       allowHalfRating: true,
// //                                       itemCount: 5,
// //                                       itemSize: 20,
// //                                       ignoreGestures: true,
// //                                       itemBuilder: (context, _) =>
// //                                       const Icon(
// //                                         Icons.star,
// //                                         color: AppColor.yellowColor,
// //                                       ),
// //                                       onRatingUpdate: (rating) {
// //                                         print(
// //                                             rating); // Use the updated rating here
// //                                       },
// //                                     ),
// //
// //
// //                                     Text(
// //                                       "(89 reviews)",
// //                                       style: GoogleFonts.poppins(
// //                                           color: AppColor.blackReviewColor,
// //                                           fontSize: SizeUtils.fSize_10(),
// //                                           fontWeight: FontWeight.w400),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                             Image.asset( isTap ?"asset/images/arrow_down.png":
// //                             "asset/images/arrorw_next.png",
// //                               width: SizeUtils.horizontalBlockSize * 9,
// //                               height: SizeUtils.verticalBlockSize*5,
// //                             ),
// //                           ],
// //                         ),
// //                         isTap ?   SizedBox(height: SizeUtils.verticalBlockSize*2,):SizedBox(),
// //
// //
// //                         isTap ?   Container(height:  isExpandedReview?SizeUtils.verticalBlockSize * 80:SizeUtils.verticalBlockSize*68,
// //                           child: ListView.builder(shrinkWrap: true,itemCount: isExpandedReview?totalReview:3,scrollDirection: Axis.vertical,
// //                             physics: BouncingScrollPhysics(),
// //                             itemBuilder: (context, index) {
// //                             return Padding(
// //                               padding: const EdgeInsets.symmetric(horizontal: 4),
// //                               child: Column(
// //                                 children: [
// //                                   Container(decoration: BoxDecoration(
// //                                       color: AppColor.containerBackGroundColor,
// //                                       borderRadius: BorderRadius.circular(6)),
// //                                       child: Padding(
// //                                         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// //                                         child: Column(children: [
// //
// //                                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                             children: [
// //
// //                                               Row(
// //                                                 children: [
// //                                                   Image.asset("asset/images/list_profile.png",
// //                                                     width: SizeUtils.horizontalBlockSize * 10,
// //                                                     height: SizeUtils.verticalBlockSize * 5,),
// //                                                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
// //                                                   Column(children: [
// //                                                     Text(
// //                                                       "Haylie Aminoff",
// //                                                       style: GoogleFonts.poppins(
// //                                                           color: AppColor.blackColor,
// //                                                           fontSize: SizeUtils.fSize_12(),
// //                                                           fontWeight: FontWeight.w600),
// //                                                     ),
// //
// //                                                     Text(
// //                                                       "2 days ago",
// //                                                       style: GoogleFonts.poppins(
// //                                                           color: AppColor.blackReviewColor,
// //                                                           fontSize: SizeUtils.fSize_10(),
// //                                                           fontWeight: FontWeight.w500),
// //                                                     ),
// //                                                   ],),
// //                                                 ],
// //                                               ),
// //
// //                                               Row(
// //                                                 children: [
// //                                                   Text(
// //                                                     "4.5",
// //                                                     style: GoogleFonts.poppins(
// //                                                         color: AppColor.blackColor,
// //                                                         fontSize: SizeUtils.fSize_12(),
// //                                                         fontWeight: FontWeight.w500),
// //                                                   ),
// //                                                   const SizedBox(
// //                                                     width: 1,
// //                                                   ),
// //                                                   RatingBar.builder(
// //                                                     initialRating: 4.5,
// //                                                     minRating: 0,
// //                                                     direction: Axis.horizontal,
// //                                                     allowHalfRating: true,
// //                                                     itemCount: 5,
// //                                                     itemSize: 20,
// //                                                     ignoreGestures: true,
// //                                                     itemBuilder: (context, _) =>
// //                                                     const Icon(
// //                                                       Icons.star,
// //                                                       color: AppColor.yellowColor,
// //                                                     ),
// //                                                     onRatingUpdate: (rating) {
// //                                                       print(
// //                                                           rating); // Use the updated rating here
// //                                                     },
// //                                                   ),
// //                                                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
// //                                                 ],
// //                                               ),
// //
// //
// //                                             ],),
// //                                           SizedBox(height: SizeUtils.verticalBlockSize * 1,),
// //                                           Container(height: 1,
// //                                             decoration: BoxDecoration(color: AppColor.dividerColor),),
// //                                           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
// //
// //                                           Text(
// //                                             "Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy",
// //                                             style: GoogleFonts.poppins(
// //                                                 color: AppColor.blackReviewColor,
// //                                                 fontSize: SizeUtils.fSize_11(),
// //                                                 fontWeight: FontWeight.w400),
// //                                           ),
// //                                           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
// //
// //                                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                             children: [
// //                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
// //                                                   child: Padding(
// //                                                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1,horizontal: SizeUtils.horizontalBlockSize * 1),
// //                                                     child: Image.asset("asset/images/list_items.png",
// //                                                       height: SizeUtils.verticalBlockSize * 6,
// //                                                       width: SizeUtils.horizontalBlockSize * 12,),
// //                                                   )),
// //                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxContainerColor,borderRadius: BorderRadius.circular(6)),
// //                                                   child: Padding(
// //                                                     padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize*1,left: SizeUtils.horizontalBlockSize *1,right: SizeUtils.horizontalBlockSize*1),
// //
// //                                                     child: Image.asset("asset/images/list_items.png",
// //                                                       height: SizeUtils.verticalBlockSize * 6,
// //                                                       width: SizeUtils.horizontalBlockSize * 12,),
// //                                                   )),
// //                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxItemColor,borderRadius: BorderRadius.circular(6)),
// //                                               ),
// //                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxYellowColor,borderRadius: BorderRadius.circular(6)),
// //                                                   child: Padding(
// //                                                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1.5,horizontal: SizeUtils.horizontalBlockSize * 1),
// //                                                     child: Image.asset("asset/images/list_items.png",
// //                                                       height: SizeUtils.verticalBlockSize * 6,
// //                                                       width: SizeUtils.horizontalBlockSize * 12,),
// //                                                   )),
// //                                               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxBlackColor,borderRadius: BorderRadius.circular(6)),
// //                                                   child: Image.asset("asset/images/list_items.png",
// //                                                     height: SizeUtils.verticalBlockSize * 6,
// //                                                     width: SizeUtils.horizontalBlockSize * 12,
// //                                                   )),
// //                                             ],
// //                                           ),
// //
// //                                           SizedBox(height: SizeUtils.verticalBlockSize*3,)
// //                                         ],),
// //                                       )
// //
// //                                   ),
// //                                   SizedBox(height: SizeUtils.verticalBlockSize*2,)
// //                                 ],
// //                               ),
// //                             );
// //
// //                           },),
// //                         ):SizedBox(),
// //                         isTap && totalReview>3?GestureDetector(onTap: () {
// //
// //                           isExpandedReview=!isExpandedReview;
// //                           setState(() {
// //
// //                           });
// //                         },
// //                           child: Align(alignment: Alignment.bottomLeft,
// //                             child: Text(
// //                               isExpandedReview ? 'Read less' : 'Read more',
// //                               style: GoogleFonts.poppins(
// //                                   color: AppColor.blackTextColor,
// //                                   fontSize: SizeUtils.fSize_16(),
// //                                   fontWeight: FontWeight.w700),
// //                             ),
// //                           ),
// //                         ):SizedBox(),
// //
// //
// //
// //
// //
// //
// //                         // isTap ?     Padding(
// //                         //   padding: const EdgeInsets.symmetric(horizontal: 4),
// //                         //   child: Container(decoration: BoxDecoration(
// //                         //       color: AppColor.containerBackGroundColor,
// //                         //       borderRadius: BorderRadius.circular(6)),
// //                         //       child: Padding(
// //                         //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// //                         //         child: Column(children: [
// //                         //
// //                         //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         //             children: [
// //                         //
// //                         //               Row(
// //                         //                 children: [
// //                         //                   Image.asset("asset/images/list_profile.png",
// //                         //                     width: SizeUtils.horizontalBlockSize * 10,
// //                         //                     height: SizeUtils.verticalBlockSize * 5,),
// //                         //                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
// //                         //                   Column(children: [
// //                         //                     Text(
// //                         //                       "Haylie Aminoff",
// //                         //                       style: GoogleFonts.poppins(
// //                         //                           color: AppColor.blackColor,
// //                         //                           fontSize: SizeUtils.fSize_12(),
// //                         //                           fontWeight: FontWeight.w600),
// //                         //                     ),
// //                         //
// //                         //                     Text(
// //                         //                       "2 days ago",
// //                         //                       style: GoogleFonts.poppins(
// //                         //                           color: AppColor.blackReviewColor,
// //                         //                           fontSize: SizeUtils.fSize_10(),
// //                         //                           fontWeight: FontWeight.w500),
// //                         //                     ),
// //                         //                   ],),
// //                         //                 ],
// //                         //               ),
// //                         //
// //                         //               Row(
// //                         //                 children: [
// //                         //                   Text(
// //                         //                     "4.5",
// //                         //                     style: GoogleFonts.poppins(
// //                         //                         color: AppColor.blackColor,
// //                         //                         fontSize: SizeUtils.fSize_12(),
// //                         //                         fontWeight: FontWeight.w500),
// //                         //                   ),
// //                         //                   const SizedBox(
// //                         //                     width: 1,
// //                         //                   ),
// //                         //                   RatingBar.builder(
// //                         //                     initialRating: 4.5,
// //                         //                     minRating: 0,
// //                         //                     direction: Axis.horizontal,
// //                         //                     allowHalfRating: true,
// //                         //                     itemCount: 5,
// //                         //                     itemSize: 20,
// //                         //                     ignoreGestures: true,
// //                         //                     itemBuilder: (context, _) =>
// //                         //                     const Icon(
// //                         //                       Icons.star,
// //                         //                       color: AppColor.yellowColor,
// //                         //                     ),
// //                         //                     onRatingUpdate: (rating) {
// //                         //                       print(
// //                         //                           rating); // Use the updated rating here
// //                         //                     },
// //                         //                   ),
// //                         //                   SizedBox(width: SizeUtils.horizontalBlockSize * 6,),
// //                         //                 ],
// //                         //               ),
// //                         //
// //                         //
// //                         //             ],),
// //                         //           SizedBox(height: SizeUtils.verticalBlockSize * 1,),
// //                         //           Container(height: 1,
// //                         //             decoration: BoxDecoration(color: AppColor.dividerColor),),
// //                         //           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
// //                         //
// //                         //           Text(
// //                         //             "Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy Lorem ipsum dolor sit amet, consetetur sadi sspscing elitr, sed diam nonumy",
// //                         //             style: GoogleFonts.poppins(
// //                         //                 color: AppColor.blackReviewColor,
// //                         //                 fontSize: SizeUtils.fSize_11(),
// //                         //                 fontWeight: FontWeight.w400),
// //                         //           ),
// //                         //           SizedBox(height: SizeUtils.verticalBlockSize * 2,),
// //                         //
// //                         //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         //             children: [
// //                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
// //                         //                   child: Padding(
// //                         //                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1,horizontal: SizeUtils.horizontalBlockSize * 1),
// //                         //                     child: Image.asset("asset/images/list_items.png",
// //                         //                       height: SizeUtils.verticalBlockSize * 6,
// //                         //                       width: SizeUtils.horizontalBlockSize * 12,),
// //                         //                   )),
// //                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxContainerColor,borderRadius: BorderRadius.circular(6)),
// //                         //                   child: Padding(
// //                         //                     padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize*1,left: SizeUtils.horizontalBlockSize *1,right: SizeUtils.horizontalBlockSize*1),
// //                         //
// //                         //                     child: Image.asset("asset/images/list_items.png",
// //                         //                       height: SizeUtils.verticalBlockSize * 6,
// //                         //                       width: SizeUtils.horizontalBlockSize * 12,),
// //                         //                   )),
// //                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxItemColor,borderRadius: BorderRadius.circular(6)),
// //                         //               ),
// //                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxYellowColor,borderRadius: BorderRadius.circular(6)),
// //                         //                   child: Padding(
// //                         //                     padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1.5,horizontal: SizeUtils.horizontalBlockSize * 1),
// //                         //                     child: Image.asset("asset/images/list_items.png",
// //                         //                       height: SizeUtils.verticalBlockSize * 6,
// //                         //                       width: SizeUtils.horizontalBlockSize * 12,),
// //                         //                   )),
// //                         //               Container(   height: SizeUtils.verticalBlockSize * 8,width: SizeUtils.horizontalBlockSize * 17,decoration: BoxDecoration(color: AppColor.boxBlackColor,borderRadius: BorderRadius.circular(6)),
// //                         //                   child: Image.asset("asset/images/list_items.png",
// //                         //                     height: SizeUtils.verticalBlockSize * 6,
// //                         //                     width: SizeUtils.horizontalBlockSize * 12,
// //                         //                   )),
// //                         //             ],
// //                         //           ),
// //                         //
// //                         //           SizedBox(height: SizeUtils.verticalBlockSize*3,)
// //                         //         ],),
// //                         //       )
// //                         //
// //                         //   ),
// //                         // ) : SizedBox()
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //
// // SizedBox(height: SizeUtils.verticalBlockSize*3,)
// // ,
//
//                     relatedRecommendedProduct==null?SizedBox():     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CustomText(
//                             name: "Popular products",
//                             fontSize: SizeUtils.fSize_18(),
//                             fontWeight: FontWeight.w600,
//                           ),
//                           CustomText(
//                             name: "See All",
//                             fontSize: SizeUtils.fSize_20(),
//                             fontWeight: FontWeight.w500,
//                             color: AppColor.orangeColor,
//                           )
//                         ],
//                       ),
//                     ),
//
//                     relatedRecommendedProduct==null?SizedBox():      SizedBox(height: SizeUtils.verticalBlockSize*1,),
//                     relatedRecommendedProduct==null?SizedBox():  SizedBox(
//                       //height:280,
//
//                       height: SizeUtils.verticalBlockSize * 40,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: relatedRecommendedProduct!.product!.relatedProducts!.length,
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: SizeUtils.horizontalBlockSize * 3),
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(0.0),
//                             child: Card(
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                               ),
//                               child: Container(
//                                 // height: 100,
//                                 //   width: SizeUtils.horizontalBlockSize*40,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: AppColor.backGroundColor,
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Color.fromRGBO(0, 0, 0, 0.08),
//                                       // Shadow color with opacity
//                                       offset: Offset(0, 1),
//                                       // X, Y offset
//                                       blurRadius: 1,
//                                       // Blur radius
//                                       spreadRadius: 1, // Spread radius
//                                     ),
//                                   ],
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Stack(
//                                       alignment: Alignment.topRight,
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             // Get.to(const ProductDetails(),arguments:{
//                                             //   'productId': widget.popularProductModel!.popularProducts![index].id,
//                                             //   'productSlug':  widget.popularProductModel!.popularProducts![index].slug,
//                                             //
//                                             // });
//                                           },
//                                           child: ClipRRect(
//                                             borderRadius: const BorderRadius.only(
//                                                 topRight: Radius.circular(15),
//                                                 topLeft: Radius.circular(15)),
//                                             child: Image.network(
//                                                 "${ relatedRecommendedProduct!.product!.relatedProducts![index].image!.original}",
//                                                 fit: BoxFit.fill,
//                                                 height: SizeUtils.verticalBlockSize * 23,
//                                                 width: SizeUtils.horizontalBlockSize * 44),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(4.0),
//                                           child: GestureDetector(
//                                             onTap: () async {
//                                               print(
//                                                   "popularProductModel!.popularProducts![index].inWishlist======${relatedRecommendedProduct!.product!.relatedProducts![index].id}");
//                                               print("like");
//
//                                               if (token != null) {
//                                                 // popularProductModel!.popularProducts![index].inWishlist =
//                                                 // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
//
//                                                 toggleWishListModel =
//                                                 await graphQLService.wishListToggle(
//                                                     relatedRecommendedProduct!.product!.relatedProducts![index].id!,
//                                                   token ?? "");
//                                                 print(
//                                                     "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
//                                                 inWishListModel =
//                                                 await graphQLService.inWishList(
//                                                     relatedRecommendedProduct!.product!.relatedProducts![index].id!,
//                                                  token ?? "");
//                                                 print(
//                                                     "inWishListModelget========${inWishListModel!.inWishlist}");
//
//                                                 relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                     .inWishlist =
//                                                     toggleWishListModel!.toggleWishlist;
//                                                 setState(() {});
//                                               } else {
//                                                 Get.toNamed(Routes.logInScreen);
//                                               }
//
//                                               print(
//                                                   "popularProductModel!.popularProducts![index].inWishlist======${relatedRecommendedProduct!.product!.relatedProducts![index].id}");
//                                               print(
//                                                   "popularProductModel!.popularProducts![index].inWishlist======${relatedRecommendedProduct!.product!.relatedProducts![index].inWishlist}");
//                                             },
//                                             child: Image.asset(
//                                               relatedRecommendedProduct!.product!.relatedProducts![index].inWishlist ==
//                                                   true
//                                                   ? "asset/images/like_icon.png"
//                                                   : "asset/images/favorite.png",
//                                               //fit: BoxFit.fill,
//                                               height: SizeUtils.verticalBlockSize * 3,
//                                               //    width: SizeUtils.horizontalBlockSize*40
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: SizeUtils.verticalBlockSize * 1,
//                                           bottom: SizeUtils.verticalBlockSize * 3),
//                                       child: Row(
//                                         children: [
//                                           SizedBox(
//                                             width: SizeUtils.horizontalBlockSize * 2,
//                                           ),
//                                           SizedBox(
//                                             width: SizeUtils.horizontalBlockSize * 40,
//                                             child: CustomText(
//                                               maxLines: 1,
//                                               name:
//                                               "${relatedRecommendedProduct!.product!.relatedProducts![index].name}",
//                                               fontSize: SizeUtils.fSize_14(),
//                                               color: AppColor.grayColor,
//                                               fontWeight: FontWeight.w600,
//                                               textAlign: TextAlign.start,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         SizedBox(
//                                           width: SizeUtils.horizontalBlockSize * 1,
//                                         ),
//                                         //const SizedBox(width: 5,),
//                                         CustomText(
//                                           name:
//                                           "Rp${relatedRecommendedProduct!.product!.relatedProducts![index].salePrice}",
//                                           color: AppColor.greenColor,
//                                           fontSize: SizeUtils.fSize_13(),
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                         CustomText(
//                                           name:
//                                           "/ ${relatedRecommendedProduct!.product!.relatedProducts![index].unit}",
//                                           color: AppColor.grayColor,
//                                           fontSize: SizeUtils.fSize_10(),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: SizeUtils.verticalBlockSize * 1),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 3),
//                                             child: Container(
//                                               width: SizeUtils.horizontalBlockSize * 16,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                                 children: [
//                                                   CustomText(
//                                                     name:
//                                                     "Rp ${relatedRecommendedProduct!.product!.relatedProducts![index].price}",
//                                                     color: AppColor.greenColor,
//                                                     fontSize: SizeUtils.fSize_12(),
//                                                     fontWeight: FontWeight.w600,
//                                                   ),
//                                                   CustomText(
//                                                     name:
//                                                     "Rp ${relatedRecommendedProduct!.product!.relatedProducts![index].maxPrice}",
//                                                     color: AppColor.grayTextColor,
//                                                     fontSize: SizeUtils.fSize_11(),
//                                                     fontWeight: FontWeight.w500,
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           relatedRecommendedProduct!.product!.relatedProducts![index].qtn ==
//                                               null
//                                               ? GestureDetector(
//                                             onTap: () async {
//                                               print("tap");
//
//                                               variationsProductModel=await graphQLService.variationsProduct(token??"",  relatedRecommendedProduct!.product!.relatedProducts![index].id!);
//                                               print("variationsProductModel====${variationsProductModel!.product!.variations!.length}");
//                                               if(variationsProductModel!.product!.variations!.isEmpty)
//                                               {
//                                                 addProductModel=await graphQLService.addToCartProduct(    relatedRecommendedProduct!.product!.relatedProducts![index].id!);
//                                                 print("addProductModel====${addProductModel!.addtocartProduct}");
//                                                 print("addProductModel====${  relatedRecommendedProduct!.product!.relatedProducts![index].id!}");
//                                                 if(addProductModel!.addtocartProduct=="Success")
//                                                 {
//                                                   relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                       .qtn = count + 1;
//                                                   setState(() {});
//                                                 }
//                                               }
//
//
//
//                                             },
//                                             child: Padding(
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 4),
//                                               child: Container(
//                                                 height:
//                                                 SizeUtils.verticalBlockSize * 4.3,
//                                                 width: SizeUtils.horizontalBlockSize *
//                                                     20,
//                                                 decoration: BoxDecoration(
//                                                   color: AppColor.greenColor,
//                                                   borderRadius:
//                                                   BorderRadius.circular(6),
//                                                 ),
//                                                 child: Row(children: [
//                                                   const SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   const Icon(Icons.add,
//                                                       color:
//                                                       AppColor.backGroundColor),
//                                                   CustomText(
//                                                     name: "Add",
//                                                     color: AppColor.backGroundColor,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: SizeUtils.fSize_14(),
//                                                   )
//                                                 ]),
//                                               ),
//                                             ),
//                                           )
//                                               : Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 4),
//                                             child: Container(
//                                               height:
//                                               SizeUtils.verticalBlockSize * 4.3,
//                                               width:
//                                               SizeUtils.horizontalBlockSize * 22,
//                                               decoration: BoxDecoration(
//                                                 color: AppColor.greenColor,
//                                                 borderRadius:
//                                                 BorderRadius.circular(6),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 0),
//                                                 child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     children: [
//                                                       // SizedBox(width: 4,),
//                                                       GestureDetector(
//                                                         onTap: () async {
//                                                           print("tap");
//                                                           if (relatedRecommendedProduct!.product!.relatedProducts![index].qtn != null && int.parse(relatedRecommendedProduct!.product!.relatedProducts![index].qtn.toString()) !=
//                                                               0) {
//                                                             count = int.parse(relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                                 .qtn
//                                                                 .toString());
//                                                             print(
//                                                                 "count=====${count}");
//                                                             relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                                 .qtn = count - 1;
//                                                             if(relatedRecommendedProduct!.product!.relatedProducts![index].qtn==0)
//                                                             {
//                                                               productRemoveModel=await graphQLService.cartProductRemove(  relatedRecommendedProduct!.product!.relatedProducts![index].id!);
//                                                               print("addProductModel====${addProductModel!.addtocartProduct}");
//                                                               print("addProductModel====${relatedRecommendedProduct!.product!.relatedProducts![index].id!}");
//                                                               if(productRemoveModel!.addtocartProductRemove=="Success")
//                                                               {
//                                                                 relatedRecommendedProduct!.product!.relatedProducts![index].qtn=null;
//                                                                 count=0;
//                                                               }
//
//                                                             }
//
//                                                             print("qtn=====${relatedRecommendedProduct!.product!.relatedProducts![index].qtn}");
//
//                                                             setState(() {});
//                                                           }
//                                                           else if(int.parse(relatedRecommendedProduct!.product!.relatedProducts![index].qtn.toString())==0)
//                                                           {
//                                                             relatedRecommendedProduct!.product!.relatedProducts![index].qtn=null;
//                                                             setState(() {
//
//                                                             });
//                                                           }
//                                                           else
//                                                           {
//                                                             relatedRecommendedProduct!.product!.relatedProducts![index].qtn=null;
//                                                             setState(() {
//
//                                                             });
//                                                           }
//
//                                                         },
//                                                         child: const Icon(
//                                                             Icons.remove,
//                                                             color: AppColor
//                                                                 .backGroundColor),
//                                                       ),
//                                                       CustomText(
//                                                         name: "${relatedRecommendedProduct!.product!.relatedProducts![index].qtn}",
//                                                         color:
//                                                         AppColor.backGroundColor,
//                                                         fontWeight: FontWeight.w500,
//                                                         fontSize:
//                                                         SizeUtils.fSize_14(),
//                                                       ),
//                                                       GestureDetector(
//                                                         onTap: () {
//
//                                                           print("tap");
//                                                           count = int.parse(relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                               .qtn
//                                                               .toString());
//                                                           print("count=====${count}");
//                                                           relatedRecommendedProduct!.product!.relatedProducts![index]
//                                                               .qtn = count + 1;
//                                                           print(
//                                                               "qtn=====${relatedRecommendedProduct!.product!.relatedProducts![index].qtn}");
//                                                           setState(() {});
//                                                         },
//                                                         child: const Icon(
//                                                           Icons.add,
//                                                           color: AppColor
//                                                               .backGroundColor,
//                                                         ),
//                                                       ),
//                                                     ]),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                     relatedRecommendedProduct==null?SizedBox():    SizedBox(height: SizeUtils.verticalBlockSize*1,),
               PeopleBuyView(peopleBuyModel: peopleBuyModel,token: token,)

              ],
              ),
              ),
              ),
        )
    ,
    );
  }

  List circleColor = [
    AppColor.yellowCircleColor,
    AppColor.greenCircleColor,
    AppColor.lightBlueCircleColor,
    AppColor.redCircleColor,
    AppColor.blackCircleColor
  ];



  increaseProductDetails(  String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storePopularProduct(productId!, productImage, productPrice,
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

  addProductDetails(String? productId,
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

  decreaseProductDetails(String? productId,
      String? productImage,
      String productPrice,
      dynamic productQuantity,
      String? productName,
      String? productUnit) async {
    await storePopularProduct(productId!, productImage, productPrice,
    productQuantity, productName, productUnit);
  }
}
