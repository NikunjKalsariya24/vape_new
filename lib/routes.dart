import 'package:get/get.dart';
import 'package:vape/module/authentication/forget_password.dart';
import 'package:vape/module/authentication/otp_screen.dart';
import 'package:vape/module/authentication/reset_password_screen.dart';
import 'package:vape/module/cart_page/order_screen.dart';
import 'package:vape/module/cart_page/product_review_screen.dart';
import 'package:vape/module/home_page/fastest_stores.dart';
import 'package:vape/module/home_page/profile/add_address.dart';
import 'package:vape/module/home_page/profile/address.dart';
import 'package:vape/module/home_page/profile/card_screen.dart';
import 'package:vape/module/home_page/profile/edit_prodile.dart';
import 'package:vape/module/home_page/home_screen.dart';
import 'package:vape/module/home_page/product_details.dart';
import 'package:vape/module/home_page/profile/view_all_order.dart';

import 'module/authentication/login_screen.dart';
import 'module/authentication/signup_screen.dart';
import 'module/cart_page/order_status_screen.dart';
import 'module/home_page/category_product_screen.dart';
import 'module/home_page/profile/add_card.dart';
import 'module/home_page/search_screen.dart';
import 'module/splash_screen/splash_screen.dart';

mixin Routes {

  static const defaultTransition = Transition.rightToLeft;
  static const String splashScreen = '/SplashScreen';
  static const String logInScreen = '/LogInScreen';
  static const String signUpScreen = '/SignUpScreen';
  static const String forgetPasswordScreen = '/ForgetPasswordScreen';
  static const String otpScreen = '/OtpScreen';
  static const String resetPasswordScreen = '/ResetPasswordScreen';
  static const String homeScreen = '/HomeScreen';
  static const String productDetails = '/ProductDetails';
  static const String searchScreen = '/SearchScreen';
  static const String editProfile = '/EditProfile';
  static const String addressInformation = '/AddressInformation';
  static const String fastestStore = '/FastestStore';
  static const String addAddress = '/AddAddress';
  static const String cardScreen = '/CardScreen';
  static const String addCard = '/AddCard';
  static const String viewAllOrder = '/ViewAllOrder';
  static const String orderScreen = '/OrderScreen';
  static const String orderStatusScreen = '/OrderStatusScreen';
  static const String productReviewScreen = '/productReviewScreen';
  static const String categoryProductScreen = '/CategoryProductScreen';


  static List<GetPage<dynamic>> pages = [
  GetPage<dynamic>(
  name: splashScreen,
  page: () => SplashScreen(),
  transition: defaultTransition,
  ),

    GetPage<dynamic>(
      name: logInScreen,
      page: () => LogInScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signUpScreen,
      page: () => SignUpScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: otpScreen,
      page: () => const OtpScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: productDetails,
      page: () => const ProductDetails(),
      transition: defaultTransition,
    ),

    GetPage<dynamic>(
      name: searchScreen,
      page: () => const SearchScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: editProfile,
      page: () => const EditProfile(),
      transition: defaultTransition,
    ),
  GetPage<dynamic>(
      name: addressInformation,
      page: () => const AddressInformation(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: addAddress,
      page: () => const AddAddress(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: cardScreen,
      page: () => const CardScreen(),
      transition: defaultTransition,
    ),
   GetPage<dynamic>(
      name: addCard,
      page: () => const AddCard(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: viewAllOrder,
      page: () => const ViewAllOrder(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: orderScreen,
      page: () => const OrderScreen(),
      transition: defaultTransition,
    ),
  GetPage<dynamic>(
      name: orderStatusScreen,
      page: () => const OrderStatusScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: productReviewScreen,
      page: () => const ProductReviewScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: categoryProductScreen,
      page: () => const CategoryProductScreen(),
      transition: defaultTransition,
    ),
 GetPage<dynamic>(
      name: fastestStore,
      page: () => const FastestStore(),
      transition: defaultTransition,
    ),

  ];
}