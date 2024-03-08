import 'package:get/get.dart';
import 'package:vape/module/cart_page/cart_screen.dart';
import 'package:vape/module/home_page/item_screen.dart';
import 'package:vape/module/home_page/massage_screen.dart';
import 'package:vape/module/home_page/product_home_page.dart';
import 'package:vape/module/home_page/profile/profile_screen.dart';

class BottomBarController extends GetxController{


  RxInt pageIndex = 0.obs;
  RxInt pageNewIndex = (-1).obs;


  final pages = [
    ProductHomePage(),
    const ItemScreen(),
    const CartScreen(),
    const MassageScreen(),
    const ProfileScreen(),
  ];



}