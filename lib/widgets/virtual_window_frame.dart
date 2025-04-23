import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart' as wm;

class VirtualWindowFrame extends StatelessWidget {
  const VirtualWindowFrame({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return wm.VirtualWindowFrame(
      child: Scaffold(appBar: _WindowCaption(), body: body),
    );
  }
}

class _WindowCaption extends StatelessWidget implements PreferredSizeWidget {
  const _WindowCaption();

  @override
  Widget build(BuildContext context) {
    return wm.WindowCaption();
  }

  @override
  Size get preferredSize => Size.fromHeight(wm.kWindowCaptionHeight);
}
