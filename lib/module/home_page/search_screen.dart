import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/search_product_model.dart';
import 'package:vape/routes.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GraphQLService graphQLService = GraphQLService();
  SharedPrefService sharedPrefService = SharedPrefService();
  String? token;
  SearchProductData? searchProductModel;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = sharedPrefService.getToken();
    //getSearchData();
  }


  bool isSearchProduct=false;

  getSearchData(String searchDetails) async {
    setState(() {
      isSearchProduct=true;
    });
    searchProductModel =
        await graphQLService.searchProduct(token!, 30, "en", searchDetails);
    setState(() {
      isSearchProduct=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor.withOpacity(0.90),
      appBar: CustomAppBar(
        title: "Search Food",
        backgroundColor: AppColor.backGroundColor.withOpacity(0.10),
        leadingImage: "asset/images/arrow_back.png",
        backScreenOnTap: () {
          Get.back();
        },
      ),
      body:

      Padding(
              padding:
        EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
              child: Column(children: [
      SizedBox(
        height: SizeUtils.verticalBlockSize * 3,
      ),

      Container(
          height: SizeUtils.verticalBlockSize * 6.5,
          decoration: BoxDecoration(
              color: AppColor.backGroundColor,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize*3),
            child: Row(
              children: [
                Image.asset("asset/images/search_icon.png",
                    width: SizeUtils.horizontalBlockSize * 6),
                Expanded(
                  child: SizedBox(
                      height: SizeUtils.verticalBlockSize * 7,
                      child: CustomTextField(
                        textEditingController: searchController,
                        onChanged: (newValue) {
                          searchController.text = newValue ?? "";
                          getSearchData(searchController.text);
                          setState(() {});
                        },
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      )),
                ),
                IconButton(onPressed: () {
                  searchController.clear();
                  getSearchData(searchController.text);

                  setState(() {});
                }, icon: Icon(Icons.clear)),
                // Image.asset("asset/images/seting_icon.png",
                //     width: SizeUtils.horizontalBlockSize * 6),
              ],
            ),
          )),
      // CustomTextField(prefix: Icon(Icons.search),fillColor:AppColor.backGroundColor,filled: true,suffix: Image.asset("asset/images/seting_icon.png",width: SizeUtils.horizontalBlockSize*6,
      // //    height: SizeUtils.verticalBlockSize*6
      // ),),

      // Padding(
      //   padding:
      //       EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 3),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       CustomText(
      //         name: "Recent searches",
      //         fontSize: SizeUtils.fSize_16(),
      //         fontWeight: FontWeight.w600,
      //       ),
      //       CustomText(
      //           name: "Delete",
      //           fontSize: SizeUtils.fSize_14(),
      //           fontWeight: FontWeight.w500,
      //           color: AppColor.orangeColor),
      //     ],
      //   ),
      // ),
      //
      // ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: 6,
      //   itemBuilder: (context, index) {
      //     return Column(
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Row(
      //               children: [
      //                 Image.asset("asset/images/search_icon.png",
      //                     width: SizeUtils.horizontalBlockSize * 6),
      //                 SizedBox(
      //                   width: SizeUtils.horizontalBlockSize * 6,
      //                 ),
      //                 CustomText(
      //                   name: "Burgers",
      //                   fontSize: SizeUtils.fSize_16(),
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //               ],
      //             ),
      //
      //             Image.asset("asset/images/delet_icon.png",
      //                 width: SizeUtils.horizontalBlockSize * 6)
      //             // Icon(Icons.)
      //           ],
      //         ),
      //         SizedBox(
      //           height: SizeUtils.verticalBlockSize * 3,
      //         )
      //       ],
      //     );
      //   },
      // ),
      SizedBox(
        height: SizeUtils.verticalBlockSize * 4,
      ),


                isSearchProduct?CircularProgressIndicator():        searchProductModel==null?SizedBox():   searchProductModel?.products?.data?.length==0
          ? CustomText(
              fontSize: SizeUtils.fSize_18(),
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor,
              name: "No Product Found",
            )
          : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchProductModel?.products?.data?.length,
                itemBuilder: (context, index) {
print("image=========${searchProductModel!.products!.data![index].image!.original}");
                  return GestureDetector(onTap: () {
                    Get.toNamed(Routes.productDetails, arguments: {
                      'productId': searchProductModel?.products?.data![index].id,

                      'productSlug':  searchProductModel?.products?.data![index].slug,
                    });


                  },
                    child: Card(elevation: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding:EdgeInsets.only(left: 6,top: 6,bottom: 6),
                            child: Image.network(
                              "${searchProductModel?.products?.data![index].image?.original}",
                              height: SizeUtils.verticalBlockSize *10,
                              width: SizeUtils.horizontalBlockSize * 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: CustomText(
                                fontSize: SizeUtils.fSize_16(),
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor,
                                name: "${searchProductModel?.products?.data?[index].name}",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
          )
              ]),
            ),
    );
  }
}
