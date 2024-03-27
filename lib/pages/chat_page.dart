import 'package:chat_room_learning/components/my_textField.dart';
import 'package:chat_room_learning/services/auth/auth_service.dart';
import 'package:chat_room_learning/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receverEmail;
  final String receverID;
  ChatPage({super.key, required this.receverEmail, required this.receverID});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  final TextEditingController _messageController = TextEditingController();

  //send message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _chatService.sendMessage(receverID, _messageController.text);
      _messageController.clear();
    }
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    //align message to the right if sendes is the current user, otherwise align to the left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(data["message"]),
          ],
        ));
  }

  //user input

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: Row(
        children: [
          //textfield
          Expanded(
            child: MyTextField(
                hintText: "send message",
                obscureText: false,
                controller: _messageController),
          ),

          //button
          Container(
              margin: const EdgeInsets.only(right: 25),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0)),
              child: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(receverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("Error: No data found");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //rteturn message list
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          receverEmail,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Column(
        children: [
          //message list
          Expanded(child: _buildMessageList()),

          //user input
          _buildUserInput()
        ],
      ),
    );
  }
}
