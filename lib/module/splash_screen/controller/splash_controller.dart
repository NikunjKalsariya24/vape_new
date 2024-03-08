import 'package:get/get.dart';

import 'package:vape/routes.dart';
import 'package:vape/utils/shareprafrance.dart';
class SplashController extends GetxController {
  SharedPrefService sharedPrefService=SharedPrefService();

  bool? isSkip;
  bool? isLogIn;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isSkip=sharedPrefService.getSkipLogIn();
    isLogIn=sharedPrefService.getLogIn();
    openScreen();
  }

  void openScreen() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    isSkip! || isLogIn!? Get.offAndToNamed(Routes.homeScreen): Get.offAndToNamed(Routes.logInScreen);
  }
}
