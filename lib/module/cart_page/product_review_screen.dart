import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vape/routes.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';
import 'package:vape/widget/custom_textfield.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
         body: Padding(
           padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*3),
           child: SingleChildScrollView(
             child: Column(children: [
               SizedBox(height: SizeUtils.verticalBlockSize*2,),
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(color: AppColor.orderColor),
                   boxShadow: [
                     BoxShadow(
                       offset: const Offset(0, 1), // X, Y
                       blurRadius: 25, // Blur
                       spreadRadius: 0, // Spread
                       color: AppColor.backGroundColor
                           .withOpacity(0.08), // Color with Opacity
                     ),
                   ],
                 ),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: EdgeInsets.symmetric(
                           vertical: SizeUtils.verticalBlockSize * 2),
                       child: Image.asset(
                         "asset/images/shoes.png",
                         width: SizeUtils.verticalBlockSize * 12,
                         //height: SizeUtils.verticalBlockSize*17
                       ),
                     ),
                     SizedBox(
                       width: SizeUtils.horizontalBlockSize * 3,
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(
                           height: SizeUtils.verticalBlockSize * 1,
                         ),
                         SizedBox(
                           width: SizeUtils.horizontalBlockSize * 58,
                           child: CustomText(
                               name: "Bourge Mens Vega-m1 Running Shoes",
                               fontSize: SizeUtils.fSize_13(),
                               maxLines: 2,
                               fontWeight: FontWeight.w600,
                               color: AppColor.blackColor),
                         ),
                         SizedBox(height: SizeUtils.verticalBlockSize * 1),
                         CustomText(name: "Van Heusen",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w700,color: AppColor.blueOrderColor),
                         SizedBox(height: SizeUtils.verticalBlockSize * 1),


                         Row(
                           children: [
                             CustomText(
                               name: "Rs 1025.0",
                               fontSize: SizeUtils.fSize_12(),
                               fontWeight: FontWeight.w700,
                               color: AppColor.blackColor,
                             ),
                            SizedBox(width: SizeUtils.horizontalBlockSize*3,),
                             CustomText(
                               name: "Rs 1200.0",decoration: TextDecoration.lineThrough,
                               fontSize: SizeUtils.fSize_12(),
                               fontWeight: FontWeight.w400,
                               color: AppColor.blackReviewColor,
                             ),
                           ],
                         ),
                         SizedBox(height: SizeUtils.verticalBlockSize * 1),
                         Row(
                           children: [
                             Row(
                               children: [
                                 CustomText(
                                     name: "QTY:",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackReviewColor),
                                 CustomText(
                                     name: "05",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackColor),
                               ],
                             ),
                             SizedBox(
                               width: SizeUtils.horizontalBlockSize * 2,
                             ),
                             Row(
                               children: [
                                 CustomText(
                                     name: "Color:",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackReviewColor),
                                 CustomText(
                                     name: "Gray",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackColor),
                               ],
                             ),
                             SizedBox(
                               width: SizeUtils.horizontalBlockSize * 4,
                             ),
                             Row(
                               children: [
                                 CustomText(
                                     name: "Size:",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackReviewColor),
                                 CustomText(
                                     name: " L",
                                     fontSize: SizeUtils.fSize_11(),
                                     fontWeight: FontWeight.w400,
                                     color: AppColor.blackColor),
                               ],
                             ),

                           ],
                         ),
                         SizedBox(height: SizeUtils.verticalBlockSize * 1),
                         // isSuccess?Row(children: [
                         //   GestureDetector(onTap: () {
                         //     Get.toNamed(Routes.productReviewScreen);
                         //   },
                         //     child: Container(
                         //         height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*26,
                         //         decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                         //             boxShadow: const [
                         //               BoxShadow(
                         //                 color: Color(0xFFB5B5B5), // Your shadow color
                         //                 offset: Offset(0, 0), // X and Y offset
                         //                 blurRadius: 4, // Blur radius
                         //                 spreadRadius: 0, // Spread radius
                         //               ),
                         //             ],
                         //             borderRadius: BorderRadius.circular(3),
                         //             border: Border.all(
                         //                 color:
                         //                 AppColor.greenBorderColor)),
                         //         child: Center(
                         //           child: CustomText(
                         //             name: "Review",
                         //             fontSize: SizeUtils.fSize_12(),
                         //             fontWeight: FontWeight.w500,
                         //           ),
                         //         )),
                         //   ),
                         //   SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                         //   Container(
                         //       height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*30,
                         //       decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                         //           boxShadow: const [
                         //             BoxShadow(
                         //               color: Color(0xFFB5B5B5), // Your shadow color
                         //               offset: Offset(0, 0), // X and Y offset
                         //               blurRadius: 4, // Blur radius
                         //               spreadRadius: 0, // Spread radius
                         //             ),
                         //           ],
                         //           borderRadius: BorderRadius.circular(3),
                         //           border: Border.all(
                         //               color:
                         //               AppColor.orderBorderPinkColor)),
                         //       child: Center(
                         //         child: CustomText(
                         //           name: "Refund request",
                         //           fontSize: SizeUtils.fSize_12(),
                         //           fontWeight: FontWeight.w500,
                         //         ),
                         //       )),
                         //
                         //
                         //
                         // ],):       Container(
                         //     height: SizeUtils.verticalBlockSize*4,width: SizeUtils.horizontalBlockSize*28,
                         //     decoration: BoxDecoration(   color: Colors.white, // Set your container background color
                         //         boxShadow: const [
                         //           BoxShadow(
                         //             color: Color(0xFFB5B5B5), // Your shadow color
                         //             offset: Offset(0, 0), // X and Y offset
                         //             blurRadius: 4, // Blur radius
                         //             spreadRadius: 0, // Spread radius
                         //           ),
                         //         ],
                         //         borderRadius: BorderRadius.circular(3),
                         //         border: Border.all(
                         //             color:
                         //             AppColor.orderBorderPinkColor)),
                         //     child: Center(
                         //       child: CustomText(
                         //         name: "Cancel Order",
                         //         fontSize: SizeUtils.fSize_12(),
                         //         fontWeight: FontWeight.w500,
                         //       ),
                         //     )),
                         const SizedBox(height: 5,),
                       ],
                     ),
                   ],
                 ),
               ),
               SizedBox(height: SizeUtils.verticalBlockSize*4,),
               Container(decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8),
                 color: AppColor.backGroundColor,
                 boxShadow: const [
                   BoxShadow(
                     color: Color.fromRGBO(0, 0, 0, 0.08),
                     offset: Offset(0, 1),
                     blurRadius: 25,
                     spreadRadius: 0,
                   ),
                 ],

               ),
               child: Padding(
                 padding: EdgeInsets.only(left:  SizeUtils.horizontalBlockSize*3),
                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: SizeUtils.verticalBlockSize*1,),
                     Row(
                       children: [
                         SizedBox(width: SizeUtils.horizontalBlockSize*1,),
                         CustomText(name: "Give Ratting",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w500,color: AppColor.blackColor,),
                       ],
                     ),
                     SizedBox(height: SizeUtils.verticalBlockSize*1,),
                     RatingBar.builder(
                       initialRating: 0,
                       minRating: 0,
                       direction: Axis.horizontal,
                       allowHalfRating: true,
                       itemCount: 5,
                       itemSize: SizeUtils.verticalBlockSize*6,
                       ignoreGestures: false,
                       itemBuilder: (context, _) =>
                       const Icon(
                         Icons.star,
                         color: AppColor.yellowColor,
                       ),
                       onRatingUpdate: (rating) {
                         print(rating); // Use the updated rating here
                       },
                     ),
                     SizedBox(height: SizeUtils.verticalBlockSize*4,),

                   ],

                 ),
               ),),
               SizedBox(height: SizeUtils.verticalBlockSize*4,),

               Container(width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   color: AppColor.backGroundColor,
                   boxShadow: const [
                     BoxShadow(
                       color: Color.fromRGBO(0, 0, 0, 0.08),
                       offset: Offset(0, 1),
                       blurRadius: 25,
                       spreadRadius: 0,
                     ),
                   ],

                 ),
                 child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                   SizedBox(height: SizeUtils.verticalBlockSize*1,),
                      Image.asset("asset/images/upload_image.png",height: SizeUtils.verticalBlockSize*8),
                   CustomText(name: "Upload Image OR Video",fontSize: SizeUtils.fSize_20(),fontWeight: FontWeight.w500,color: AppColor.blackColor,),
                   SizedBox(height: SizeUtils.verticalBlockSize*2,),
                 ]),
               ),
               SizedBox(height: SizeUtils.verticalBlockSize*4,),


             // CustomTextField(filled: true,fillColor: AppColor.orderColor.withOpacity(0.8), border: OutlineInputBorder(
             //   borderSide:
             //   BorderSide.none, //
             // ),
             //   enabledBorder: OutlineInputBorder(
             //     borderSide:
             //     BorderSide.none,
             //   ),
             //   focusedBorder: OutlineInputBorder(
             //     borderSide:
             //     BorderSide.none,
             //   ),)
             Container(height: SizeUtils.verticalBlockSize*20,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8),
                 color: AppColor.backGroundColor,
                 boxShadow: const [
                   BoxShadow(
                     color: Color.fromRGBO(0, 0, 0, 0.08),
                     offset: Offset(0, 1),
                     blurRadius: 25,
                     spreadRadius: 0,
                   ),
                 ],

               ),
child: TextFormField( autofocus: false, maxLines: null,
   style: GoogleFonts.inter(
    fontSize: SizeUtils.fSize_13(), fontWeight: FontWeight.w500,color:AppColor.blackColor),
  decoration: const InputDecoration(isDense: true, border: OutlineInputBorder(
    borderSide:
    BorderSide.none, //
  ),
    enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
      BorderSide.none,
    ),),
),
             ),
SizedBox(height: SizeUtils.verticalBlockSize*2,),

               Align(alignment: Alignment.bottomCenter,child: GestureDetector(onTap: () {



                 Get.offAllNamed(Routes.homeScreen);


               },child: Container(height: SizeUtils.verticalBlockSize*6,decoration: BoxDecoration(color: AppColor.orangeColor,borderRadius: BorderRadius.circular(6)),child: Center(child: CustomText(name: "Submit Review",fontSize: SizeUtils.fSize_24(),fontWeight: FontWeight.w700,color: AppColor.backGroundColor,))))),

               SizedBox(height: SizeUtils.verticalBlockSize*1,),
             ]),
           ),
         ),
      ),
    );
  }
}
