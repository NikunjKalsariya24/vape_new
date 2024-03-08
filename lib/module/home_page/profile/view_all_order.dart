import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vape/module/home_page/controller/bottombar_controller.dart';
import 'package:vape/module/home_page/profile/history_order.dart';
import 'package:vape/module/home_page/profile/ongoing_order.dart';
import 'package:vape/utils/app_bottombar.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_appbar.dart';
import 'package:vape/widget/custom_text.dart';

class ViewAllOrder extends StatefulWidget {
  const ViewAllOrder({super.key});

  @override
  State<ViewAllOrder> createState() => _ViewAllOrderState();
}

class _ViewAllOrderState extends State<ViewAllOrder>  with TickerProviderStateMixin {

  BottomBarController bottomBarController=Get.put(BottomBarController());
  TabController? tabController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomBarController.pageNewIndex.value=(-1);
    tabController = TabController(vsync: this, length: 2);
  }
int selectedTab=0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      //child:
      Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: CustomAppBar(
          backScreenOnTap: () {
            Get.back();
          },

        ), bottomNavigationBar:AppBottomBar(bottomBar: "4"),
        body:  bottomBarController.pageNewIndex.value!=(-1)? bottomBarController.pages[bottomBarController.pageNewIndex.value]:Column(children: [
          Align( alignment: Alignment.topCenter,child: CustomText(name: "Orders",fontSize: SizeUtils.fSize_24(),fontWeight: FontWeight.w700,color: AppColor.orangeAddressColor,)),
        DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: TabBar(
            onTap: (value){
              setState(() {
                selectedTab=value;

              });
            },

            controller: tabController,
            indicatorColor:AppColor.orangeColor,
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            isScrollable: false,
            unselectedLabelColor:AppColor.brownAddressColor,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 40),
            tabs:  [

              Column(
                children: [
                  CustomText(name: "Ongoing",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w400,color:selectedTab==0? AppColor.orangeColor:AppColor.brownAddressColor,),
                SizedBox(height: SizeUtils.verticalBlockSize*1,),
                ],
              ),
              Column(
                children: [
                  CustomText(name: "History",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w400,color:selectedTab==1? AppColor.orangeColor:AppColor.brownAddressColor,),
                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                ],
              ),


            ],
          ),
        ),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: [OngoingOrder(), HistoryOrder()]),
        ),

        ]),

      ),
    );
  }




}
