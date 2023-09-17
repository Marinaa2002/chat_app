import 'dart:ui';
import 'package:chat2_app/screens/chat_cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat2_app/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message.dart';
import '../widgets/customChatBubble.dart';


import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chat2_app/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/message.dart';
import '../widgets/customChatBubble.dart';

class ChatPage extends StatelessWidget {

  static String id = 'ChatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          List<Message> messageList = [];
          for(int i = 0; i<snapshot.data!.docs.length; i++){
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    Text('Chat'),
                  ])),
              backgroundColor: kPrimaryColor,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id ==email? CustomChatBubble(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32)),
                        message: messageList[index], alignment: Alignment.centerLeft,):
                      CustomChatBubble(
                        alignment: Alignment.centerRight,
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                            bottomLeft: Radius.circular(32)),
                        message: messageList[index],);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) async{
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      });
                      messages.add({
                        'messages' : value,
                        'createdAt' : DateTime.now(),
                        'id' : email
                      });
                      controller.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(Icons.send, color: kPrimaryColor,),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 3
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 3
                          )
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        else{
          return Text('Loading');
        }
      },
    );
  }
}




/*class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();

  CollectionReference messages =
  FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email  = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 50,
                  ),
                  Text('chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return (messagesList[index].id).toString() == email ?
                        CustomChatBubble(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                              bottomRight: Radius.circular(32)),
                          alignment: Alignment.centerRight,
                          message: messagesList[index],
                        )
                            : CustomChatBubble(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32)),
                          alignment: Alignment.centerLeft,
                          message: messagesList[index],
                        );
                        /*ChatBuble(
                          message: messagesList[index],
                        ) : ChatBubbleForFriend(message: messagesList[index]);*/
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {'messages': data, 'createdAt': DateTime.now(), 'id' : email },

                      );
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}

*/








/*class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  ScrollController _scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/scholar.png',
            height: 50,
          ),
          Text('Chat'),
        ])),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) messageList = state.messageList;
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? CustomChatBubble(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomRight: Radius.circular(32)),
                            alignment: Alignment.centerRight,
                            message: messageList[index],
                          )
                        : CustomChatBubble(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                                bottomLeft: Radius.circular(32)),
                            alignment: Alignment.centerLeft,
                            message: messageList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(value: value, email: email);
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                });

                controller.clear();
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: kPrimaryColor, width: 3)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: kPrimaryColor, width: 3)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/