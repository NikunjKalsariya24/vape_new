import 'package:flutter/material.dart';

import 'package:vape/model/flsh_sale_model.dart';
import 'package:vape/module/home_page/timercountdown.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class OfferCountDownView extends StatefulWidget {
  FlashSaleData? flashSaleModel;
  String? token;
   OfferCountDownView({required this.flashSaleModel,required this.token,super.key});

  @override
  State<OfferCountDownView> createState() => _OfferCountDownViewState();
}

class _OfferCountDownViewState extends State<OfferCountDownView> {

  bool isFlashSale = false;

  GraphQLService graphQLService = GraphQLService();
  SharedPrefService sharedPrefService = SharedPrefService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return isFlashSale
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.horizontalBlockSize * 3),
            child: Column(
              children: [
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 3,
                ),
                Container(height: SizeUtils.verticalBlockSize*25,width: double.infinity,
                  child: ListView.builder(
                    itemCount: widget.flashSaleModel!.flashSales!.data!.length,
                    shrinkWrap: true,padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(width: SizeUtils.horizontalBlockSize*80,
                            decoration: BoxDecoration(color: AppColor.greenColor),
                            child: Column(
                              children: [
                                SizedBox(height: SizeUtils.verticalBlockSize*1,),
                                CustomText(
                                  name:
                                      "${widget.flashSaleModel!.flashSales!.data![index].title}",
                                  fontSize: SizeUtils.fSize_16(),
                                  color: AppColor.backGroundColor,
                                  fontWeight: FontWeight.w500,
                                ),

                                CustomText(
                                  name:
                                  "${widget.flashSaleModel!.flashSales!.data![index].description}",
                                  fontSize: SizeUtils.fSize_20(),
                                  color: AppColor.backGroundColor,
                                  fontWeight: FontWeight.w600,
                                ),

                                Container(decoration: BoxDecoration(color: AppColor.backGroundColor,borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(mainAxisSize: MainAxisSize.min,children: [
                                      CustomText(
                                        name:"USE Coupen Code :",

                                        fontSize: SizeUtils.fSize_12(),
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                                      CustomText(
                                        name:"${widget.flashSaleModel!.flashSales!.data![index].slug}",

                                        fontSize: SizeUtils.fSize_12(),
                                        color: AppColor.greenColor,
                                        fontWeight: FontWeight.w600,
                                      ),

                                    ],),
                                  ),
                                ),
                                SizedBox(height: SizeUtils.verticalBlockSize*1,),
                              //  TimerCountdown(endTime:  widget.flashSaleModel!.flashSales!.data![index].endDate!)
                                TimerCountView(
                                  format: CountDownTimerFormat.daysHoursMinutesSeconds,
                                  endTime:widget.flashSaleModel!.flashSales!.data![index].endDate!,
                                  onEnd: () {
                                    print("Timer finished");
                                  },
                                ),
                                // TimerCountView(format:enum  CountDownTimerFormat { daysHoursMinutesSeconds, hoursMinutesSeconds }, endTime: widget.flashSaleModel!.flashSales!.data![index].endDate!, onEnd: (){
                                //
                                // })
                                // TimerCountdown(
                                //   format: CountDownTimerFormat.daysHoursMinutesSeconds,
                                //   endTime: DateTime.now().add(
                                //     Duration(
                                //       days: 5,
                                //       hours: 14,
                                //       minutes: 27,
                                //       seconds: 34,
                                //     ),
                                //   ),
                                //   onEnd: () {
                                //     print("Timer finished");
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(width:SizeUtils.horizontalBlockSize*4,)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
