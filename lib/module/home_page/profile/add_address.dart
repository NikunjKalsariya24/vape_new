import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class AddAddress extends StatefulWidget {

  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends



State<AddAddress> {
  BottomBarController bottomBarController=Get.put(BottomBarController());
  final Map<String, dynamic>? data = Get.arguments;
  String addressSelect = "";

  List<String> addressList = ["Home", "Office"];
  String addressNotSelected = "Select Address Type";

  String citySelect = "";

  List<String> cityList = ["Surat", "Bhavnagar"];
  String cityNotSelected = "Select City";
   String? addressType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressType=data?['addressType'];
    bottomBarController.pageNewIndex.value=(-1);
    print("addressType====${addressType}");
  }
  @override
  Widget build(BuildContext context) {

    return Obx(() =>

      Scaffold(

        backgroundColor: AppColor.backGroundColor,
        bottomNavigationBar:AppBottomBar(bottomBar: "4"),

      appBar: CustomAppBar(


        backScreenOnTap: () {
      Get.back();
        },
      ),
         body: bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:Padding(
           padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
           child: Column(children: [
             Align(alignment: Alignment.topCenter,child: CustomText(name: addressType=="editAddress"?"Edit Addresses":"New Addresses",fontSize: SizeUtils.fSize_24(),fontWeight: FontWeight.w600,color: AppColor.orangeAddressColor,)),
             SizedBox(height: SizeUtils.verticalBlockSize*4,),
             Container(
               height: SizeUtils.verticalBlockSize * 7,
               decoration: BoxDecoration(color: AppColor.blackAddressColor,

                   borderRadius: BorderRadius.circular(5)),
               child: Padding(
                 padding: const EdgeInsets.only(left: 25, right: 25),
                 child: DropdownButtonHideUnderline(
                   child: DropdownButton<String>(
                     dropdownColor: AppColor.backGroundColor,
                     isExpanded: true,
                     hint: CustomText(
                       name: addressSelect == ""
                           ? addressNotSelected
                           : addressSelect,
                       fontSize: SizeUtils.fSize_14(),
                       fontWeight: FontWeight.w500,color: AppColor.brownAddressColor,
                     ),
                     items: addressList.map((String availabilityItem) {
                       return DropdownMenuItem<String>(
                           value: availabilityItem,
                           child: CustomText(
                             name: availabilityItem,
                             fontSize: SizeUtils.fSize_14(),
                             fontWeight: FontWeight.w500,
                           ));
                     }).toList(),
                     onChanged: (String? newValue) async {
                       setState(() {
                         addressSelect = newValue!;
                       });
                       print("genderSelect===${addressSelect}");
                     },
                   ),
                 ),
               ),
             ),

             SizedBox(height: SizeUtils.verticalBlockSize*4,),
             const CustomTextField(filled: true,fillColor: AppColor.blackAddressColor, hintText: "Address",hintTextColor: AppColor.brownAddressColor,textColor: AppColor.brownAddressColor,border: OutlineInputBorder(
               borderSide: BorderSide.none,
             ),
               enabledBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),
               focusedBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),),
             SizedBox(height: SizeUtils.verticalBlockSize*4,),
             Container(
               height: SizeUtils.verticalBlockSize * 7,
               decoration: BoxDecoration(color: AppColor.blackAddressColor,

                   borderRadius: BorderRadius.circular(5)),
               child: Padding(
                 padding: const EdgeInsets.only(left: 25, right: 25),
                 child: DropdownButtonHideUnderline(
                   child: DropdownButton<String>(
                     dropdownColor: AppColor.backGroundColor,
                     isExpanded: true,
                     hint: CustomText(
                       name: citySelect == ""
                           ? cityNotSelected
                           : citySelect,
                       fontSize: SizeUtils.fSize_14(),
                       fontWeight: FontWeight.w500,color: AppColor.brownAddressColor,
                     ),
                     items: addressList.map((String availabilityItem) {
                       return DropdownMenuItem<String>(
                           value: availabilityItem,
                           child: CustomText(
                             name: availabilityItem,
                             fontSize: SizeUtils.fSize_14(),
                             fontWeight: FontWeight.w500,
                           ));
                     }).toList(),
                     onChanged: (String? newValue) async {
                       setState(() {
                         citySelect = newValue!;
                       });
                       print("genderSelect===${citySelect}");
                     },
                   ),
                 ),
               ),
             ),
             SizedBox(height: SizeUtils.verticalBlockSize*4,),
             const CustomTextField(filled: true,fillColor: AppColor.blackAddressColor, hintText: "Address",hintTextColor: AppColor.brownAddressColor,textColor: AppColor.brownAddressColor,border: OutlineInputBorder(
               borderSide: BorderSide.none,
             ),
               enabledBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),
               focusedBorder: OutlineInputBorder(borderSide:  BorderSide.none, ),),
             const Spacer(),
             Padding(
               padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize*1),
               child: GestureDetector(onTap: () {
                 Get.back();

               },child: CustomButton(buttonName:addressType=="editAddress"?"Update Address": "Add")),
             ),
           ]),
         ),



      ),
    );
  }
}
