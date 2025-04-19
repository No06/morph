import 'package:flutter/material.dart';
import 'package:morph/widgets/app_notification/app_notification.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
    );
  }
}
