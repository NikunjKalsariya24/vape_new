import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vape/utils/app_colors.dart';

class ProductHomePageController extends GetxController{
  RxString addressSelect = "Home".obs;
  RxList<String> addressList = ["Home", "Office"].obs;
  RxString citySelect = "".obs;
  RxList<String> cityList = ["Surat", "Bhavnagar"].obs;

}