import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String value, required String email}){
    messages.add({
      'createdAt' : DateTime.now(),
      'id' : email,
      'messages' : value
    });
  }

  void getMessages(){
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for(var doc in event.docs){
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messageList: messageList));
    });
  }
}
