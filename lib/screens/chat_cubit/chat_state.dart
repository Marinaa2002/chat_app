part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatSuccess extends ChatState {
  List<Message> messageList;

  ChatSuccess({required this.messageList});
}
