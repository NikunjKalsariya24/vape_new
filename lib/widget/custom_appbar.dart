import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
 final void Function()? backScreenOnTap;
 final String? title;
 final Color? backgroundColor;
 final String?leadingImage;
 final List<Widget>? actions;
 final bool? leadingIcon;
 final double? titleFontSize;
 final bool? automaticallyImplyLeading;

  const CustomAppBar({super.key,this.backScreenOnTap,this.title,this.backgroundColor,this.leadingImage,this.actions,this.leadingIcon,this.titleFontSize,this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: backgroundColor??AppColor.backGroundColor,automaticallyImplyLeading: automaticallyImplyLeading??true,
        leading:leadingIcon==null? Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            GestureDetector(onTap: backScreenOnTap,
              child: Image.asset(
                leadingImage??"asset/images/back_otp.png", width: 40, // Set the desired width
                height: 40,
              ),
            ),
          ],
        ):SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: CustomText(
                  name: title??"",
                  fontSize: titleFontSize??SizeUtils.fSize_16(),
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 12,
            )
          ],
        ),
      actions:actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
