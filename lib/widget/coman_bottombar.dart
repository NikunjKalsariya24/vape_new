import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import '../module/home_page/home_screen.dart';

class ComanBottomBar{


  var currentIndex = 0;
  selectedIndex(index) {
    currentIndex = index;
  }
  BuildContext? _context;
Widget bottompart(BuildContext context,index)
{
  _context = context;
  selectedIndex(index);

  return  Container(
  height: SizeUtils.verticalBlockSize * 8,
  decoration:  BoxDecoration(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: AppColor.blackLightColor.withOpacity(0.10),


  ),
  child: Padding(
    padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.horizontalBlockSize * 6),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customBottomBarContainer(
            // onTap: () {
            //   bottomBarController.pageIndex.value = 0;
            // },
              selectedImageName: "asset/images/selected_home.png",
              unSelectedImageName: "asset/images/unselected_home.png",
              textName: "Home",
              selectedIndex: 0,
              pageIndex: 0),
          customBottomBarContainer(
            // onTap: () {
            //   bottomBarController.pageIndex.value = 1;
            // },
              selectedImageName: "asset/images/selected_favorite.png",
              unSelectedImageName: "asset/images/unselected_favorite.png",
              textName: "Wishlist",
              selectedIndex: 1,
              pageIndex: 1),
          customBottomBarContainer(
            // onTap: () {
            //   bottomBarController.pageIndex.value = 2;
            // },
              selectedImageName: "asset/images/slected_cart.png",
              unSelectedImageName: "asset/images/unselected_bag.png",
              textName: "Cart",
              selectedIndex: 2,
              pageIndex: 2),
          customBottomBarContainer(
            // onTap: () {
            //   bottomBarController.pageIndex.value = 3;
            // },
              selectedImageName: "asset/images/selected_support.png",
              unSelectedImageName:
              "asset/images/unselected_massage.png",
              textName: "Support",
              selectedIndex: 3,
              pageIndex: 3),
          customBottomBarContainer(
            // onTap: () {
            //   bottomBarController.pageIndex.value = 4;
            // },
              selectedImageName: "asset/images/selected_profile.png",
              unSelectedImageName:
              "asset/images/unselected_profile.png",
              textName: "Profile",
              selectedIndex: 4,
              pageIndex: 4),
        ],
      ),
    ),
  ),
);
}

  customBottomBarContainer(
      {

        //onTap,
        selectedIndex,
        textName,
        selectedImageName,
        unSelectedImageName,
        pageIndex}) {
    return GestureDetector(
        onTap: () {

          HapticFeedback.mediumImpact();
          selectedIndex(selectedIndex);
          HomeScreen.currentIndexsss = pageIndex;
          Navigator.pushAndRemoveUntil(
              _context!,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()),
                  (Route<dynamic> route) => route is HomeScreen);
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            pageIndex == selectedIndex
                ? selectedImageName
                : unSelectedImageName,
            height: 25,
            fit: BoxFit.contain,
//   height: 30
          ),
          pageIndex == selectedIndex
              ? CustomText(
            name: textName,
            color: AppColor.orangeColor,
            fontSize: SizeUtils.fSize_12(),
            fontWeight: FontWeight.w500,
          )
              : SizedBox(),
        ]));
  }
}