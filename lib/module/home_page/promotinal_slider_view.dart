import 'package:flutter/material.dart';
import 'package:vape/utils/size_utils.dart';

class PromotionalSliderView extends StatefulWidget {
  const PromotionalSliderView({super.key});

  @override
  State<PromotionalSliderView> createState() => _PromotionalSliderViewState();
}

class _PromotionalSliderViewState extends State<PromotionalSliderView> {
  List<String> promotionalImage = [
    "asset/images/express_delivery_icon.png",
    "asset/images/high_discount_icon.png",
    "asset/images/loyalty_rewards_icon.png",
    "asset/images/safe_secure_icon.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
      child: Column(
        children: [
          SizedBox(
            height: SizeUtils.verticalBlockSize * 3,
          ),
          Container(height: SizeUtils.verticalBlockSize*15,
            child: ListView.builder(itemCount: promotionalImage.length,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context, index) {

              return Row(children: [

                Image.asset(promotionalImage[index]),
                SizedBox(width: SizeUtils.horizontalBlockSize*4,)
              ],);
            },),
          )
        ],
      ),
    );
  }
}
