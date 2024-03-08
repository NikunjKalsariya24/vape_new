import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/model/category_model.dart';
import 'package:vape/module/home_page/category_product_screen.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CategoryView extends StatefulWidget {
  CategoriesData? categoryModel;
   CategoryView({required this.categoryModel,super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return              Column(
      children: [
        SizedBox(height: SizeUtils.verticalBlockSize*3,),
        SizedBox(
          height: SizeUtils.verticalBlockSize * 35,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 3,
                vertical: SizeUtils.verticalBlockSize * 2),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
                //childAspectRatio: 0.8,
                crossAxisSpacing: 0,
              ),
              shrinkWrap: true,
              itemCount: widget.categoryModel!.categories!.data!.length,

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("istapok====${ widget.categoryModel!
                        .categories!.data![index].slug}");

                    print("istapok====${  widget. categoryModel!.categories!
                        .data![index].image!.original}");


                    Get.toNamed(Routes.categoryProductScreen,arguments:
                    {

                      'slug': widget.categoryModel!
                          .categories!.data![index].slug,
                      'image': widget. categoryModel!.categories!
                          .data![index].image!.original
                    }
                    );

                  },
                  child: Column(
                    children: [
                      widget. categoryModel!.categories!.data![index]
                          .image!.original ==
                          null
                          ? Container(
                        height:
                        SizeUtils.verticalBlockSize *
                            12,
                        width:
                        SizeUtils.horizontalBlockSize *
                            25,
                        decoration: BoxDecoration(
                            color: AppColor.supportColor,
                            borderRadius:
                            BorderRadius.circular(6)),
                      )
                          : ClipRRect(
                        borderRadius:
                        BorderRadius.circular(6),
                        child: Image.network(
                            widget. categoryModel!
                                .categories!
                                .data![index]
                                .image
                                ?.original ??
                                "",
                            height: SizeUtils
                                .verticalBlockSize *
                                12,
                            width: SizeUtils
                                .horizontalBlockSize *
                                26,
                            fit: BoxFit.fill),
                      ),
                      CustomText(
                        name:  widget.categoryModel!
                            .categories!.data![index].name,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeUtils.fSize_12(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );

  }
}
