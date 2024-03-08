import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class AppBottomBar extends StatefulWidget {
  AppBottomBar({super.key, required this.bottomBar});

  String bottomBar;

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {

    return Container(
      height: SizeUtils.verticalBlockSize * 8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: AppColor.blackLightColor.withOpacity(0.10),
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.bottomBar == "0"
                      ? Get.back()
                      : bottomBarController.pageNewIndex.value = 0;
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(


                        widget.bottomBar == "0"
                            ? "asset/images/selected_home.png"
                            : "asset/images/unselected_home.png",

                        height: 25,
                        fit: BoxFit.contain,
                      ),


                      widget.bottomBar == "0"
                          ? CustomText(
                              name: "Home",
                              color: AppColor.orangeColor,
                              fontSize: SizeUtils.fSize_12(),
                              fontWeight: FontWeight.w500,
                            )
                          : const SizedBox()
                    ]),
              ),
              customBottomBarContainer(
                  onTap: () {
                    bottomBarController.pageNewIndex.value = 1;
                  },
                  selectedImageName: "asset/images/selected_favorite.png",
                  unSelectedImageName: "asset/images/unselected_favorite.png",
                  textName: "Wishlist",
                  selectedIndex: 1),
              customBottomBarContainer(
                  onTap: () {
                    bottomBarController.pageNewIndex.value = 2;
                  },
                  selectedImageName: "asset/images/slected_cart.png",
                  unSelectedImageName: "asset/images/unselected_bag.png",
                  textName: "Cart",
                  selectedIndex: 2),
              customBottomBarContainer(
                  onTap: () {
                    bottomBarController.pageNewIndex.value = 3;
                  },
                  selectedImageName: "asset/images/selected_support.png",
                  unSelectedImageName: "asset/images/unselected_massage.png",
                  textName: "Support",
                  selectedIndex: 3),
              GestureDetector(
                onTap: () {
                  widget.bottomBar == "4"
                      ? Get.back()
                      : bottomBarController.pageNewIndex.value = 4;
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.bottomBar == "4"
                            ? "asset/images/selected_profile.png"
                            : "asset/images/unselected_profile.png",
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                      widget.bottomBar == "4"
                          ? CustomText(
                              name: "Profile",
                              color: AppColor.orangeColor,
                              fontSize: SizeUtils.fSize_12(),
                              fontWeight: FontWeight.w500,
                            )
                          : const SizedBox()
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  customBottomBarContainer(
      {onTap,
      selectedIndex,
      textName,
      selectedImageName,
      unSelectedImageName,
      pageIndex}) {
    return GestureDetector(
        onTap: onTap,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            bottomBarController.pageNewIndex.value == selectedIndex
                ? selectedImageName
                : unSelectedImageName,
            height: 25,
            fit: BoxFit.contain,
//   height: 30
          ),
          bottomBarController.pageNewIndex.value == selectedIndex
              ? CustomText(
                  name: textName,
                  color: AppColor.orangeColor,
                  fontSize: SizeUtils.fSize_12(),
                  fontWeight: FontWeight.w500,
                )
              : const SizedBox()
        ]));
  }
}
