import 'package:chat_room_learning/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBublle extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBublle(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.grey.shade500)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
