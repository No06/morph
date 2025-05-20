import 'package:flutter/material.dart';
import 'package:morph/widgets/app_notification/app_notification.dart';
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
          ListTile(
            title: Text("通知测试"),
            onTap:
                () => AppNotification.info(
                  title: "通知标题",
                  content: "通知内容",
                  duration: Duration(seconds: 3),
                  dismissible: true,
                ).show(context),
          ),
        ],
      ),
    );
  }
}
