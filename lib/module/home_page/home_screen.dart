import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/authentication/login_screen.dart';
import 'package:vape/module/home_page/product_home_page.dart';
import 'package:vape/module/home_page/profile/profile_screen.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

import '../cart_page/cart_screen.dart';
import 'controller/bottombar_controller.dart';
import 'item_screen.dart';
import 'massage_screen.dart';

class HomeScreen extends StatefulWidget {
  static var currentIndexsss = 0;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());
  SharedPrefService sharedPrefService=SharedPrefService();
  // int pageIndex = 0;
  //
  // var currentIndex = HomeScreen.currentIndexsss;
  //
  // final _page1 = GlobalKey<NavigatorState>();
  // final _page2 = GlobalKey<NavigatorState>();
  // final _page3 = GlobalKey<NavigatorState>();
  // final _page4 = GlobalKey<NavigatorState>();
  //


  final pages = [
     ProductHomePage(),
    const ItemScreen(),
    const CartScreen(),
    const MassageScreen(),
    const ProfileScreen(),
  ];
String? token;
bool? isSkipLogIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token=sharedPrefService.getToken();

    isSkipLogIn    =sharedPrefService.getSkipLogIn();
    print("token=========${token}");

  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        
          backgroundColor: AppColor.backGroundColor,
          body: pages[bottomBarController.pageIndex.value],
          bottomNavigationBar: checkLogIn(),

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
            bottomBarController.pageIndex.value == selectedIndex
                ? selectedImageName
                : unSelectedImageName,
            height: 25,

            fit: BoxFit.contain,
//   height: 30
          ),
          bottomBarController.pageIndex.value == selectedIndex
              ? CustomText(
                  name: textName,
                  color: AppColor.orangeColor,
                  fontSize: SizeUtils.fSize_12(),
                  fontWeight: FontWeight.w500,
                )
              : SizedBox(),
        ]));
  }

  Future<bool> _onWillPop() async {
    if (bottomBarController.pageIndex.value == 1 || bottomBarController.pageIndex.value == 2 || bottomBarController.pageIndex.value == 3 ||bottomBarController.pageIndex.value==4) {

        bottomBarController.pageIndex.value = 0;

      return false;
    }
    return true;
  }

  Widget  checkLogIn() {
    if (isSkipLogIn == true) {
      if (bottomBarController.pageIndex.value == 1 ||
          bottomBarController.pageIndex.value == 2) {
        return LogInScreen();
      }
      else {
        return Container(
          height: SizeUtils.verticalBlockSize * 8,
          decoration: BoxDecoration(
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
                      onTap: () {
                        bottomBarController.pageIndex.value = 0;
                      },
                      selectedImageName: "asset/images/selected_home.png",
                      unSelectedImageName: "asset/images/unselected_home.png",
                      textName: "Home",
                      selectedIndex: 0),
                  customBottomBarContainer(
                      onTap: () {
                        bottomBarController.pageIndex.value = 1;
                      },
                      selectedImageName: "asset/images/selected_favorite.png",
                      unSelectedImageName: "asset/images/unselected_favorite.png",
                      textName: "Wishlist",
                      selectedIndex: 1),
                  customBottomBarContainer(
                      onTap: () {
                        bottomBarController.pageIndex.value = 2;
                      },
                      selectedImageName: "asset/images/slected_cart.png",
                      unSelectedImageName: "asset/images/unselected_bag.png",
                      textName: "Cart",
                      selectedIndex: 2),
                  customBottomBarContainer(
                      onTap: () {
                        bottomBarController.pageIndex.value = 3;
                      },
                      selectedImageName: "asset/images/selected_support.png",
                      unSelectedImageName:
                      "asset/images/unselected_massage.png",
                      textName: "Support",
                      selectedIndex: 3),
                  customBottomBarContainer(
                      onTap: () {
                        bottomBarController.pageIndex.value = 4;
                      },
                      selectedImageName: "asset/images/selected_profile.png",
                      unSelectedImageName:
                      "asset/images/unselected_profile.png",
                      textName: "Profile",
                      selectedIndex: 4),
                ],
              ),
            ),
          ),
        );
      }
    }
    else{
      return Container(
        height: SizeUtils.verticalBlockSize * 8,
        decoration: BoxDecoration(
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
                    onTap: () {
                      bottomBarController.pageIndex.value = 0;
                    },
                    selectedImageName: "asset/images/selected_home.png",
                    unSelectedImageName: "asset/images/unselected_home.png",
                    textName: "Home",
                    selectedIndex: 0),
                customBottomBarContainer(
                    onTap: () {
                      bottomBarController.pageIndex.value = 1;
                    },
                    selectedImageName: "asset/images/selected_favorite.png",
                    unSelectedImageName: "asset/images/unselected_favorite.png",
                    textName: "Wishlist",
                    selectedIndex: 1),
                customBottomBarContainer(
                    onTap: () {
                      bottomBarController.pageIndex.value = 2;
                    },
                    selectedImageName: "asset/images/slected_cart.png",
                    unSelectedImageName: "asset/images/unselected_bag.png",
                    textName: "Cart",
                    selectedIndex: 2),
                customBottomBarContainer(
                    onTap: () {
                      bottomBarController.pageIndex.value = 3;
                    },
                    selectedImageName: "asset/images/selected_support.png",
                    unSelectedImageName:
                    "asset/images/unselected_massage.png",
                    textName: "Support",
                    selectedIndex: 3),
                customBottomBarContainer(
                    onTap: () {
                      bottomBarController.pageIndex.value = 4;
                    },
                    selectedImageName: "asset/images/selected_profile.png",
                    unSelectedImageName:
                    "asset/images/unselected_profile.png",
                    textName: "Profile",
                    selectedIndex: 4),
              ],
            ),
          ),
        ),
      );
    }

  }
}
