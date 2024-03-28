import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Settings",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text("Dark Mode"),

              //stiwthc toggle
              CupertinoSwitch(value: true, onChanged: (value) {})
            ],
          )
          //dark more
        ],
      ),
    );
  }
}
