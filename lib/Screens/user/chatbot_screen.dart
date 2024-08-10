import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentuser = ChatUser(id: '0', firstName: 'User');
  ChatUser geminiuser = ChatUser(id: '1', firstName: 'Gemini');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
          currentUser: currentuser, onSend: _sendmessage, messages: messages),
    );
  }

  void _sendmessage(ChatMessage chatmessage) {
    setState(() {
      messages = [chatmessage, ...messages];
    });
    try {
      String question = chatmessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastmessage = messages.firstOrNull;
        if (lastmessage != null && lastmessage.user == geminiuser) {
          lastmessage = messages.removeAt(0);
          String responce = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          lastmessage.text += responce;
          setState(() {
            messages = [lastmessage!, ...messages];
          });
        } else {
          String responce = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          ChatMessage message = ChatMessage(
            user: geminiuser,
            createdAt: DateTime.now(),
            text: responce,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
