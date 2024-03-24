// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:chat_room_learning/components/my_drawer.dart';
import 'package:chat_room_learning/components/my_user_tile.dart';
import 'package:chat_room_learning/pages/chat_page.dart';
import 'package:chat_room_learning/services/auth/auth_service.dart';
import 'package:chat_room_learning/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //build individual user list item
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except the current user
    return UserTile(
      text: userData["email"],
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receverEmail: userData["email"],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error: No data found");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
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
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Home",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }
}
