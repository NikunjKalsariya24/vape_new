import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vape/model/conversation_chat_model.dart';
import 'package:vape/model/create_conversation_model.dart';
import 'package:vape/model/create_message_model.dart';
import 'package:vape/service/graph_ql_service.dart';
import 'package:vape/utils/app_colors.dart';
import 'package:vape/utils/shareprafrance.dart';
import 'package:vape/utils/size_utils.dart';
import 'package:vape/widget/custom_text.dart';

class MassageScreen extends StatefulWidget {
  const MassageScreen({super.key});

  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {
  CreateConversationData? createConversationModel;
  GraphQLService graphQLService=GraphQLService();
  SharedPrefService sharedPrefService=SharedPrefService();
  ConversationChatData? conversationChatModel;
  String? token;
  bool isConversation=false;
  CreateMessageData? createMessageModel;
  String? userid;

  String? shopId;

  TextEditingController massageController=TextEditingController();


   StreamController<List<ConversationMessageData>> _messageStreamController =StreamController<List<ConversationMessageData>>();
  // StreamController<List<ConversationMessageData>>();
  Timer? _timer;
  @override
  void dispose() {
    _messageStreamController.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageStreamController = StreamController<List<ConversationMessageData>>();
    getCreateConversation();
    _startTimer();
  }


  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      try {

        List<ConversationMessageData>? messages = await _fetchMessagesFromAPI();

        messages!.forEach((element) {
          print("api listmassage=======${element.body}");
        });

if(messages != null)
  {
    print("messagesSPP ${messages.length}");
    _messageStreamController.add(messages!);

    print("messagesSPP _messageStreamController  ${_messageStreamController.stream.length}");
  }

      } catch (error) {
        print('Error fetching messages: $error');
      }
    });
  }
  getCreateConversation() async {
    token = sharedPrefService.getToken();
    shopId="13";
    userid="43";
    setState(() {
      isConversation=true;
    });

    createConversationModel=await graphQLService.createConversation(token!,shopId!);


    //
    // conversationChatModel=await graphQLService.getConversation(token!, createConversationModel!.createConversation!.id!);


    setState(() {
      isConversation=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backGroundColor,
        appBar: AppBar(
            backgroundColor: AppColor.greenAppBarColor,
            centerTitle: false,
            elevation: 0,leadingWidth: SizeUtils.horizontalBlockSize*12,

            title: Row(
              children: [
                ClipOval(
                  child: SizedBox.square(
                      dimension: 22 * 2,
                      child: Image.asset(
                        "asset/images/support_image.png",
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )),
                ),

                SizedBox(width: SizeUtils.horizontalBlockSize*4,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  CustomText(name: "Mr. Customer",fontSize: SizeUtils.fSize_14(),fontWeight: FontWeight.w600,color: AppColor.backGroundColor,),
                  CustomText(name: "Active Now",fontSize: SizeUtils.fSize_10(),fontWeight: FontWeight.w500,color: AppColor.backGroundColor.withOpacity(0.65),)
                ],)
              ],
            ),
        actions: [

              IconButton(onPressed: () {

              }, icon: const Icon(Icons.add_call,color: AppColor.backGroundColor,)),
            PopupMenuButton(icon: const Icon(Icons.more_vert,color: AppColor.backGroundColor),itemBuilder: (context) {
              return [
                const PopupMenuItem(child: CustomText(name: "Create",)),
                const PopupMenuItem(child: CustomText(name: "Cancle",)),
              ];
            },)

        ],
        ),
        body: isConversation?const Center(child: CircularProgressIndicator()):
        Container(
          child: ListView(shrinkWrap: true,reverse: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                //  SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // if (conversationChatModel != null && conversationChatModel!.messages != null)
                        //   Container(
                        //     height: MediaQuery.of(context).size.height,
                        //     child: ListView.builder(
                        //       shrinkWrap: true,
                        //       reverse: true,
                        //       scrollDirection: Axis.vertical,
                        //       itemCount: conversationChatModel!.messages!.data!.length,
                        //       itemBuilder: (context, index) {
                        //
                        //         print("userid=====${conversationChatModel!.messages!.data![index].userId}");
                        //         return Column(
                        //           children: [
                        //             Align(
                        //               alignment:  conversationChatModel!.messages!.data![index].userId==userid!?Alignment.topRight:Alignment.topLeft,
                        //               child: Padding(
                        //                 padding: EdgeInsets.only(left: conversationChatModel!.messages!.data![index].userId==userid!?SizeUtils.horizontalBlockSize * 10:SizeUtils.horizontalBlockSize * 0,
                        //                 right:conversationChatModel!.messages!.data![index].userId==userid!?SizeUtils.horizontalBlockSize * 0:SizeUtils.horizontalBlockSize * 10, ),
                        //                 child: Container(
                        //                   decoration: BoxDecoration(color: AppColor.supportColor, borderRadius: BorderRadius.circular(10)),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        //                     child: Row(
                        //                       mainAxisSize: MainAxisSize.min,
                        //                       crossAxisAlignment: CrossAxisAlignment.end,
                        //                       mainAxisAlignment: MainAxisAlignment.end,
                        //                       children: [
                        //                         CustomText(name: "${conversationChatModel!.messages!.data![index].body}", fontSize: SizeUtils.fSize_12(), fontWeight: FontWeight.w500, color: AppColor.blackColor),
                        //                         SizedBox(width: SizeUtils.horizontalBlockSize * 10,),
                        //                         CustomText(name: "12:01 PM", fontSize: SizeUtils.fSize_6(), fontWeight: FontWeight.w500, color: AppColor.blackColor.withOpacity(0.60)),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ),
                    StreamBuilder<List<ConversationMessageData>>(
                    stream: _messageStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: Expanded(child: Container(child: CircularProgressIndicator())));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No messages yet'));
                        } else {
                          return Container(height: MediaQuery.of(context).size.height,
                            child: ListView.builder(shrinkWrap: true,reverse: true,scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                              print("snapshot.data!.length ${snapshot.data!.length}");
                                final message = snapshot.data![index];

                              print("snapshot.message ${message.body}");
                                return   Column(
                                  children: [
                                    Align(
                                      alignment:  message.userId==userid!?Alignment.topRight:Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: message.userId==userid!?SizeUtils.horizontalBlockSize * 10:SizeUtils.horizontalBlockSize * 0,
                                          right:message.userId==userid!?SizeUtils.horizontalBlockSize * 0:SizeUtils.horizontalBlockSize * 10, ),
                                        child: Container(
                                          decoration: BoxDecoration(color: AppColor.supportColor, borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                CustomText(name: "${message.body}", fontSize: SizeUtils.fSize_12(), fontWeight: FontWeight.w500, color: AppColor.blackColor),
                                                SizedBox(width: SizeUtils.horizontalBlockSize * 10,),
                                                CustomText(name: "12:01 PM", fontSize: SizeUtils.fSize_6(), fontWeight: FontWeight.w500, color: AppColor.blackColor.withOpacity(0.60)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                                  ],
                                );
                                //if (conversationChatModel != null && conversationChatModel!.messages != null)
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      reverse: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: conversationChatModel!.messages!.data!.length,
                                      itemBuilder: (context, index) {

                                        return Column(
                                          children: [
                                            Align(
                                              alignment:  message.userId==userid!?Alignment.topRight:Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: message.userId==userid!?SizeUtils.horizontalBlockSize * 10:SizeUtils.horizontalBlockSize * 0,
                                                  right:message.userId==userid!?SizeUtils.horizontalBlockSize * 0:SizeUtils.horizontalBlockSize * 10, ),
                                                child: Container(
                                                  decoration: BoxDecoration(color: AppColor.supportColor, borderRadius: BorderRadius.circular(10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        CustomText(name: "${message.body}", fontSize: SizeUtils.fSize_12(), fontWeight: FontWeight.w500, color: AppColor.blackColor),
                                                        SizedBox(width: SizeUtils.horizontalBlockSize * 10,),
                                                        CustomText(name: "12:01 PM", fontSize: SizeUtils.fSize_6(), fontWeight: FontWeight.w500, color: AppColor.blackColor.withOpacity(0.60)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                  // subtitle: Text(message.timestamp),
                              //  );
                              },
                            ),
                          );
                        }
                      },
                    ),


        ]
                    )

                  ),


                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.textFieldColor)),
                    child: Row(
                      children: [
                        Flexible(child: TextFormField(controller: massageController, decoration: InputDecoration.collapsed(hintText: 'Type Message'), focusNode: FocusNode(),)),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.attachment_rounded)),
                        IconButton(onPressed: () async {
                          if (massageController.text.trim().isNotEmpty) {
                            String massage = massageController.text.trim();
                            createMessageModel = await graphQLService.createMassage(token!, createConversationModel!.createConversation!.id!, "${massage}");
                            if (createMessageModel!.createMessage!.body == massageController.text) {
                              massageController.clear();
                              conversationChatModel = await graphQLService.getConversation(token!, createConversationModel!.createConversation!.id!);
                              setState(() {});
                            }
                          }
                        }, icon: const Icon(Icons.send))
                      ],
                    ),
                  ),
                  SizedBox(height: SizeUtils.verticalBlockSize * 1,),
                      ],
                    ),

          ]




              ),
    )  ));


        // ListView(children: [
        //   Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,children: [
        //
        //     SizedBox(height: SizeUtils.verticalBlockSize*1,),
        //
        //
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize*6),
        //       child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
        //         children: [
        //
        //
        //           Container(height: MediaQuery.of(context).size.height,
        //             child: ListView.builder(shrinkWrap: true,reverse: true,scrollDirection: Axis.vertical,itemCount: conversationChatModel!.messages!.data!.length,itemBuilder: (context, index) {
        //               return Column(children: [
        //                 Align(alignment: Alignment.topRight,
        //                   child: Padding(
        //                     padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize*10),
        //                     child: Container(decoration: BoxDecoration(color: AppColor.supportColor,borderRadius: BorderRadius.circular(10)),child: Padding(
        //                       padding:const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
        //                       child: Row(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           CustomText(name: "${conversationChatModel!.messages!.data![index].body}",fontSize: SizeUtils.fSize_12(),fontWeight: FontWeight.w500,color: AppColor.blackColor),
        //
        //                           SizedBox(width: SizeUtils.horizontalBlockSize*10,),
        //                           CustomText(name: "12:01 PM",fontSize: SizeUtils.fSize_6(),fontWeight: FontWeight.w500,color: AppColor.blackColor.withOpacity(0.60)),
        //
        //                         ],
        //                       ),
        //                     )),
        //                   ),
        //                 ),
        //                 SizedBox(height: SizeUtils.verticalBlockSize*1,),
        //               ],);
        //             },),
        //           ),
        //
        //
        //         ],
        //       ),
        //     ),
        //     Expanded(child: Container()),
        //
        //
        //     Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: AppColor.textFieldColor)),child:
        //     Row(children: [
        //       Flexible(child: TextFormField( controller: massageController,        decoration:
        //       InputDecoration.collapsed(hintText: 'Type Message'),focusNode: FocusNode(),)),
        //       IconButton(onPressed: () {
        //
        //       }, icon: const Icon(Icons.attachment_rounded)),
        //
        //       IconButton(onPressed: () async {
        //         if(massageController.text.trim().isNotEmpty)
        //         {
        //           String massage=massageController.text.trim();
        //
        //           createMessageModel= await graphQLService.createMassage(token!,createConversationModel!.createConversation!.id!,"${massage}");
        //           if(createMessageModel!.createMessage!.body==massageController.text)
        //           {
        //
        //             massageController.clear();
        //             conversationChatModel=await graphQLService.getConversation(token!, createConversationModel!.createConversation!.id!);
        //             setState(() {
        //
        //             });
        //           }
        //         }
        //
        //
        //
        //       }, icon: const Icon(Icons.send))
        //     ])
        //     ),
        //     SizedBox(height: SizeUtils.verticalBlockSize*1,),
        //
        //
        //
        //   ]),
        //
        // ],
        //
        // ),
     // ),
   // );
  }
  Future<List<ConversationMessageData>?> _fetchMessagesFromAPI() async {
    conversationChatModel =
    await graphQLService.getConversation(token!, createConversationModel!.createConversation!.id!);



    print("conversationChatmassage====${conversationChatModel!.messages!.data!.length}");
    List<ConversationMessageData>? conversationChat = conversationChatModel!.messages!.data;
    conversationChat!.forEach((element) {

      element.body;
      print("element.body====${element.body}");
    });

    print("conversationChat====${conversationChat}");
    return Future.delayed(Duration(milliseconds: 500), () => conversationChat);


  }

}
