part of 'run_page.dart';

class _TaskListView extends ConsumerWidget {
  const _TaskListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.read(_tasksProvider).tasks;

    void onTapAdd() async {
      final result = await windowBodyNavigatorKey.currentContext
          ?.appPush<List<FfmpegTask>>(TaskCreatePage());
      if (result == null || result.isEmpty) return;
      ref.read(_tasksProvider).addAll(result);
    }

    void onTapStart() {
      if (tasks.isEmpty) {
        AppNotification.info(title: "No tasks to start").show(context);
        return;
      }

      final ffmpegPath = ref.read(appConfigProvider).ffmpegPath;
      if (ffmpegPath == null || ffmpegPath.isEmpty) {
        AppNotification.error(title: "FFmpeg path is not set").show(context);
        return;
      }

      for (final task in tasks) {
        task.run(ffmpegPath: ffmpegPath);
      }
    }

    void onTapStop() {
      for (final task in tasks) {
        task.stop();
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Tasks", style: Theme.of(context).textTheme.titleLarge),
                  Spacer(),
                  IconButton(onPressed: onTapAdd, icon: Icon(Icons.add)),
                  IconButton(
                    onPressed: onTapStart,
                    icon: Icon(Icons.play_arrow),
                  ),
                  IconButton(onPressed: onTapStop, icon: Icon(Icons.stop)),
                ],
              ),
              Divider(
                height: 16,
                thickness: 0.5,
                endIndent: 8,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
        Expanded(child: _TaskItemListView()),
      ],
    );
  }
}

class _TaskItemListView extends ConsumerWidget {
  const _TaskItemListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(_tasksProvider).tasks;
    return Material(
      child: ListView.builder(
        padding: const EdgeInsets.only(right: 16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _TaskItemBuilder(task: task);
        },
      ),
    );
  }
}

class _TaskItemBuilder extends ConsumerStatefulWidget {
  const _TaskItemBuilder({required this.task});

  final FfmpegTask task;

  @override
  ConsumerState<_TaskItemBuilder> createState() => _TaskItemBuilderState();
}

class _TaskItemBuilderState extends ConsumerState<_TaskItemBuilder>
    with TaskListener {
  @override
  void initState() {
    super.initState();
    widget.task.addListener(this);
  }

  @override
  void dispose() {
    widget.task.removeListener(this);
    super.dispose();
  }

  // TODO: implement
  void onTap() {}

  void onTapDelete() {
    ref.read(_tasksProvider).remove(widget.task);
  }

  @override
  void onProgress(Progress progress) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.task.progress.percentage;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(path.basename(widget.task.inputPath)),
          subtitle: Text(widget.task.inputPath),
          onTap: onTap,
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onTapDelete,
          ),
        ),
        if (progress != null)
          LinearProgressIndicator(
            value: progress,
            color: widget.task.isCompleted ? Colors.green : null,
          ),
      ],
    );
  }
}
