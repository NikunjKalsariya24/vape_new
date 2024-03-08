import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vape/model/banner_model.dart';
import 'package:vape/model/best_selling_model.dart';
import 'package:vape/model/bottom_banner_model.dart';
import 'package:vape/model/category_model.dart';
import 'package:vape/model/coupon_model.dart';
import 'package:vape/model/custom_popular_model.dart';
import 'package:vape/model/flsh_sale_model.dart';
import 'package:vape/model/inwish_list_model.dart';
import 'package:vape/model/logo_model.dart';
import 'package:vape/model/nearest_store_model.dart';
import 'package:vape/model/new_product_model.dart';
import 'package:vape/model/new_shop_model.dart';
import 'package:vape/model/page_view_model.dart';
import 'package:vape/model/people_buy_model.dart';
import 'package:vape/model/popular_product_model.dart';
import 'package:vape/model/toggle_wish_list_model.dart';
import 'package:vape/module/custom_product_view.dart';
import 'package:vape/module/home_page/best_selling_view.dart';
import 'package:vape/module/home_page/bottom_banner_view.dart';
import 'package:vape/module/home_page/categories_view.dart';
import 'package:vape/module/home_page/controller/product_homepage_controller.dart';
import 'package:vape/module/home_page/coupon_view.dart';
import 'package:vape/module/home_page/near_shop_view.dart';
import 'package:vape/module/home_page/new_product_view.dart';
import 'package:vape/module/home_page/offer_count_down_view.dart';
import 'package:vape/module/home_page/profile/widget/custom_address.dart';
import 'package:vape/module/home_page/promotinal_slider_view.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';
import 'people_alsobuy_view.dart';
import 'popular_product_view.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  GraphQLService graphQLService = GraphQLService();

  // GraphQLService graphQLService = Get.put(GraphQLService());
  List topOfferImage = [
    "asset/images/top_offer_one.png",
    "asset/images/top_offer_two.png",
    "asset/images/top_offer_three.png",
    "asset/images/top_offer_four.png",
    "asset/images/top_offer_five.png",
    "asset/images/top_offer_six.png",
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
    "Bravrage food",
    "Food Packs",
    "Soft Drinks",
    "Dairy food",
    "Beverages",
    "Snacks",
    "Bravrage food"
  ];

  List circleColor = [
    AppColor.yellowCircleColor,
    AppColor.greenCircleColor,
    AppColor.lightBlueCircleColor,
    AppColor.redCircleColor,
    AppColor.blackCircleColor
  ];
  List productWeight = ["1 KG", "2 KG", "3 KG", "5 KG"];

  bool isSelectedColor = false;

  int isSelect = 0;
  int isSelectKg = 0;
  int itemQuantity = 1;
  ProductHomePageController productHomePageController =
      Get.put(ProductHomePageController());
  Position? position;
  List<NewShopModel>? shopList;
  bool isBanner = false;
  BannerData? bannerModel;
  BottomSliderData? bottomBannerModel;
  CategoriesData? categoryModel;
  CustomPopularData? customPopularModel;
  BestSellingData? bestSellingModel;
  PopularProductData? popularProductModel;
  PeopleBuyData? peopleBuyModel;
  LogoData? logoModel;
  ToggleWishData? toggleWishListModel;
  InWishListData? inWishListModel;
  NearestStoreData? nearestStoreModel;
  NewProductData? newProductModel;
  PageViewData? pageViewModel;
  CouponData? couponModel;
  FlashSaleData? flashSaleModel;

  // NewShopModel? newShopModel;
  List<Map<String, dynamic>>? newShopModel;
  SharedPrefService sharedPrefService = SharedPrefService();
  double? lat;
  double? long;

  String? token;

  String? pageViewDetails;

  List<String> pageViewsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
    getBannerView();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      //showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text('Location Services Disabled'),
      //     content: Text('Please enable location services in settings to use this feature.'),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text('Location Permission Denied'),
        //     content: Text('Please grant location permission in settings to use this feature.'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //         child: Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text('Location Permissions Denied Permanently'),
      //     content: Text('Location permissions are permanently denied. Please enable them in settings to use this feature.'),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
      return;
    }

    position = await Geolocator.getCurrentPosition();
    lat = position?.latitude ?? 0.00;
    long = position?.longitude ?? 0.00;
    print('Position: $position');
  }

  getBannerView() async {
    try {
      if (mounted) {
        setState(() {
          isBanner = true;
        });
      }

      token = sharedPrefService.getToken();
      pageViewModel = await graphQLService.getStartDetails("1");


      bannerModel = await graphQLService.getBanner("1");
      bottomBannerModel = await graphQLService.getBottomBanner();
      categoryModel = await graphQLService.getCategory(
          language: "en", first: 1000, page: 1, hasTypeValue: "grocery");

      bestSellingModel = await graphQLService.bestSellingProduct(token ?? "");
      customPopularModel =
          await graphQLService.customPopularProduct("1", token ?? "");
      peopleBuyModel = await graphQLService.peopleBuy(token ?? "", "Grocery");


      newProductModel = await graphQLService.newProduct(token ?? "", 30, "en");
      popularProductModel = await graphQLService.popularProduct(token ?? "");
      logoModel = await graphQLService.logo();
      couponModel=await graphQLService.couponGet(token!,16,"en");
      flashSaleModel= await graphQLService.flashSaleGet(token!);
      pageViewDetails = pageViewModel!.type!.settings!.pageViews;
      print("pageViewModel====${pageViewModel!.type!.settings!.pageViews}");

      if (pageViewDetails != null) {
        pageViewsList = pageViewDetails!.split(',');

        print("Page views list: $pageViewsList");
      } else {
        print("Page views string is null");
      }
      if (lat != 0.00 && long != 0.00) {
        shopList = await graphQLService.nearShop("$lat", "$long");
      }

      if (mounted) {
        setState(() {
          isBanner = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (mounted) {
        setState(() {
          isBanner = false;
        });
      }
    }
  }

//
//   getBannerView() async {
//     //
//     // _determinePosition();
//
//
//
//     if (mounted) {
//       setState(() {
//         isBanner = true;
//       });
//     }
//     print("inistate home page");
//     token=sharedPrefService.getToken();
//     bannerModel = await graphQLService.getBanner("1");
//     bottomBannerModel = await graphQLService.getBottomBanner();
//     categoryModel = await graphQLService.getCategory(
//         language: "en",
//         first: 1000,page: 1,hasTypeValue: "grocery");
//
//     bestSellingModel=await graphQLService.bestSellingProduct(token??"");
//     customPopularModel = await graphQLService.customPopularProduct("1",token??"");
//     peopleBuyModel=await graphQLService.peopleBuy(token??"","Grocery");
//
//     newProductModel=await graphQLService.newProduct(token??"",30,"en");
//     popularProductModel = await graphQLService.popularProduct(token??"");
//     logoModel = await graphQLService.logo();
//
//     if(lat!=0.00 && long!=0.00)
//       {
//         shopList=await graphQLService.nearShop(lat,long);
//       }
//
//     //newShopModel=await graphQLService.nearShop();
// //    print("newShopModel========${newShopModel!.length}");
//    // nearestStoreModel = await graphQLService.nearestStore("1", token??"");
//
//
//       if (mounted) {
//         setState(() {
//           isBanner = false;
//         });
//       }
//   }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: AppColor.orangeColor,
        //   elevation: 0,
        //   toolbarHeight: 150,
        //   title: Column(
        //     children: [
        //       logoModel?.settings?.options?.logo?.thumbnail==null?const SizedBox():    Image.network("${logoModel!.settings!.options!.logo!.thumbnail}",width: SizeUtils.horizontalBlockSize*10,),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //               height: 40,
        //               width: SizeUtils.horizontalBlockSize * 65,
        //               decoration: BoxDecoration(
        //                   color: AppColor.backGroundColor,
        //                   borderRadius: BorderRadius.circular(10)),
        //               child: TextFormField(onTap: () {
        //
        //                 Get.toNamed(Routes.searchScreen);
        //               },
        //                 decoration: InputDecoration(isDense: true,
        //                     border: InputBorder.none,hintText:"Search For Fruits,vegatable,groce ",hintStyle:  GoogleFonts.inter(
        //                       fontSize: SizeUtils.fSize_15(),
        //                       fontWeight: FontWeight.w400,
        //                       color:  AppColor.grayTextColor),
        //
        //                         prefixIcon: Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: Image.asset(
        //                         "asset/images/search_icon.png",
        //                         height: 15,
        //                       ),
        //                     )),
        //               )),
        //           Image.asset("asset/images/email.png", width: 35),
        //           Image.asset("asset/images/notification.png", width: 35),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 25,
        //       ),
        //       GestureDetector(onTap: () {
        //         getAddressInformation();
        //         // Get.toNamed(Routes.addAddress,
        //         //     arguments: {"addressType": "editAddress"});
        //       },
        //         child: Row(
        //           children: [
        //             Image.asset(
        //               "asset/images/location_icon.png",
        //               height: 20,
        //             ),
        //             const SizedBox(
        //               width: 5,
        //             ),
        //             CustomText(
        //               fontSize: SizeUtils.fSize_12(),
        //               fontWeight: FontWeight.w400,
        //               color: AppColor.backGroundColor,
        //               name: "Sent to",
        //             ),
        //             const SizedBox(
        //               width: 5,
        //             ),
        //             CustomText(
        //               fontSize: SizeUtils.fSize_12(),
        //               fontWeight: FontWeight.w600,
        //               color: AppColor.backGroundColor,
        //               name: "Pamulang Barat Residence No.5, RT 05/ ...",
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: isBanner
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        pinned: true,
                        toolbarHeight: SizeUtils.verticalBlockSize * 10,
                        automaticallyImplyLeading: false,
                        backgroundColor: AppColor.orangeColor,
                        expandedHeight: SizeUtils.verticalBlockSize * 40,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            height: SizeUtils.verticalBlockSize * 40,
                            width: double.infinity,

                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: AppColor.orangeColor,
                            ),
                            //  margin: EdgeInsets.only(top: 4.h),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeUtils.horizontalBlockSize * 3),
                              child: Column(children: [
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 14,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    getAddressInformation();
                                    // Get.toNamed(Routes.addAddress,
                                    //     arguments: {"addressType": "editAddress"});
                                  },
                                  child: SizedBox(
                                    height: SizeUtils.verticalBlockSize * 3,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "asset/images/location_icon.png",
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          fontSize: SizeUtils.fSize_12(),
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.backGroundColor,
                                          name: "Sent to",
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            fontSize: SizeUtils.fSize_12(),
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.backGroundColor,
                                            name:
                                                "Pamulang Barat Residence No.5, RT 05/ ...",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: SizeUtils.verticalBlockSize * 24,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      color: AppColor.orangeColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: CarouselSlider.builder(
                                          options: CarouselOptions(
                                              autoPlay: true,
                                              onPageChanged: (index, reason) {
                                                // setState(() {
                                                //   selectindex = index;
                                                // });
                                              },
                                              height:
                                                  SizeUtils.verticalBlockSize *
                                                      24,
                                              viewportFraction: 0.99,
                                              initialPage: 0,
                                              aspectRatio: 2 / 4.2),
                                          itemBuilder: (BuildContext context,
                                              int index, int realIndex) {
                                            return Image.network(
                                              bannerModel!.type!.banners![index]
                                                  .imageIcon!.original!,
                                              height:
                                                  SizeUtils.verticalBlockSize *
                                                      20,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          itemCount: bannerModel!
                                              .type!.banners!.length),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        actions: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeUtils.horizontalBlockSize * 3),
                              child: Column(
                                children: [
                                  logoModel?.settings?.options?.logo
                                              ?.thumbnail ==
                                          null
                                      ? const SizedBox()
                                      : Image.network(
                                          "${logoModel!.settings!.options!.logo!.thumbnail}",
                                          width: SizeUtils.horizontalBlockSize *
                                              10,
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 40,
                                          width: SizeUtils.horizontalBlockSize *
                                              65,
                                          decoration: BoxDecoration(
                                              color: AppColor.backGroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: TextFormField(
                                            onTap: () {
                                              Get.toNamed(Routes.searchScreen);
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintText:
                                                    "Search For Fruits,vegatable,groce ",
                                                hintStyle: GoogleFonts.inter(
                                                    fontSize:
                                                        SizeUtils.fSize_15(),
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColor.grayTextColor),
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    "asset/images/search_icon.png",
                                                    height: 15,
                                                  ),
                                                )),
                                          )),
                                      Image.asset("asset/images/email.png",
                                          width: 35),
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Image.asset(
                                              "asset/images/notification.png",
                                              width: 35),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                color: AppColor.redBoxColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: CustomText(
                                              name: "1",
                                              fontSize: SizeUtils.fSize_12(),
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.backGroundColor,
                                            )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])
                  ];
                },
                body: ListView.builder(
                  itemCount: pageViewsList.length,
                  itemBuilder: (context, index) {
                    return buildWidget(pageViewsList[index]);
                  },
                ),
        ),




                //
                // SingleChildScrollView(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 1,
                //       ),
                //
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 35,
                //         child: Padding(
                //           padding: EdgeInsets.symmetric(
                //               horizontal: SizeUtils.horizontalBlockSize * 3,
                //               vertical: SizeUtils.verticalBlockSize * 2),
                //           child: GridView.builder(
                //             padding: EdgeInsets.zero,
                //             physics: const ScrollPhysics(),
                //             scrollDirection: Axis.horizontal,
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2,
                //               mainAxisSpacing: 0,
                //               childAspectRatio: 1,
                //               //childAspectRatio: 0.8,
                //               crossAxisSpacing: 0,
                //             ),
                //             shrinkWrap: true,
                //             itemCount: categoryModel!.categories!.data!.length,
                //             itemBuilder: (context, index) {
                //               return GestureDetector(
                //                 onTap: () {
                //                   print("istapok");
                //                   //
                //
                //                   Get.to(const CategoryProductScreen(), arguments: {
                //                     'slug': categoryModel!
                //                         .categories!.data![index].slug,
                //                     'image': categoryModel!.categories!
                //                         .data![index].image!.original
                //                   });
                //                   //  Get.offAll(const ProductDetails());
                //
                //                   // Get.toNamed(Routes.productDetails);
                //                   //   Get.toRe(Routes.productDetails);
                //                 },
                //                 child: Column(
                //                   children: [
                //                     categoryModel!.categories!.data![index]
                //                                 .image!.original ==
                //                             null
                //                         ? Container(
                //                             height:
                //                                 SizeUtils.verticalBlockSize *
                //                                     12,
                //                             width:
                //                                 SizeUtils.horizontalBlockSize *
                //                                     25,
                //                             decoration: BoxDecoration(
                //                                 color: AppColor.supportColor,
                //                                 borderRadius:
                //                                     BorderRadius.circular(6)),
                //                           )
                //                         : ClipRRect(
                //                             borderRadius:
                //                                 BorderRadius.circular(6),
                //                             child: Image.network(
                //                                 categoryModel!
                //                                         .categories!
                //                                         .data![index]
                //                                         .image
                //                                         ?.original ??
                //                                     "",
                //                                 height: SizeUtils
                //                                         .verticalBlockSize *
                //                                     12,
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     26,
                //                                 fit: BoxFit.fill),
                //                           ),
                //                     CustomText(
                //                       name: categoryModel!
                //                           .categories!.data![index].name,
                //                       fontWeight: FontWeight.w500,
                //                       fontSize: SizeUtils.fSize_12(),
                //                     )
                //                   ],
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),

                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: SizeUtils.horizontalBlockSize * 3),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CustomText(
                      //         name: "Best Selling Products",
                      //         fontSize: SizeUtils.fSize_18(),
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       CustomText(
                      //         name: "See All",
                      //         fontSize: SizeUtils.fSize_20(),
                      //         fontWeight: FontWeight.w500,
                      //         color: AppColor.orangeColor,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   //height:280,
                      //
                      //   height: SizeUtils.verticalBlockSize * 40,
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount:
                      //         bestSellingModel?.bestSellingProducts?.length ??
                      //             0,
                      //     physics: const BouncingScrollPhysics(),
                      //     scrollDirection: Axis.horizontal,
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: SizeUtils.horizontalBlockSize * 3),
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(0.0),
                      //         child: Card(
                      //           elevation: 0,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(15.0),
                      //           ),
                      //           child: Container(
                      //             // height: 100,
                      //             //   width: SizeUtils.horizontalBlockSize*40,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(15),
                      //               color: AppColor.backGroundColor,
                      //               boxShadow: const [
                      //                 BoxShadow(
                      //                   color: Color.fromRGBO(0, 0, 0, 0.08),
                      //                   // Shadow color with opacity
                      //                   offset: Offset(0, 1),
                      //                   // X, Y offset
                      //                   blurRadius: 1,
                      //                   // Blur radius
                      //                   spreadRadius: 1, // Spread radius
                      //                 ),
                      //               ],
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Stack(
                      //                   alignment: Alignment.topRight,
                      //                   children: [
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         Get.to(const ProductDetails());
                      //                       },
                      //                       child: ClipRRect(
                      //                         borderRadius:
                      //                             const BorderRadius.only(
                      //                                 topRight:
                      //                                     Radius.circular(15),
                      //                                 topLeft:
                      //                                     Radius.circular(15)),
                      //                         child: Image.network(
                      //                             "${bestSellingModel!.bestSellingProducts![index].image!.original}",
                      //                             fit: BoxFit.fill,
                      //                             height: SizeUtils
                      //                                     .verticalBlockSize *
                      //                                 23,
                      //                             width: SizeUtils
                      //                                     .horizontalBlockSize *
                      //                                 44),
                      //                       ),
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.all(4.0),
                      //                       child: GestureDetector(
                      //                         onTap: () async {
                      //                           print(
                      //                               "popularProductModel!.popularProducts![index].inWishlist======${bestSellingModel!.bestSellingProducts![index].id}");
                      //                           print("like");
                      //
                      //                           if (token != null) {
                      //                             // popularProductModel!.popularProducts![index].inWishlist =
                      //                             // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                      //
                      //                             toggleWishListModel =
                      //                                 await graphQLService
                      //                                     .wishListToggle(
                      //                                         bestSellingModel!
                      //                                             .bestSellingProducts![
                      //                                                 index]
                      //                                             .id!,
                      //                                         token ?? "");
                      //                             print(
                      //                                 "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                      //                             inWishListModel =
                      //                                 await graphQLService
                      //                                     .inWishList(
                      //                                         bestSellingModel!
                      //                                             .bestSellingProducts![
                      //                                                 index]
                      //                                             .id!,
                      //                                         token ?? "");
                      //                             print(
                      //                                 "inWishListModelget========${inWishListModel!.inWishlist}");
                      //
                      //                             bestSellingModel!
                      //                                     .bestSellingProducts![
                      //                                         index]
                      //                                     .inWishlist =
                      //                                 toggleWishListModel!
                      //                                     .toggleWishlist;
                      //                             setState(() {});
                      //                           } else {
                      //                             Get.toNamed(
                      //                                 Routes.logInScreen);
                      //                           }
                      //
                      //                           print(
                      //                               "popularProductModel!.popularProducts![index].inWishlist======${bestSellingModel!.bestSellingProducts![index].id}");
                      //                           print(
                      //                               "popularProductModel!.popularProducts![index].inWishlist======${bestSellingModel!.bestSellingProducts![index].inWishlist}");
                      //                         },
                      //                         child: Image.asset(
                      //                           bestSellingModel!
                      //                                       .bestSellingProducts![
                      //                                           index]
                      //                                       .inWishlist ==
                      //                                   true
                      //                               ? "asset/images/like_icon.png"
                      //                               : "asset/images/favorite.png",
                      //                           //fit: BoxFit.fill,
                      //                           height: SizeUtils
                      //                                   .verticalBlockSize *
                      //                               3,
                      //                           //    width: SizeUtils.horizontalBlockSize*40
                      //                         ),
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top:
                      //                           SizeUtils.verticalBlockSize * 1,
                      //                       bottom:
                      //                           SizeUtils.verticalBlockSize *
                      //                               3),
                      //                   child: Row(
                      //                     children: [
                      //                       SizedBox(
                      //                         width: SizeUtils
                      //                                 .horizontalBlockSize *
                      //                             2,
                      //                       ),
                      //                       SizedBox(
                      //                         width: SizeUtils
                      //                                 .horizontalBlockSize *
                      //                             40,
                      //                         child: CustomText(
                      //                           maxLines: 1,
                      //                           name:
                      //                               "${bestSellingModel!.bestSellingProducts![index].name}",
                      //                           fontSize: SizeUtils.fSize_14(),
                      //                           color: AppColor.grayColor,
                      //                           fontWeight: FontWeight.w600,
                      //                           textAlign: TextAlign.start,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       width:
                      //                           SizeUtils.horizontalBlockSize *
                      //                               1,
                      //                     ),
                      //                     //const SizedBox(width: 5,),
                      //                     CustomText(
                      //                       name:
                      //                           "Rp${bestSellingModel!.bestSellingProducts![index].salePrice}",
                      //                       color: AppColor.greenColor,
                      //                       fontSize: SizeUtils.fSize_13(),
                      //                       fontWeight: FontWeight.w700,
                      //                     ),
                      //                     CustomText(
                      //                       name:
                      //                           "/ ${bestSellingModel!.bestSellingProducts![index].unit}",
                      //                       color: AppColor.grayColor,
                      //                       fontSize: SizeUtils.fSize_10(),
                      //                       fontWeight: FontWeight.w400,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: EdgeInsets.only(
                      //                       top: SizeUtils.verticalBlockSize *
                      //                           1),
                      //                   child: Row(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(
                      //                             left: 3),
                      //                         child: Container(
                      //                           width: SizeUtils
                      //                                   .horizontalBlockSize *
                      //                               16,
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               CustomText(
                      //                                 name:
                      //                                     "Rp ${popularProductModel!.popularProducts![index].price}",
                      //                                 color:
                      //                                     AppColor.greenColor,
                      //                                 fontSize:
                      //                                     SizeUtils.fSize_12(),
                      //                                 fontWeight:
                      //                                     FontWeight.w600,
                      //                               ),
                      //                               CustomText(
                      //                                 name:
                      //                                     "Rp ${popularProductModel!.popularProducts![index].maxPrice}",
                      //                                 color: AppColor
                      //                                     .grayTextColor,
                      //                                 fontSize:
                      //                                     SizeUtils.fSize_11(),
                      //                                 fontWeight:
                      //                                     FontWeight.w500,
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       const SizedBox(
                      //                         width: 5,
                      //                       ),
                      //                       " ${bestSellingModel!.bestSellingProducts![index].quantity}" !=
                      //                               "0"
                      //                           ? Padding(
                      //                               padding: const EdgeInsets
                      //                                   .symmetric(
                      //                                   horizontal: 4),
                      //                               child: Container(
                      //                                 height: SizeUtils
                      //                                         .verticalBlockSize *
                      //                                     4.3,
                      //                                 width: SizeUtils
                      //                                         .horizontalBlockSize *
                      //                                     22,
                      //                                 decoration: BoxDecoration(
                      //                                   color:
                      //                                       AppColor.greenColor,
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(6),
                      //                                 ),
                      //                                 child: Padding(
                      //                                   padding:
                      //                                       const EdgeInsets
                      //                                           .symmetric(
                      //                                           horizontal: 0),
                      //                                   child: Row(
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       children: [
                      //                                         // SizedBox(width: 4,),
                      //                                         const Icon(
                      //                                             Icons.remove,
                      //                                             color: AppColor
                      //                                                 .backGroundColor),
                      //                                         CustomText(
                      //                                           name:
                      //                                               "${bestSellingModel!.bestSellingProducts![index].quantity}",
                      //                                           color: AppColor
                      //                                               .backGroundColor,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .w500,
                      //                                           fontSize: SizeUtils
                      //                                               .fSize_14(),
                      //                                         ),
                      //                                         const Icon(
                      //                                           Icons.add,
                      //                                           color: AppColor
                      //                                               .backGroundColor,
                      //                                         ),
                      //                                       ]),
                      //                                 ),
                      //                               ),
                      //                             )
                      //                           : Padding(
                      //                               padding: const EdgeInsets
                      //                                   .symmetric(
                      //                                   horizontal: 4),
                      //                               child: Container(
                      //                                 height: SizeUtils
                      //                                         .verticalBlockSize *
                      //                                     4.3,
                      //                                 width: SizeUtils
                      //                                         .horizontalBlockSize *
                      //                                     20,
                      //                                 decoration: BoxDecoration(
                      //                                   color:
                      //                                       AppColor.greenColor,
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(6),
                      //                                 ),
                      //                                 child: Row(children: [
                      //                                   const SizedBox(
                      //                                     width: 4,
                      //                                   ),
                      //                                   const Icon(Icons.add,
                      //                                       color: AppColor
                      //                                           .backGroundColor),
                      //                                   CustomText(
                      //                                     name: "Add",
                      //                                     color: AppColor
                      //                                         .backGroundColor,
                      //                                     fontWeight:
                      //                                         FontWeight.w500,
                      //                                     fontSize: SizeUtils
                      //                                         .fSize_14(),
                      //                                   )
                      //                                 ]),
                      //                               ),
                      //                             )
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 3,
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: SizeUtils.horizontalBlockSize * 3),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CustomText(
                //               name: "Popular products",
                //               fontSize: SizeUtils.fSize_18(),
                //               fontWeight: FontWeight.w600,
                //             ),
                //             CustomText(
                //               name: "See All",
                //               fontSize: SizeUtils.fSize_20(),
                //               fontWeight: FontWeight.w500,
                //               color: AppColor.orangeColor,
                //             )
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         //height:280,
                //
                //         height: SizeUtils.verticalBlockSize * 40,
                //         child: ListView.builder(
                //           shrinkWrap: true,
                //           itemCount:
                //               popularProductModel?.popularProducts?.length ?? 0,
                //           physics: const BouncingScrollPhysics(),
                //           scrollDirection: Axis.horizontal,
                //           padding: EdgeInsets.symmetric(
                //               horizontal: SizeUtils.horizontalBlockSize * 3),
                //           itemBuilder: (context, index) {
                //             return Padding(
                //               padding: const EdgeInsets.all(0.0),
                //               child: Card(
                //                 elevation: 0,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(15.0),
                //                 ),
                //                 child: Container(
                //                   // height: 100,
                //                   //   width: SizeUtils.horizontalBlockSize*40,
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(15),
                //                     color: AppColor.backGroundColor,
                //                     boxShadow: const [
                //                       BoxShadow(
                //                         color: Color.fromRGBO(0, 0, 0, 0.08),
                //                         // Shadow color with opacity
                //                         offset: Offset(0, 1),
                //                         // X, Y offset
                //                         blurRadius: 1,
                //                         // Blur radius
                //                         spreadRadius: 1, // Spread radius
                //                       ),
                //                     ],
                //                   ),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Stack(
                //                         alignment: Alignment.topRight,
                //                         children: [
                //                           GestureDetector(
                //                             onTap: () {
                //                               Get.to(const ProductDetails());
                //                             },
                //                             child: ClipRRect(
                //                               borderRadius:
                //                                   const BorderRadius.only(
                //                                       topRight:
                //                                           Radius.circular(15),
                //                                       topLeft:
                //                                           Radius.circular(15)),
                //                               child: Image.network(
                //                                   "${popularProductModel!.popularProducts![index].image!.original}",
                //                                   fit: BoxFit.fill,
                //                                   height: SizeUtils
                //                                           .verticalBlockSize *
                //                                       23,
                //                                   width: SizeUtils
                //                                           .horizontalBlockSize *
                //                                       44),
                //                             ),
                //                           ),
                //                           Padding(
                //                             padding: const EdgeInsets.all(4.0),
                //                             child: GestureDetector(
                //                               onTap: () async {
                //                                 print(
                //                                     "popularProductModel!.popularProducts![index].inWishlist======${popularProductModel!.popularProducts![index].id}");
                //                                 print("like");
                //
                //                                 if (token != null) {
                //                                   // popularProductModel!.popularProducts![index].inWishlist =
                //                                   // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                //
                //                                   toggleWishListModel =
                //                                       await graphQLService
                //                                           .wishListToggle(
                //                                               popularProductModel!
                //                                                   .popularProducts![
                //                                                       index]
                //                                                   .id!,
                //                                               token ?? "");
                //                                   print(
                //                                       "toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                //                                   inWishListModel =
                //                                       await graphQLService.inWishList(
                //                                           popularProductModel!
                //                                               .popularProducts![
                //                                                   index]
                //                                               .id!,
                //                                           token ?? "");
                //                                   print(
                //                                       "inWishListModelget========${inWishListModel!.inWishlist}");
                //
                //                                   popularProductModel!
                //                                           .popularProducts![index]
                //                                           .inWishlist =
                //                                       toggleWishListModel!
                //                                           .toggleWishlist;
                //                                   setState(() {});
                //                                 } else {
                //                                   Get.toNamed(
                //                                       Routes.logInScreen);
                //                                 }
                //
                //                                 print(
                //                                     "popularProductModel!.popularProducts![index].inWishlist======${popularProductModel!.popularProducts![index].id}");
                //                                 print(
                //                                     "popularProductModel!.popularProducts![index].inWishlist======${popularProductModel!.popularProducts![index].inWishlist}");
                //                               },
                //                               child: Image.asset(
                //                                 popularProductModel!
                //                                             .popularProducts![
                //                                                 index]
                //                                             .inWishlist ==
                //                                         true
                //                                     ? "asset/images/like_icon.png"
                //                                     : "asset/images/favorite.png",
                //                                 //fit: BoxFit.fill,
                //                                 height: SizeUtils
                //                                         .verticalBlockSize *
                //                                     3,
                //                                 //    width: SizeUtils.horizontalBlockSize*40
                //                               ),
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets.only(
                //                             top:
                //                                 SizeUtils.verticalBlockSize * 1,
                //                             bottom:
                //                                 SizeUtils.verticalBlockSize *
                //                                     3),
                //                         child: Row(
                //                           children: [
                //                             SizedBox(
                //                               width: SizeUtils
                //                                       .horizontalBlockSize *
                //                                   2,
                //                             ),
                //                             SizedBox(
                //                               width: SizeUtils
                //                                       .horizontalBlockSize *
                //                                   40,
                //                               child: CustomText(
                //                                 maxLines: 1,
                //                                 name:
                //                                     "${popularProductModel!.popularProducts![index].name}",
                //                                 fontSize: SizeUtils.fSize_14(),
                //                                 color: AppColor.grayColor,
                //                                 fontWeight: FontWeight.w600,
                //                                 textAlign: TextAlign.start,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Row(
                //                         children: [
                //                           SizedBox(
                //                             width:
                //                                 SizeUtils.horizontalBlockSize *
                //                                     1,
                //                           ),
                //                           //const SizedBox(width: 5,),
                //                           CustomText(
                //                             name:
                //                                 "Rp${popularProductModel!.popularProducts![index].salePrice}",
                //                             color: AppColor.greenColor,
                //                             fontSize: SizeUtils.fSize_13(),
                //                             fontWeight: FontWeight.w700,
                //                           ),
                //                           CustomText(
                //                             name:
                //                                 "/ ${popularProductModel!.popularProducts![index].unit}",
                //                             color: AppColor.grayColor,
                //                             fontSize: SizeUtils.fSize_10(),
                //                             fontWeight: FontWeight.w400,
                //                           ),
                //                         ],
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets.only(
                //                             top: SizeUtils.verticalBlockSize *
                //                                 1),
                //                         child: Row(
                //                           children: [
                //                             Padding(
                //                               padding: const EdgeInsets.only(
                //                                   left: 3),
                //                               child: Container(
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     16,
                //                                 child: Column(
                //                                   crossAxisAlignment:
                //                                       CrossAxisAlignment.start,
                //                                   children: [
                //                                     CustomText(
                //                                       name:
                //                                           "Rp ${popularProductModel!.popularProducts![index].price}",
                //                                       color:
                //                                           AppColor.greenColor,
                //                                       fontSize:
                //                                           SizeUtils.fSize_12(),
                //                                       fontWeight:
                //                                           FontWeight.w600,
                //                                     ),
                //                                     CustomText(
                //                                       name:
                //                                           "Rp ${popularProductModel!.popularProducts![index].maxPrice}",
                //                                       color: AppColor
                //                                           .grayTextColor,
                //                                       fontSize:
                //                                           SizeUtils.fSize_11(),
                //                                       fontWeight:
                //                                           FontWeight.w500,
                //                                     )
                //                                   ],
                //                                 ),
                //                               ),
                //                             ),
                //                             const SizedBox(
                //                               width: 5,
                //                             ),
                //                             " ${popularProductModel!.popularProducts![index].quantity}" !=
                //                                     "0"
                //                                 ? Padding(
                //                                     padding: const EdgeInsets
                //                                         .symmetric(
                //                                         horizontal: 4),
                //                                     child: Container(
                //                                       height: SizeUtils
                //                                               .verticalBlockSize *
                //                                           4.3,
                //                                       width: SizeUtils
                //                                               .horizontalBlockSize *
                //                                           22,
                //                                       decoration: BoxDecoration(
                //                                         color:
                //                                             AppColor.greenColor,
                //                                         borderRadius:
                //                                             BorderRadius
                //                                                 .circular(6),
                //                                       ),
                //                                       child: Padding(
                //                                         padding:
                //                                             const EdgeInsets
                //                                                 .symmetric(
                //                                                 horizontal: 0),
                //                                         child: Row(
                //                                             mainAxisAlignment:
                //                                                 MainAxisAlignment
                //                                                     .spaceBetween,
                //                                             children: [
                //                                               // SizedBox(width: 4,),
                //                                               const Icon(
                //                                                   Icons.remove,
                //                                                   color: AppColor
                //                                                       .backGroundColor),
                //                                               CustomText(
                //                                                 name:
                //                                                     "${popularProductModel!.popularProducts![index].quantity}",
                //                                                 color: AppColor
                //                                                     .backGroundColor,
                //                                                 fontWeight:
                //                                                     FontWeight
                //                                                         .w500,
                //                                                 fontSize: SizeUtils
                //                                                     .fSize_14(),
                //                                               ),
                //                                               const Icon(
                //                                                 Icons.add,
                //                                                 color: AppColor
                //                                                     .backGroundColor,
                //                                               ),
                //                                             ]),
                //                                       ),
                //                                     ),
                //                                   )
                //                                 : Padding(
                //                                     padding: const EdgeInsets
                //                                         .symmetric(
                //                                         horizontal: 4),
                //                                     child: Container(
                //                                       height: SizeUtils
                //                                               .verticalBlockSize *
                //                                           4.3,
                //                                       width: SizeUtils
                //                                               .horizontalBlockSize *
                //                                           20,
                //                                       decoration: BoxDecoration(
                //                                         color:
                //                                             AppColor.greenColor,
                //                                         borderRadius:
                //                                             BorderRadius
                //                                                 .circular(6),
                //                                       ),
                //                                       child: Row(children: [
                //                                         const SizedBox(
                //                                           width: 4,
                //                                         ),
                //                                         const Icon(Icons.add,
                //                                             color: AppColor
                //                                                 .backGroundColor),
                //                                         CustomText(
                //                                           name: "Add",
                //                                           color: AppColor
                //                                               .backGroundColor,
                //                                           fontWeight:
                //                                               FontWeight.w500,
                //                                           fontSize: SizeUtils
                //                                               .fSize_14(),
                //                                         )
                //                                       ]),
                //                                     ),
                //                                   )
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 3,
                //       ),
                //
                //       Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: SizeUtils.horizontalBlockSize * 3),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CustomText(
                //               name: "People also buy This",
                //               fontSize: SizeUtils.fSize_18(),
                //               fontWeight: FontWeight.w600,
                //             ),
                //             CustomText(
                //               name: "See All",
                //               fontSize: SizeUtils.fSize_20(),
                //               fontWeight: FontWeight.w500,
                //               color: AppColor.orangeColor,
                //             )
                //           ],
                //         ),
                //       ),
                //       Align(
                //         alignment: Alignment.topLeft,
                //         child: SizedBox(
                //           //height:280,
                //           height: SizeUtils.verticalBlockSize * 40,
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             itemCount: peopleBuyModel?.types?.length,
                //             physics: const BouncingScrollPhysics(),
                //             scrollDirection: Axis.horizontal,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: SizeUtils.horizontalBlockSize * 3),
                //             itemBuilder: (context, index) {
                //               return Padding(
                //                 padding: const EdgeInsets.all(0.0),
                //                 child: Card(
                //                   elevation: 0,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(15.0),
                //                   ),
                //                   child: Container(
                //                     // height: 100,
                //                     //   width: SizeUtils.horizontalBlockSize*40,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(15),
                //                       color: AppColor.backGroundColor,
                //                       boxShadow: const [
                //                         BoxShadow(
                //                           color: Color.fromRGBO(0, 0, 0, 0.08),
                //                           // Shadow color with opacity
                //                           offset: Offset(0, 1),
                //                           // X, Y offset
                //                           blurRadius: 1,
                //                           // Blur radius
                //                           spreadRadius: 1, // Spread radius
                //                         ),
                //                       ],
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Stack(
                //                           alignment: Alignment.topRight,
                //                           children: [
                //                             GestureDetector(
                //                               onTap: () {
                //                                 Get.to(const ProductDetails());
                //                               },
                //                               child: ClipRRect(
                //                                 borderRadius:
                //                                     const BorderRadius.only(
                //                                         topRight:
                //                                             Radius.circular(15),
                //                                         topLeft:
                //                                             Radius.circular(
                //                                                 15)),
                //                                 child: Image.network(
                //                                     "${peopleBuyModel?.types![0].settings?.handpickedProducts?.products?[index].image?.original}",
                //                                     fit: BoxFit.fill,
                //                                     height: SizeUtils
                //                                             .verticalBlockSize *
                //                                         23,
                //                                     width: SizeUtils
                //                                             .horizontalBlockSize *
                //                                         44),
                //                               ),
                //                             ),
                //                             // Padding(
                //                             //   padding:
                //                             //   const EdgeInsets.all(4.0),
                //                             //   child: GestureDetector(onTap: () async {
                //                             //
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                //                             //     print("like");
                //                             //
                //                             //
                //                             //     if(token != null)
                //                             //     {
                //                             //
                //                             //       // popularProductModel!.popularProducts![index].inWishlist =
                //                             //       // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                //                             //
                //                             //       toggleWishListModel =await graphQLService.wishListToggle(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                //                             //       print("toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                //                             //       inWishListModel=await graphQLService.inWishList(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                //                             //       print("inWishListModelget========${inWishListModel!.inWishlist}");
                //                             //
                //                             //
                //                             //
                //                             //       bestSellingModel!.bestSellingProducts![index].inWishlist=toggleWishListModel!.toggleWishlist;
                //                             //       setState(() {
                //                             //       });
                //                             //
                //                             //     }
                //                             //     else
                //                             //     {
                //                             //
                //                             //       Get.toNamed(Routes.logInScreen);
                //                             //
                //                             //     }
                //                             //
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist}");
                //                             //
                //                             //
                //                             //
                //                             //   },
                //                             //     child: Image.asset(
                //                             //       peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist==true ?"asset/images/like_icon.png": "asset/images/favorite.png",
                //                             //       //fit: BoxFit.fill,
                //                             //       height: SizeUtils
                //                             //           .verticalBlockSize *
                //                             //           3,
                //                             //       //    width: SizeUtils.horizontalBlockSize*40
                //                             //     ),
                //                             //   ),
                //                             // )
                //                           ],
                //                         ),
                //                         Padding(
                //                           padding: EdgeInsets.only(
                //                               top: SizeUtils.verticalBlockSize *
                //                                   1,
                //                               bottom:
                //                                   SizeUtils.verticalBlockSize *
                //                                       3),
                //                           child: Row(
                //                             children: [
                //                               SizedBox(
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     2,
                //                               ),
                //                               SizedBox(
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     40,
                //                                 child: CustomText(
                //                                   maxLines: 1,
                //                                   name:
                //                                       "${peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].name}",
                //                                   fontSize:
                //                                       SizeUtils.fSize_14(),
                //                                   color: AppColor.grayColor,
                //                                   fontWeight: FontWeight.w600,
                //                                   textAlign: TextAlign.start,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                         Row(
                //                           children: [
                //                             SizedBox(
                //                               width: SizeUtils
                //                                       .horizontalBlockSize *
                //                                   1,
                //                             ),
                //                             //const SizedBox(width: 5,),
                //                             CustomText(
                //                               name:
                //                                   "Rp${peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].salePrice}",
                //                               color: AppColor.greenColor,
                //                               fontSize: SizeUtils.fSize_13(),
                //                               fontWeight: FontWeight.w700,
                //                             ),
                //                             CustomText(
                //                               name:
                //                                   "/ ${peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].unit}",
                //                               color: AppColor.grayColor,
                //                               fontSize: SizeUtils.fSize_10(),
                //                               fontWeight: FontWeight.w400,
                //                             ),
                //                           ],
                //                         ),
                //                         Padding(
                //                           padding: EdgeInsets.only(
                //                               top: SizeUtils.verticalBlockSize *
                //                                   1),
                //                           child: Row(
                //                             children: [
                //                               Padding(
                //                                 padding: const EdgeInsets.only(
                //                                     left: 3),
                //                                 child: Container(
                //                                   width: SizeUtils
                //                                           .horizontalBlockSize *
                //                                       16,
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     children: [
                //                                       CustomText(
                //                                         name:
                //                                             "Rp ${popularProductModel?.popularProducts?[index].price ?? 0}",
                //                                         color:
                //                                             AppColor.greenColor,
                //                                         fontSize: SizeUtils
                //                                             .fSize_12(),
                //                                         fontWeight:
                //                                             FontWeight.w600,
                //                                       ),
                //                                       CustomText(
                //                                         name:
                //                                             "Rp ${popularProductModel?.popularProducts?[index].maxPrice ?? 0}",
                //                                         color: AppColor
                //                                             .grayTextColor,
                //                                         fontSize: SizeUtils
                //                                             .fSize_11(),
                //                                         fontWeight:
                //                                             FontWeight.w500,
                //                                       )
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ),
                //                               const SizedBox(
                //                                 width: 5,
                //                               ),
                //                               " ${peopleBuyModel?.types?[0].settings?.handpickedProducts?.products?[index].quantity}" !=
                //                                       "0"
                //                                   ? Padding(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal: 4),
                //                                       child: Container(
                //                                         height: SizeUtils
                //                                                 .verticalBlockSize *
                //                                             4.3,
                //                                         width: SizeUtils
                //                                                 .horizontalBlockSize *
                //                                             22,
                //                                         decoration:
                //                                             BoxDecoration(
                //                                           color: AppColor
                //                                               .greenColor,
                //                                           borderRadius:
                //                                               BorderRadius
                //                                                   .circular(6),
                //                                         ),
                //                                         child: Padding(
                //                                           padding:
                //                                               const EdgeInsets
                //                                                   .symmetric(
                //                                                   horizontal:
                //                                                       0),
                //                                           child: Row(
                //                                               mainAxisAlignment:
                //                                                   MainAxisAlignment
                //                                                       .spaceBetween,
                //                                               children: [
                //                                                 // SizedBox(width: 4,),
                //                                                 const Icon(
                //                                                     Icons
                //                                                         .remove,
                //                                                     color: AppColor
                //                                                         .backGroundColor),
                //                                                 CustomText(
                //                                                   name:
                //                                                       "${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].quantity}",
                //                                                   color: AppColor
                //                                                       .backGroundColor,
                //                                                   fontWeight:
                //                                                       FontWeight
                //                                                           .w500,
                //                                                   fontSize:
                //                                                       SizeUtils
                //                                                           .fSize_14(),
                //                                                 ),
                //                                                 const Icon(
                //                                                   Icons.add,
                //                                                   color: AppColor
                //                                                       .backGroundColor,
                //                                                 ),
                //                                               ]),
                //                                         ),
                //                                       ),
                //                                     )
                //                                   : Padding(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal: 4),
                //                                       child: Container(
                //                                         height: SizeUtils
                //                                                 .verticalBlockSize *
                //                                             4.3,
                //                                         width: SizeUtils
                //                                                 .horizontalBlockSize *
                //                                             20,
                //                                         decoration:
                //                                             BoxDecoration(
                //                                           color: AppColor
                //                                               .greenColor,
                //                                           borderRadius:
                //                                               BorderRadius
                //                                                   .circular(6),
                //                                         ),
                //                                         child: Row(children: [
                //                                           const SizedBox(
                //                                             width: 4,
                //                                           ),
                //                                           const Icon(Icons.add,
                //                                               color: AppColor
                //                                                   .backGroundColor),
                //                                           CustomText(
                //                                             name: "Add",
                //                                             color: AppColor
                //                                                 .backGroundColor,
                //                                             fontWeight:
                //                                                 FontWeight.w500,
                //                                             fontSize: SizeUtils
                //                                                 .fSize_14(),
                //                                           )
                //                                         ]),
                //                                       ),
                //                                     )
                //                             ],
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 3,
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: SizeUtils.horizontalBlockSize * 3),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CustomText(
                //               name: "New Product",
                //               fontSize: SizeUtils.fSize_18(),
                //               fontWeight: FontWeight.w600,
                //             ),
                //             CustomText(
                //               name: "See All",
                //               fontSize: SizeUtils.fSize_20(),
                //               fontWeight: FontWeight.w500,
                //               color: AppColor.orangeColor,
                //             )
                //           ],
                //         ),
                //       ),
                //       Align(
                //         alignment: Alignment.topLeft,
                //         child: SizedBox(
                //           //height:280,
                //           height: SizeUtils.verticalBlockSize * 40,
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             itemCount:
                //                 newProductModel?.products?.data?.length ?? 0,
                //             physics: const BouncingScrollPhysics(),
                //             scrollDirection: Axis.horizontal,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: SizeUtils.horizontalBlockSize * 3),
                //             itemBuilder: (context, index) {
                //               return Padding(
                //                 padding: const EdgeInsets.all(0.0),
                //                 child: Card(
                //                   elevation: 0,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(15.0),
                //                   ),
                //                   child: Container(
                //                     // height: 100,
                //                     //   width: SizeUtils.horizontalBlockSize*40,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(15),
                //                       color: AppColor.backGroundColor,
                //                       boxShadow: const [
                //                         BoxShadow(
                //                           color: Color.fromRGBO(0, 0, 0, 0.08),
                //                           // Shadow color with opacity
                //                           offset: Offset(0, 1),
                //                           // X, Y offset
                //                           blurRadius: 1,
                //                           // Blur radius
                //                           spreadRadius: 1, // Spread radius
                //                         ),
                //                       ],
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Stack(
                //                           alignment: Alignment.topRight,
                //                           children: [
                //                             GestureDetector(
                //                               onTap: () {
                //                                 Get.to(const ProductDetails());
                //                               },
                //                               child: ClipRRect(
                //                                 borderRadius:
                //                                     const BorderRadius.only(
                //                                         topRight:
                //                                             Radius.circular(15),
                //                                         topLeft:
                //                                             Radius.circular(
                //                                                 15)),
                //                                 child: Image.network(
                //                                     "${newProductModel!.products!.data![index].image!.original}",
                //                                     fit: BoxFit.fill,
                //                                     height: SizeUtils
                //                                             .verticalBlockSize *
                //                                         23,
                //                                     width: SizeUtils
                //                                             .horizontalBlockSize *
                //                                         44),
                //                               ),
                //                             ),
                //                             // Padding(
                //                             //   padding:
                //                             //   const EdgeInsets.all(4.0),
                //                             //   child: GestureDetector(onTap: () async {
                //                             //
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                //                             //     print("like");
                //                             //
                //                             //
                //                             //     if(token != null)
                //                             //     {
                //                             //
                //                             //       // popularProductModel!.popularProducts![index].inWishlist =
                //                             //       // !(popularProductModel!.popularProducts![index].inWishlist ?? false);
                //                             //
                //                             //       toggleWishListModel =await graphQLService.wishListToggle(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                //                             //       print("toggleWishListModelget========${toggleWishListModel!.toggleWishlist}");
                //                             //       inWishListModel=await graphQLService.inWishList(bestSellingModel!.bestSellingProducts![index].id!,token??"");
                //                             //       print("inWishListModelget========${inWishListModel!.inWishlist}");
                //                             //
                //                             //
                //                             //
                //                             //       bestSellingModel!.bestSellingProducts![index].inWishlist=toggleWishListModel!.toggleWishlist;
                //                             //       setState(() {
                //                             //       });
                //                             //
                //                             //     }
                //                             //     else
                //                             //     {
                //                             //
                //                             //       Get.toNamed(Routes.logInScreen);
                //                             //
                //                             //     }
                //                             //
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].id}");
                //                             //     print("popularProductModel!.popularProducts![index].inWishlist======${peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist}");
                //                             //
                //                             //
                //                             //
                //                             //   },
                //                             //     child: Image.asset(
                //                             //       peopleBuyModel!.types![0].settings!.handpickedProducts!.products![index].inWishlist==true ?"asset/images/like_icon.png": "asset/images/favorite.png",
                //                             //       //fit: BoxFit.fill,
                //                             //       height: SizeUtils
                //                             //           .verticalBlockSize *
                //                             //           3,
                //                             //       //    width: SizeUtils.horizontalBlockSize*40
                //                             //     ),
                //                             //   ),
                //                             // )
                //                           ],
                //                         ),
                //                         Padding(
                //                           padding: EdgeInsets.only(
                //                               top: SizeUtils.verticalBlockSize *
                //                                   1,
                //                               bottom:
                //                                   SizeUtils.verticalBlockSize *
                //                                       3),
                //                           child: Row(
                //                             children: [
                //                               SizedBox(
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     2,
                //                               ),
                //                               SizedBox(
                //                                 width: SizeUtils
                //                                         .horizontalBlockSize *
                //                                     40,
                //                                 child: CustomText(
                //                                   maxLines: 1,
                //                                   name:
                //                                       "${newProductModel!.products!.data![index].name}",
                //                                   fontSize:
                //                                       SizeUtils.fSize_14(),
                //                                   color: AppColor.grayColor,
                //                                   fontWeight: FontWeight.w600,
                //                                   textAlign: TextAlign.start,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                         Row(
                //                           children: [
                //                             SizedBox(
                //                               width: SizeUtils
                //                                       .horizontalBlockSize *
                //                                   1,
                //                             ),
                //                             //const SizedBox(width: 5,),
                //                             CustomText(
                //                               name:
                //                                   "Rp${newProductModel!.products!.data![index].salePrice}",
                //                               color: AppColor.greenColor,
                //                               fontSize: SizeUtils.fSize_13(),
                //                               fontWeight: FontWeight.w700,
                //                             ),
                //                             CustomText(
                //                               name:
                //                                   "/ ${newProductModel!.products!.data![index].unit}",
                //                               color: AppColor.grayColor,
                //                               fontSize: SizeUtils.fSize_10(),
                //                               fontWeight: FontWeight.w400,
                //                             ),
                //                           ],
                //                         ),
                //                         Padding(
                //                           padding: EdgeInsets.only(
                //                               top: SizeUtils.verticalBlockSize *
                //                                   1),
                //                           child: Row(
                //                             children: [
                //                               Padding(
                //                                 padding: const EdgeInsets.only(
                //                                     left: 3),
                //                                 child: Container(
                //                                   width: SizeUtils
                //                                           .horizontalBlockSize *
                //                                       16,
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     children: [
                //                                       CustomText(
                //                                         name:
                //                                             "Rp ${newProductModel!.products!.data![index].price}",
                //                                         color:
                //                                             AppColor.greenColor,
                //                                         fontSize: SizeUtils
                //                                             .fSize_12(),
                //                                         fontWeight:
                //                                             FontWeight.w600,
                //                                       ),
                //                                       CustomText(
                //                                         name:
                //                                             "Rp ${newProductModel!.products!.data![index].maxPrice}",
                //                                         color: AppColor
                //                                             .grayTextColor,
                //                                         fontSize: SizeUtils
                //                                             .fSize_11(),
                //                                         fontWeight:
                //                                             FontWeight.w500,
                //                                       )
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ),
                //                               const SizedBox(
                //                                 width: 5,
                //                               ),
                //                               " ${newProductModel!.products!.data![index].quantity}" !=
                //                                       "0"
                //                                   ? Padding(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal: 4),
                //                                       child: Container(
                //                                         height: SizeUtils
                //                                                 .verticalBlockSize *
                //                                             4.3,
                //                                         width: SizeUtils
                //                                                 .horizontalBlockSize *
                //                                             22,
                //                                         decoration:
                //                                             BoxDecoration(
                //                                           color: AppColor
                //                                               .greenColor,
                //                                           borderRadius:
                //                                               BorderRadius
                //                                                   .circular(6),
                //                                         ),
                //                                         child: Padding(
                //                                           padding:
                //                                               const EdgeInsets
                //                                                   .symmetric(
                //                                                   horizontal:
                //                                                       0),
                //                                           child: Row(
                //                                               mainAxisAlignment:
                //                                                   MainAxisAlignment
                //                                                       .spaceBetween,
                //                                               children: [
                //                                                 // SizedBox(width: 4,),
                //                                                 const Icon(
                //                                                     Icons
                //                                                         .remove,
                //                                                     color: AppColor
                //                                                         .backGroundColor),
                //                                                 CustomText(
                //                                                   name:
                //                                                       "${newProductModel!.products!.data![index].quantity}",
                //                                                   color: AppColor
                //                                                       .backGroundColor,
                //                                                   fontWeight:
                //                                                       FontWeight
                //                                                           .w500,
                //                                                   fontSize:
                //                                                       SizeUtils
                //                                                           .fSize_14(),
                //                                                 ),
                //                                                 const Icon(
                //                                                   Icons.add,
                //                                                   color: AppColor
                //                                                       .backGroundColor,
                //                                                 ),
                //                                               ]),
                //                                         ),
                //                                       ),
                //                                     )
                //                                   : Padding(
                //                                       padding: const EdgeInsets
                //                                           .symmetric(
                //                                           horizontal: 4),
                //                                       child: Container(
                //                                         height: SizeUtils
                //                                                 .verticalBlockSize *
                //                                             4.3,
                //                                         width: SizeUtils
                //                                                 .horizontalBlockSize *
                //                                             20,
                //                                         decoration:
                //                                             BoxDecoration(
                //                                           color: AppColor
                //                                               .greenColor,
                //                                           borderRadius:
                //                                               BorderRadius
                //                                                   .circular(6),
                //                                         ),
                //                                         child: Row(children: [
                //                                           const SizedBox(
                //                                             width: 4,
                //                                           ),
                //                                           const Icon(Icons.add,
                //                                               color: AppColor
                //                                                   .backGroundColor),
                //                                           CustomText(
                //                                             name: "Add",
                //                                             color: AppColor
                //                                                 .backGroundColor,
                //                                             fontWeight:
                //                                                 FontWeight.w500,
                //                                             fontSize: SizeUtils
                //                                                 .fSize_14(),
                //                                           )
                //                                         ]),
                //                                       ),
                //                                     )
                //                             ],
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 3,
                //       ),
                //       ListView.builder(
                //         shrinkWrap: true,
                //         itemCount: customPopularModel
                //                 ?.types?[0].settings?.customeproduct?.length ??
                //             0,
                //         physics: const BouncingScrollPhysics(),
                //         itemBuilder: (context, index) {
                //           return Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal:
                //                         SizeUtils.horizontalBlockSize * 3),
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     CustomText(
                //                       name:
                //                           "${customPopularModel!.types![0].settings!.customeproduct![index].title}",
                //                       fontSize: SizeUtils.fSize_18(),
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                     CustomText(
                //                       name: "See All",
                //                       fontSize: SizeUtils.fSize_20(),
                //                       fontWeight: FontWeight.w500,
                //                       color: AppColor.orangeColor,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(
                //                 //height:280,
                //
                //                 height: SizeUtils.verticalBlockSize * 40,
                //                 child: ListView.builder(
                //                   shrinkWrap: true,
                //                   itemCount: customPopularModel!
                //                       .types![0]
                //                       .settings!
                //                       .customeproduct![index]
                //                       .products!
                //                       .length,
                //
                //                   //
                //                   // customPopularModel!
                //                   //     .type!
                //                   //     .settings!
                //                   //     .customeproduct![index]
                //                   //     .products!
                //                   //     .length,
                //                   physics: const BouncingScrollPhysics(),
                //                   scrollDirection: Axis.horizontal,
                //                   padding: EdgeInsets.symmetric(
                //                       horizontal:
                //                           SizeUtils.horizontalBlockSize * 3),
                //                   itemBuilder: (context, indexProduct) {
                //                     return Padding(
                //                       padding: const EdgeInsets.all(0.0),
                //                       child: Card(
                //                         elevation: 0,
                //                         shape: RoundedRectangleBorder(
                //                           borderRadius:
                //                               BorderRadius.circular(15.0),
                //                         ),
                //                         child: Container(
                //                           // height: 100,
                //                           //   width: SizeUtils.horizontalBlockSize*40,
                //                           decoration: BoxDecoration(
                //                             borderRadius:
                //                                 BorderRadius.circular(15),
                //                             color: AppColor.backGroundColor,
                //                             boxShadow: const [
                //                               BoxShadow(
                //                                 color: Color.fromRGBO(
                //                                     0, 0, 0, 0.08),
                //                                 // Shadow color with opacity
                //                                 offset: Offset(0, 1),
                //                                 // X, Y offset
                //                                 blurRadius: 1,
                //                                 // Blur radius
                //                                 spreadRadius:
                //                                     1, // Spread radius
                //                               ),
                //                             ],
                //                           ),
                //                           child: Column(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.start,
                //                             children: [
                //                               Stack(
                //                                 alignment: Alignment.topRight,
                //                                 children: [
                //                                   ClipRRect(
                //                                     borderRadius:
                //                                         const BorderRadius.only(
                //                                             topLeft: Radius
                //                                                 .circular(15),
                //                                             topRight:
                //                                                 Radius.circular(
                //                                                     15)),
                //                                     child: Image.network(
                //                                         "${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].image?.original ?? ""}",
                //                                         fit: BoxFit.fill,
                //                                         height: SizeUtils
                //                                                 .verticalBlockSize *
                //                                             23,
                //                                         width: SizeUtils
                //                                                 .horizontalBlockSize *
                //                                             43),
                //                                   ),
                //                                 ],
                //                               ),
                //                               Padding(
                //                                 padding: EdgeInsets.only(
                //                                     top: SizeUtils
                //                                             .verticalBlockSize *
                //                                         1,
                //                                     bottom: SizeUtils
                //                                             .verticalBlockSize *
                //                                         3),
                //                                 child: Row(
                //                                   children: [
                //                                     SizedBox(
                //                                       width: SizeUtils
                //                                               .horizontalBlockSize *
                //                                           2,
                //                                     ),
                //                                     CustomText(
                //                                       name:
                //                                           "${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].name}",
                //                                       fontSize:
                //                                           SizeUtils.fSize_14(),
                //                                       color: AppColor.grayColor,
                //                                       fontWeight:
                //                                           FontWeight.w600,
                //                                       textAlign:
                //                                           TextAlign.start,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               Row(
                //                                 children: [
                //                                   SizedBox(
                //                                     width: SizeUtils
                //                                             .horizontalBlockSize *
                //                                         1,
                //                                   ),
                //                                   //const SizedBox(width: 5,),
                //                                   CustomText(
                //                                     name:
                //                                         "Rp${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].salePrice}",
                //                                     color: AppColor.greenColor,
                //                                     fontSize:
                //                                         SizeUtils.fSize_13(),
                //                                     fontWeight: FontWeight.w700,
                //                                   ),
                //                                   CustomText(
                //                                     name:
                //                                         "/ ${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].unit}",
                //                                     color: AppColor.grayColor,
                //                                     fontSize:
                //                                         SizeUtils.fSize_10(),
                //                                     fontWeight: FontWeight.w400,
                //                                   ),
                //                                 ],
                //                               ),
                //                               Padding(
                //                                 padding: EdgeInsets.only(
                //                                     top: SizeUtils
                //                                             .verticalBlockSize *
                //                                         1),
                //                                 child: Row(
                //                                   children: [
                //                                     Padding(
                //                                       padding:
                //                                           const EdgeInsets.only(
                //                                               left: 3),
                //                                       child: Column(
                //                                         crossAxisAlignment:
                //                                             CrossAxisAlignment
                //                                                 .start,
                //                                         children: [
                //                                           CustomText(
                //                                             name:
                //                                                 "Rp ${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].price}",
                //                                             color: AppColor
                //                                                 .greenColor,
                //                                             fontSize: SizeUtils
                //                                                 .fSize_12(),
                //                                             fontWeight:
                //                                                 FontWeight.w600,
                //                                           ),
                //                                           CustomText(
                //                                             name:
                //                                                 "Rp ${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].maxPrice}",
                //                                             color: AppColor
                //                                                 .grayTextColor,
                //                                             fontSize: SizeUtils
                //                                                 .fSize_11(),
                //                                             fontWeight:
                //                                                 FontWeight.w500,
                //                                           )
                //                                         ],
                //                                       ),
                //                                     ),
                //                                     const SizedBox(
                //                                       width: 5,
                //                                     ),
                //                                     customPopularModel!
                //                                                 .types![0]
                //                                                 .settings!
                //                                                 .customeproduct![
                //                                                     index]
                //                                                 .products![
                //                                                     indexProduct]
                //                                                 .quantity !=
                //                                             1
                //                                         ? GestureDetector(
                //                                             onTap: () {
                //                                               getBottomSheet(
                //                                                   context);
                //                                             },
                //                                             child: Padding(
                //                                               padding:
                //                                                   const EdgeInsets
                //                                                       .symmetric(
                //                                                       horizontal:
                //                                                           4),
                //                                               child: Container(
                //                                                 height: SizeUtils
                //                                                         .verticalBlockSize *
                //                                                     4.3,
                //                                                 width: SizeUtils
                //                                                         .horizontalBlockSize *
                //                                                     21,
                //                                                 decoration:
                //                                                     BoxDecoration(
                //                                                   color: AppColor
                //                                                       .greenColor,
                //                                                   borderRadius:
                //                                                       BorderRadius
                //                                                           .circular(
                //                                                               6),
                //                                                 ),
                //                                                 child: Padding(
                //                                                   padding: const EdgeInsets
                //                                                       .symmetric(
                //                                                       horizontal:
                //                                                           4),
                //                                                   child: Row(
                //                                                       mainAxisAlignment:
                //                                                           MainAxisAlignment
                //                                                               .spaceBetween,
                //                                                       children: [
                //                                                         // SizedBox(width: 4,),
                //                                                         const Icon(
                //                                                             Icons
                //                                                                 .remove,
                //                                                             color:
                //                                                                 AppColor.backGroundColor),
                //                                                         CustomText(
                //                                                           name:
                //                                                               "${customPopularModel!.types![0].settings!.customeproduct![index].products![indexProduct].quantity}",
                //                                                           color:
                //                                                               AppColor.backGroundColor,
                //                                                           fontWeight:
                //                                                               FontWeight.w500,
                //                                                           fontSize:
                //                                                               SizeUtils.fSize_14(),
                //                                                         ),
                //                                                         const Icon(
                //                                                             Icons
                //                                                                 .add,
                //                                                             color:
                //                                                                 AppColor.backGroundColor),
                //                                                       ]),
                //                                                 ),
                //                                               ),
                //                                             ),
                //                                           )
                //                                         : Padding(
                //                                             padding:
                //                                                 const EdgeInsets
                //                                                     .symmetric(
                //                                                     horizontal:
                //                                                         4),
                //                                             child:
                //                                                 GestureDetector(
                //                                               onTap: () {
                //                                                 getBottomSheet(
                //                                                     context);
                //                                               },
                //                                               child: Container(
                //                                                 height: SizeUtils
                //                                                         .verticalBlockSize *
                //                                                     4.3,
                //                                                 width: SizeUtils
                //                                                         .horizontalBlockSize *
                //                                                     20,
                //                                                 decoration:
                //                                                     BoxDecoration(
                //                                                   color: AppColor
                //                                                       .greenColor,
                //                                                   borderRadius:
                //                                                       BorderRadius
                //                                                           .circular(
                //                                                               6),
                //                                                 ),
                //                                                 child: Row(
                //                                                     children: [
                //                                                       const SizedBox(
                //                                                         width:
                //                                                             4,
                //                                                       ),
                //                                                       const Icon(
                //                                                           Icons
                //                                                               .add,
                //                                                           color:
                //                                                               AppColor.backGroundColor),
                //                                                       CustomText(
                //                                                         name:
                //                                                             "Add",
                //                                                         color: AppColor
                //                                                             .backGroundColor,
                //                                                         fontWeight:
                //                                                             FontWeight.w500,
                //                                                         fontSize:
                //                                                             SizeUtils.fSize_14(),
                //                                                       )
                //                                                     ]),
                //                                               ),
                //                                             ),
                //                                           )
                //                                   ],
                //                                 ),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: SizeUtils.verticalBlockSize * 2,
                //               )
                //             ],
                //           );
                //         },
                //       ),
                //
                //       // ListView.builder(
                //       //   shrinkWrap: true,
                //       //   physics: const BouncingScrollPhysics(),
                //       //   scrollDirection: Axis.vertical,
                //       //   itemCount: customPopularModel!.types!.length,
                //       //       //.type!.settings!.customeproduct!.length,
                //       //   itemBuilder: (context, index) {
                //       //     return Column(
                //       //       children: [
                //       //         Padding(
                //       //           padding: EdgeInsets.symmetric(
                //       //               horizontal:
                //       //                   SizeUtils.horizontalBlockSize * 3),
                //       //           child: Row(
                //       //             mainAxisAlignment:
                //       //                 MainAxisAlignment.spaceBetween,
                //       //             children: [
                //       //               CustomText(
                //       //                 name:
                //       //                     "${customPopularModel!.types![index].settings!.customeproduct![index].title}",
                //       //                 fontSize: SizeUtils.fSize_18(),
                //       //                 fontWeight: FontWeight.w600,
                //       //               ),
                //       //               CustomText(
                //       //                 name: "See All",
                //       //                 fontSize: SizeUtils.fSize_20(),
                //       //                 fontWeight: FontWeight.w500,
                //       //                 color: AppColor.orangeColor,
                //       //               ),
                //       //             ],
                //       //           ),
                //       //         ),
                //       //
                //       //       ],
                //       //     );
                //       //   },
                //       // ),
                //
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 3,
                //       ),
                //       isBanner
                //           ? const Center(child: CircularProgressIndicator())
                //           : CarouselSlider.builder(
                //               options: CarouselOptions(
                //                   autoPlay: true,
                //                   onPageChanged: (index, reason) {
                //                     // setState(() {
                //                     //   selectindex = index;
                //                     // });
                //                   },
                //                   height: SizeUtils.verticalBlockSize * 25,
                //                   viewportFraction: 0.99,
                //                   initialPage: 0,
                //                   aspectRatio: 2 / 4.2),
                //               itemBuilder: (BuildContext context, int index,
                //                   int realIndex) {
                //                 return ClipRRect(
                //                   borderRadius: BorderRadius.circular(0),
                //                   child: Image.network(
                //                       "${bottomBannerModel!.types![0].settings!.bottomslider![index].original}",
                //                       width: SizeUtils.horizontalBlockSize * 94,
                //                       fit: BoxFit.fill),
                //                 );
                //               },
                //               itemCount: bottomBannerModel!
                //                   .types![0].settings!.bottomslider!.length),
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 1,
                //       ),
                //       shopList == null || shopList?.length == 0
                //           ? const SizedBox()
                //           : Padding(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal:
                //                       SizeUtils.horizontalBlockSize * 3),
                //               child: Align(
                //                 alignment: Alignment.topLeft,
                //                 child: CustomText(
                //                     name: "faster Deliver Your Nearest stores",
                //                     color: AppColor.blackNeutralColor,
                //                     fontSize: SizeUtils.fSize_16(),
                //                     fontWeight: FontWeight.w700),
                //               )),
                //       shopList == null || shopList?.length == 0
                //           ? const SizedBox()
                //           : SizedBox(
                //               height: SizeUtils.verticalBlockSize * 3,
                //             ),
                //
                //       shopList == null || shopList?.length == 0
                //           ? const SizedBox()
                //           : Align(
                //               alignment: Alignment.topLeft,
                //               child: SizedBox(
                //                 height: SizeUtils.verticalBlockSize * 30,
                //                 child: Padding(
                //                   padding: EdgeInsets.symmetric(
                //                       horizontal:
                //                           SizeUtils.horizontalBlockSize * 3),
                //                   child: ListView.builder(
                //                     itemCount: shopList?.length,
                //                     shrinkWrap: true,
                //                     physics: const BouncingScrollPhysics(),
                //                     scrollDirection: Axis.horizontal,
                //                     itemBuilder: (context, index) {
                //                       return Row(
                //                         children: [
                //                           GestureDetector(
                //                             onTap: () {
                //                               // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //                               //   return FastestStore();
                //                               // },));
                //                               Get.to(const FastestStore());
                //                               // Get.offAll(const FastestStore());
                //                             },
                //                             child: Container(
                //                               // height:
                //                               //     SizeUtils.verticalBlockSize *
                //                               //         12,
                //                               // width:
                //                               //     SizeUtils.horizontalBlockSize *
                //                               //         29,
                //                               decoration: BoxDecoration(
                //                                 borderRadius:
                //                                     BorderRadius.circular(15),
                //                                 color: AppColor.backGroundColor,
                //                                 boxShadow: const [
                //                                   BoxShadow(
                //                                     color: Color.fromRGBO(
                //                                         0, 0, 0, 0.08),
                //                                     // Shadow color with opacity
                //                                     offset: Offset(0, 1),
                //                                     // X, Y offset
                //                                     blurRadius: 1,
                //                                     // Blur radius
                //                                     spreadRadius:
                //                                         1, // Spread radius
                //                                   ),
                //                                 ],
                //                               ),
                //                               child: Column(children: [
                //                                 ClipRRect(
                //                                   borderRadius:
                //                                       const BorderRadius.only(
                //                                           topLeft:
                //                                               Radius.circular(
                //                                                   15),
                //                                           topRight:
                //                                               Radius.circular(
                //                                                   15)),
                //                                   child: Image.network(
                //                                       "${shopList![index].coverImage!.original}",
                //                                       fit: BoxFit.fill,
                //                                       height: SizeUtils
                //                                               .verticalBlockSize *
                //                                           15,
                //                                       width: SizeUtils
                //                                               .horizontalBlockSize *
                //                                           43),
                //                                 ),
                //                                 SizedBox(
                //                                   height: SizeUtils
                //                                           .verticalBlockSize *
                //                                       1,
                //                                 ),
                //                                 CustomText(
                //                                     name:
                //                                         "${shopList![index].name}",
                //                                     color: AppColor
                //                                         .blackNeutralColor,
                //                                     fontSize:
                //                                         SizeUtils.fSize_14(),
                //                                     fontWeight:
                //                                         FontWeight.w600),
                //                                 Container(
                //                                   width: SizeUtils
                //                                           .horizontalBlockSize *
                //                                       43,
                //                                   child: Center(
                //                                     child: CustomText(
                //                                       maxLines: 2,
                //                                       name:
                //                                           "${shopList![index].address!.streetAddress},${shopList![index].address!.city},\n${shopList![index].address!.zip},${shopList![index].address!.state},${shopList![index].address!.country}",
                //                                       color: AppColor.grayColor,
                //                                       fontSize:
                //                                           SizeUtils.fSize_12(),
                //                                       fontWeight:
                //                                           FontWeight.w400,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 SizedBox(
                //                                   height: SizeUtils
                //                                           .verticalBlockSize *
                //                                       1,
                //                                 ),
                //                                 Padding(
                //                                   padding:
                //                                       const EdgeInsets.only(
                //                                           bottom: 8),
                //                                   child: Container(
                //                                       decoration: BoxDecoration(
                //                                           color: AppColor
                //                                               .blackColor
                //                                               .withOpacity(
                //                                                   0.45),
                //                                           borderRadius:
                //                                               BorderRadius
                //                                                   .circular(
                //                                                       10)),
                //                                       child: Padding(
                //                                         padding:
                //                                             const EdgeInsets
                //                                                 .all(8.0),
                //                                         child: CustomText(
                //                                           name:
                //                                               "${formatDouble(shopList![index].distance!, 2)}Km Away",
                //                                           fontSize: SizeUtils
                //                                               .fSize_10(),
                //                                           color: AppColor
                //                                               .backGroundColor,
                //                                           fontWeight:
                //                                               FontWeight.w400,
                //                                         ),
                //                                       )),
                //                                 ),
                //                               ]),
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width:
                //                                 SizeUtils.horizontalBlockSize *
                //                                     3,
                //                           )
                //                         ],
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               ),
                //             ),
                //
                //       SizedBox(
                //         height: SizeUtils.verticalBlockSize * 8,
                //       )
                //     ],
                //   ),
                // ),
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

  void getAddressInformation() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child:
              //Obx(() =>
              //child:
              Container(
            // height:MediaQuery.of(context).size.height,
            // SizeUtils.verticalBlockSize * 70,

            width: SizeUtils.screenWidth,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: AppColor.backGroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(children: [
              SizedBox(
                height: SizeUtils.verticalBlockSize * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      name: "Addresses",
                      fontSize: SizeUtils.fSize_18(),
                      fontWeight: FontWeight.w700,
                    ),
                    GestureDetector(
                      onTap: () {
                        getEditAddress(getAddressType: "addAddress");
                        //Get.toNamed(Routes.addAddress);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.greenColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeUtils.horizontalBlockSize * 4,
                              vertical: SizeUtils.verticalBlockSize * 1),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppColor.backGroundColor,
                              ),
                              SizedBox(
                                width: SizeUtils.horizontalBlockSize * 1,
                              ),
                              CustomText(
                                name: "Address",
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w500,
                                color: AppColor.backGroundColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              CustomAddress(
                addressIcon: "asset/images/home_icon.png",
                addressType: "Home",
                addressDetails: "Lungangen 6, 41722",
                backScreenOnTapEditAddress: () {
                  getEditAddress(getAddressType: "editAddress");
                  // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
                },
                popupButtonOnSelect: (selectButton) {
                  if(selectButton=="update")
                  {
                    getEditAddress(getAddressType: "editAddress");
                    // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});

                  }
                  else
                  {

                  }
                },
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              GestureDetector(
                onTap: () {
                  getEditAddress(getAddressType: "editAddress");
                  // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});
                },
                child: CustomAddress(
                  addressIcon: "asset/images/office_icon.png",
                  addressType: "Office",
                  addressDetails: "Lungangen 6, 41722",
                  backScreenOnTapEditAddress: () {},
                  popupButtonOnSelect: (selectButton) {
                    if(selectButton=="update")
                    {
                      getEditAddress(getAddressType: "editAddress");
                      // Get.toNamed(Routes.addAddress,arguments:  {'addressType': "editAddress"});

                    }
                    else
                    {

                    }
                  },
                ),
              ),
            ]),
          ),
          // ),
        );
      },
    );
  }

  void getEditAddress({required String getAddressType}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.backGroundColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Obx(
            () =>
                //child:
                Container(
              // height:MediaQuery.of(context).size.height,
              // SizeUtils.verticalBlockSize * 70,

              width: SizeUtils.screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                  color: AppColor.backGroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Column(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: CustomText(
                      name: getAddressType == "editAddress"
                          ? "Edit Addresses"
                          : "New Addresses",
                      fontSize: SizeUtils.fSize_24(),
                      fontWeight: FontWeight.w600,
                      color: AppColor.orangeAddressColor,
                    )),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                Container(
                  height: SizeUtils.verticalBlockSize * 7,
                  decoration: BoxDecoration(
                      color: AppColor.blackAddressColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: AppColor.backGroundColor,
                        isExpanded: true,
                        hint: CustomText(
                          name: productHomePageController.addressSelect.value ==
                                  ""
                              ? "Home"
                              : productHomePageController.addressSelect.value,
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                          // color: AppColor.brownAddressColor,
                        ),
                        items: productHomePageController.addressList
                            .map((String addressList) {
                          return DropdownMenuItem<String>(
                              value: addressList,
                              child: CustomText(
                                name: addressList,
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w500,
                              ));
                        }).toList(),
                        onChanged: (String? newValue) async {
                          setState(() {
                            productHomePageController.addressSelect.value =
                                newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                const CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,
                  hintText: "Address",
                  //  hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                Container(
                  height: SizeUtils.verticalBlockSize * 7,
                  decoration: BoxDecoration(
                      color: AppColor.blackAddressColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: AppColor.backGroundColor,
                        isExpanded: true,
                        hint: CustomText(
                          name: productHomePageController.citySelect.value == ""
                              ? "Select City"
                              : productHomePageController.citySelect.value,
                          fontSize: SizeUtils.fSize_14(),
                          fontWeight: FontWeight.w500,
                          // color: AppColor.brownAddressColor,
                        ),
                        items: productHomePageController.cityList
                            .map((String cityList) {
                          return DropdownMenuItem<String>(
                              value: cityList,
                              child: CustomText(
                                name: cityList,
                                fontSize: SizeUtils.fSize_14(),
                                fontWeight: FontWeight.w500,
                              ));
                        }).toList(),
                        onChanged: (String? newValue) async {
                          productHomePageController.citySelect.value =
                              newValue!;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                const CustomTextField(
                  filled: true,
                  fillColor: AppColor.blackAddressColor,
                  hintText: "Address",
                  // hintTextColor: AppColor.brownAddressColor,
                  // textColor: AppColor.brownAddressColor,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 4,
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CustomButton(
                        buttonName: getAddressType == "editAddress"
                            ? "Update Address"
                            : "Add")),
                // const Spacer(),
              ]),
            ),
          ),
        );
      },
    );
  }

  String formatDouble(double value, int decimalPlaces) {
    return value.toStringAsFixed(decimalPlaces);
  }

  Widget buildWidget(String pageViewsTypes) {


    switch (pageViewsTypes) {
      case 'our-categories':
        return CategoryView(categoryModel: categoryModel);
      case 'popular-product':
        return PopularProductView(popularProductModel: popularProductModel,token: token);
      case 'near-shop':
        return NearShopView( token:token, shopList:shopList);
      case 'best-selling':
        return BestSellingView(bestSellingModel:bestSellingModel ,token:token);
      case 'people-also-buy':
        return PeopleBuyView(peopleBuyModel: peopleBuyModel,token: token);
      case 'new-product':
        return NewProductView(newProductModel: newProductModel,token: token);
      case 'offers':
        return CouponView(couponModel: couponModel,token: token);
      case 'custome-product':
        return CustomProductView(customPopularModel: customPopularModel,token: token,);
      case 'bottom-banner':
        return BottomBannerView(bottomBannerModel: bottomBannerModel,token: token,isBanner: isBanner,);

      case 'promotinal-slider':
        return const PromotionalSliderView();

      case 'offer-countdown':
        return OfferCountDownView(flashSaleModel: flashSaleModel,token: token,);


      default:
        return Container();
    }
  }
  }

