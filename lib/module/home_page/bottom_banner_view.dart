import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vape/model/bottom_banner_model.dart';
import 'package:vape/utils/size_utils.dart';

class BottomBannerView extends StatefulWidget {
  BottomSliderData? bottomBannerModel;
  String? token;
  bool isBanner;
   BottomBannerView({required this.bottomBannerModel,required this.token,required this.isBanner,super.key});

  @override
  State<BottomBannerView> createState() => _BottomBannerViewState();
}

class _BottomBannerViewState extends State<BottomBannerView> {

  @override
  Widget build(BuildContext context) {

    return Column(children: [

      SizedBox(
        height: SizeUtils.verticalBlockSize * 3,
      ),
     widget.isBanner
          ? const Center(child: CircularProgressIndicator())
          : CarouselSlider.builder(
          options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                // setState(() {
                //   selectindex = index;
                // });
              },
              height: SizeUtils.verticalBlockSize * 25,
              viewportFraction: 0.99,
              initialPage: 0,
              aspectRatio: 2 / 4.2),
          itemBuilder: (BuildContext context, int index,
              int realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                  "${widget.bottomBannerModel!.types![0].settings!.bottomslider![index].original}",
                  width: SizeUtils.horizontalBlockSize * 94,
                  fit: BoxFit.fill),
            );
          },
          itemCount: widget.bottomBannerModel!
              .types![0].settings!.bottomslider!.length),

    ],);
  }
}
