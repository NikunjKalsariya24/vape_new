import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

enum CountDownTimerFormat { daysHoursMinutesSeconds, hoursMinutesSeconds }

class TimerCountView extends StatefulWidget {
  final CountDownTimerFormat format;
  final DateTime endTime;
  final Function onEnd;

  TimerCountView({required this.format, required this.endTime, required this.onEnd});

  @override
  _TimerCountViewState createState() => _TimerCountViewState();
}

class _TimerCountViewState extends State<TimerCountView> {
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.endTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds == 0) {
          timer.cancel();
          if (widget.onEnd != null) {
            widget.onEnd();
          }
        } else {
          _duration = _duration - const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String displayTime;
    String displayDay;
    String displayHours;
    String displayMinutes;
    String displaySeconds;
    {
      displayDay="${_duration.inDays}";
      displayHours="${_duration.inHours.remainder(24)}";
      displayMinutes="${_duration.inMinutes.remainder(60)}";
      displaySeconds="${_duration.inSeconds.remainder(60)}";
    }
    // switch (widget.format) {
    //   case CountDownTimerFormat.daysHoursMinutesSeconds:
    //     displayDay="${_duration.inDays}";
    //     displayHours="${_duration.inHours.remainder(24)}";
    //     displayMinutes="${_duration.inMinutes.remainder(60)}";
    //     displaySeconds="${_duration.inSeconds.remainder(60)}";
    //   //  displayTime = '${_duration.inDays}d ${_duration.inHours.remainder(24)}h ${_duration.inMinutes.remainder(60)}m ${_duration.inSeconds.remainder(60)}s';
    //     break;
    //   case CountDownTimerFormat.hoursMinutesSeconds:
    //     displayTime =
    //     '${_duration.inHours}h ${_duration.inMinutes.remainder(60)}m ${_duration.inSeconds.remainder(60)}s';
    //     break;
    // }

    return Container(

      decoration: BoxDecoration(
        color: AppColor.yellowCircleColor,border: Border.all(color: AppColor.backGroundColor,width: 1),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*16,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*0),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                  CustomText(name: displayDay,fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                  CustomText(name: "Day",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                ],
              ),
            ),
          ),
     Container(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*1,color: AppColor.backGroundColor,),
          SizedBox(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*16,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*0),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                  CustomText(name: displayHours,fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                  CustomText(name: "Hours",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                ],
              ),
            ),
          ),
          Container(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*1,color: AppColor.backGroundColor,),
          SizedBox(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*16,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*0),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                  CustomText(
                      name: displayMinutes,
                      fontSize: SizeUtils.fSize_20(),
                      fontWeight: FontWeight.w400,
                      color: AppColor.backGroundColor),
                  CustomText(name: "Minutes",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                ],
              ),
            ),
          ),
          Container(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*1,color: AppColor.backGroundColor,),
          SizedBox(height: SizeUtils.verticalBlockSize*8,width: SizeUtils.horizontalBlockSize*16,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*0),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils.verticalBlockSize*1,),
                  CustomText(
                      name: displaySeconds,
                      fontSize: SizeUtils.fSize_20(),
                      fontWeight: FontWeight.w400,
                      color: AppColor.backGroundColor),
                  CustomText(name: "Second",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w400,color: AppColor.backGroundColor),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
