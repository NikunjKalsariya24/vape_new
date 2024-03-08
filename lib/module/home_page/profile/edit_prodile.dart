import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_button.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String selectGender = "Select Salon";

  String genderSelect = "";

  List<String> genderList = ["Male", "Female"];
  String salonNotSelected = "Select Gender";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6,vertical: SizeUtils.verticalBlockSize*1),
        child: GestureDetector(onTap: () {

          Get.back();
        },child: CustomButton(buttonName: "Save")),
      ),
      appBar: CustomAppBar(
        title: "Personal Data",
        backgroundColor: AppColor.backGroundColor.withOpacity(0.10),
        leadingImage: "asset/images/arrow_back.png",
        backScreenOnTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: SizeUtils.verticalBlockSize * 3),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.asset("asset/images/profile_icon.png",
                        width: SizeUtils.horizontalBlockSize * 24),
                    Image.asset(
                      "asset/images/camera.png",
                      width: SizeUtils.horizontalBlockSize * 8,
                    )
                  ],
                ),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 3),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      name: "Full Name",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    CustomTextField(),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    CustomText(
                      name: "Date of birth",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.textFieldColor)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              CustomText(
                                  name: DateFormat('dd/MM/yyyy')
                                      .format(selectedDate),
                                  fontSize: SizeUtils.fSize_14(),
                                  fontWeight: FontWeight.w500),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    CustomText(
                      name: "Gender",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    Container(
                      height: SizeUtils.verticalBlockSize * 7,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.textFieldColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColor.backGroundColor,
                            isExpanded: true,
                            hint: CustomText(
                              name: genderSelect == ""
                                  ? salonNotSelected
                                  : genderSelect,
                              fontSize: SizeUtils.fSize_14(),
                              fontWeight: FontWeight.w500,
                            ),
                            items: genderList.map((String availabilityItem) {
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
                                genderSelect = newValue!;
                              });
                              print("genderSelect===${genderSelect}");
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    CustomText(
                      name: "Phone",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                CustomTextField(keyboardType:TextInputType.number,),

                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    CustomText(
                      name: "Email",
                      fontSize: SizeUtils.fSize_14(),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    CustomTextField(),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      // Set the minimum year you want in the date picker.
      lastDate: DateTime.now(),
      // Set the maximum year you want in the date picker.
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Colors.blue, // Change the primary color of the picker
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
