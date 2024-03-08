import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vape/model/coupon_model.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class CouponView extends StatefulWidget {

  CouponData? couponModel;
  String? token;
  CouponView({required this.couponModel,required this.token,super.key});

  @override
  State<CouponView> createState() => _CouponViewState();
}

class _CouponViewState extends State<CouponView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
SizedBox(height: SizeUtils.verticalBlockSize*3,),
      Container(height: SizeUtils.verticalBlockSize*18,
        child: ListView.builder(shrinkWrap: true,itemCount:widget.couponModel!.coupons!.data!.length ,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {

        return Padding(
          padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize*3),
          child: Row(
            children: [
              Container(height: SizeUtils.verticalBlockSize*17,
                width:  SizeUtils
                .horizontalBlockSize *
                35,   decoration: BoxDecoration(color: AppColor.backGroundColor, borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                    // Shadow color with opacity
                    offset: Offset(0, 1),
                    // X, Y offset
                    blurRadius: 1,
                    // Blur radius
                    spreadRadius: 1, // Spread radius
                  ),
                ],),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  ClipRRect(borderRadius:     const BorderRadius.only(
                    topRight:
                    Radius.circular(15),
              topLeft:
              Radius.circular(
                  15)) ,
                    child: Image.network("${widget.couponModel!.coupons!.data![index].image!.original}" ,fit: BoxFit.fill,
                                    height: SizeUtils
                      .verticalBlockSize *
                      12,
                                    width: SizeUtils
                      .horizontalBlockSize *
                      35),
                  ),

                  Padding(
                    padding:EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize*1,horizontal: SizeUtils.horizontalBlockSize*3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      CustomText(name: "${widget.couponModel!.coupons!.data![index].code}" ,color: AppColor.blackColor,fontSize: SizeUtils.fSize_14(),fontWeight: FontWeight.w600,),
                      GestureDetector(onTap: () {
                        _copyTextToClipboard(context, "${widget.couponModel!.coupons!.data![index].code}" );
                      },child: CustomText(name: "Copy" ,color: AppColor.greenAppBarColor,fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w600,)),


                    ],),
                  )


                ],


                ),
              ),
              SizedBox(width: SizeUtils.horizontalBlockSize*4,)
            ],
          ),
        );
        },),
      )


    ],);
  }

  void _copyTextToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('coupon is copied'),
    ));
  }
  }

