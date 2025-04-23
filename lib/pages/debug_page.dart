import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          ListTile(
            title: Text("Clear preferences"),
            onTap: () async {
              final sharePreferences = await SharedPreferences.getInstance();
              await sharePreferences.clear();
            },
          ),
        ],
      ),
    );
  }
}
