import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:morph/app.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task.dart';
import 'package:morph/pages/run/task_create_page.dart';
import 'package:morph/utils/ffmpeg/progress.dart';
import 'package:morph/widgets/app_notification/app_notification.dart';
import 'package:morph/widgets/expansion_list_tile.dart';
import 'package:path/path.dart' as path;

part 'config_list_view.dart';
part 'task_list_view.dart';
part 'tasks_provider.dart';

class ConvertPage extends ConsumerWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _ConfigListView(
            items: [
              _ListItem(
                icon: const Icon(Icons.video_file),
                title: "Video",
                children: [
                  _ListItemChild(
                    title: "MP4",
                    onTap: () async {
                      final result = await windowBodyNavigatorKey.currentContext
                          ?.appPush<List<FfmpegTask>>(TaskCreatePage());
                      if (result == null || result.isEmpty) return;
                      ref.read(_tasksProvider).addAll(result);
                    },
                  ),
                ],
              ),
              _ListItem(
                icon: const Icon(Icons.audio_file),
                title: "Audio",
                children: [],
              ),
            ],
          ),
        ),
        // TODO: Add a drag handle to resize the list view and task list view
        _DragHandle(onHorizontalDragUpdate: (details) => {}),
        Expanded(flex: 2, child: _TaskListView()),
      ],
    );
  }
}

class _DragHandle extends HookWidget {
  const _DragHandle({this.onHorizontalDragUpdate});

  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final isDragging = useState(false);
    final color = Theme.of(context).colorScheme.secondary;
    final hoverColor = color.withValues(alpha: 0.8);
    final defaultColor = color.withValues(alpha: 0.5);

    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragStart: (details) => isDragging.value = true,
      onHorizontalDragEnd: (details) => isDragging.value = false,
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        onEnter: (event) => isHovered.value = true,
        onExit: (event) => isHovered.value = false,
        child: SizedBox(
          height: 32,
          child: TweenAnimationBuilder(
            tween:
                isHovered.value || isDragging.value
                    ? ColorTween(begin: defaultColor, end: hoverColor)
                    : ColorTween(begin: hoverColor, end: defaultColor),
            duration: const Duration(milliseconds: 150),
            builder:
                (context, color, child) =>
                    VerticalDivider(color: color, thickness: 2, width: 16),
          ),
        ),
      ),
    );
  }
}
