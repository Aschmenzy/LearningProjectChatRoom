// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chat_room_learning/components/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    );
  }
}
