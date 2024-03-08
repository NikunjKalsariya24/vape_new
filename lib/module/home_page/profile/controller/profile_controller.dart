import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vape/model/user_address_model.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/shareprafrance.dart';

class ProfileController extends GetxController{
  SharedPrefService sharedPrefService=SharedPrefService();
  RxString selectBirthDate="26/01/2024".obs;
  RxString selectedGender = "Male".obs;
  RxList<String> genderType = ["Male", "Female","Other"].obs;
  RxString addressSelect = "Home".obs;
  RxList<String> addressList = ["Home", "Office"].obs;
  RxString citySelect = "".obs;
  RxList<String> cityList = ["Surat", "Bhavnagar"].obs;
  RxBool isLogOut=false.obs;
  RxBool isUserDetails=false.obs;
  RxBool updateAddress=false.obs;
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController streetAddressController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController zipCodeController=TextEditingController();
  var userAddressModel = UserAddressData().obs;
  GraphQLService graphQLService=GraphQLService();
  Future<RxString> selectDate(BuildContext context) async {


    DateTime selectedDate = DateFormat('dd/MM/yyyy').parse(selectBirthDate.value);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
      //  selectableDayPredicate: (DateTime day) =>day.isBefore(selectedDate) || day.isAtSameMomentAs(selectedDate),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      selectBirthDate.value =DateFormat('dd/MM/yyyy').format(selectedDate);
    }

    return selectBirthDate;
  }
 bool? isSkip;
  String? token;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    token=sharedPrefService.getToken();

    isSkip=sharedPrefService.getSkipLogIn();
    //getAddress(token);
  }
  // getAddress(token) async {
  //
  //     userAddressModel.value=(await graphQLService.getUserAddress(token!))!;
  //
  //
  //
  //
  //
  //
  //
  //
  // }
}

