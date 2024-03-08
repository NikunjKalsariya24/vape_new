import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CustomAddress extends StatelessWidget {

  final String addressIcon;
  final String addressType;
  final String addressDetails;
  final void Function()? backScreenOnTapEditAddress;
  final void Function(String)?  popupButtonOnSelect;
  const CustomAddress({super.key,required this.addressIcon,required this.addressType,required this.addressDetails, this.backScreenOnTapEditAddress,
  required this.popupButtonOnSelect});

  @override
  Widget build(BuildContext context) {
    return     Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
          child: GestureDetector(onTap:backScreenOnTapEditAddress,
            child: Row(children: [

              Image.asset(addressIcon,width: SizeUtils.horizontalBlockSize*8),
              SizedBox(width: SizeUtils.horizontalBlockSize*8,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                CustomText(name: addressType,fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w600,),
                SizedBox(height: SizeUtils.verticalBlockSize*1,),
                CustomText(name: addressDetails,fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w400,color: AppColor.blackLightColor),
              ],),const Spacer(),

            PopupMenuButton<String>(
              onSelected: popupButtonOnSelect,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'update',
                  child:CustomText(name: "Update",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w500,)
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: CustomText(name: "Delete",fontSize: SizeUtils.fSize_16(),fontWeight: FontWeight.w500,) ,
                ),
              ])
              //Icon(Icons.arrow_forward_ios_sharp,color: AppColor.blackColor,size: SizeUtils.verticalBlockSize*3,)

            ],),
          ),
        ),
    SizedBox(height: SizeUtils.verticalBlockSize*1,),
    Container(height: 1,color: AppColor.dividerBrownColor.withOpacity(0.10),)
      ],
    );

  }
}
