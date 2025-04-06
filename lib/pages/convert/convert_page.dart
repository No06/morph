import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:morph/app.dart';
import 'package:morph/pages/task_create_page.dart';
import 'package:morph/widgets/expansion_list_tile.dart';
import 'package:page_transition/page_transition.dart';

part 'convert_list_view.dart';
part 'convert_task_list_view.dart';

class ConvertPage extends HookWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Container(
            child: _ConvertListView(
              items: [
                _ListItem(
                  icon: const Icon(Icons.video_file),
                  title: "Video",
                  children: [
                    _ListItemChild(
                      title: "MP4",
                      onTap:
                          () => rootNavigatorKey.currentContext?.pushTransition(
                            type: PageTransitionType.rightToLeft,
                            curve: Curves.fastEaseInToSlowEaseOut,
                            duration: const Duration(milliseconds: 500),
                            child: TaskCreatePage(),
                          ),
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
        ),
        _DragHandle(),
        Expanded(child: _ConvertTaskListView()),
      ],
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(20),
      child: child,
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: VerticalDivider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
        width: 16,
      ),
    );
  }
}
