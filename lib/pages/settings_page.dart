import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:morph/provider/app_config_provider.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ffmpegTextController = useTextEditingController(
      text: ref.read(appConfigProvider).ffmpegPath,
    );
    onTapPickFile() async {
      final result = await FilePicker.platform.pickFiles(
        type: Platform.isWindows ? FileType.custom : FileType.any,
        allowedExtensions: Platform.isWindows ? ['exe'] : null,
      );

      if (result == null) return null;
      final filePath = result.files.first.path;
      if (filePath == null) return null;

      ref.read(appConfigProvider.notifier).ffmpegPath = filePath;
      ffmpegTextController.text = filePath;
    }

    return ListView(
      children: [
        _ItemContainer(
          title: "FFmpeg Path",
          trailing: TextField(
            controller: ffmpegTextController,
            onSubmitted:
                (value) =>
                    ref.read(appConfigProvider.notifier).ffmpegPath = value,
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: onTapPickFile,
                icon: Icon(Icons.folder),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemContainer extends StatelessWidget {
  const _ItemContainer({required this.title, required this.trailing});

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250, minWidth: 120),
        child: trailing,
      ),
    );
  }
}
