import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:morph/models/ffmpeg/arg/preset/audio_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/common_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/extra_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/video_args.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task_config.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/json/cli_arg_json_converter.dart';
import 'package:path/path.dart' as p;

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key, this.config});

  final FfmpegTaskConfig? config;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final inputNotifier = _InputSetsNotifier({});
  late final _commonArgJson =
      (widget.config?.commonArgs ?? CommonArgs()).toJson();
  late final _videoArgJson = (widget.config?.videoArgs ?? VideoArgs()).toJson();
  late final _audioArgJson = (widget.config?.audioArgs ?? AudioArgs()).toJson();
  late final _extraArgJson = (widget.config?.extraArgs ?? ExtraArgs()).toJson();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputNotifier.dispose();
    super.dispose();
  }

  void addInput(Iterable<PlatformFile> files) {
    inputNotifier.addAll(files);
  }

  void removeInput(PlatformFile file) {
    inputNotifier.remove(file);
  }

  Future<void> onTapAddInput() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      lockParentWindow: true,
    );
    if (result == null) return;
    addInput(result.files);
  }

  void onTapSave() {
    final config = FfmpegTaskConfig(
      name: widget.config?.name ?? '',
      commonArgs: CommonArgs.fromJson(_commonArgJson),
      videoArgs: VideoArgs.fromJson(_videoArgJson),
      audioArgs: AudioArgs.fromJson(_audioArgJson),
      extraArgs: ExtraArgs.fromJson(_extraArgJson),
    );
    final tasks = <FfmpegTask>[
      for (final input in inputNotifier.value)
        FfmpegTask(
          inputPath: input.path!,
          // TODO: Set output path
          outputPath: p.withoutExtension(input.path!),
          config: config,
        ),
    ];
    Navigator.of(context).pop(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          widget.config == null ? "Create Task" : widget.config!.name,
        ),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: onTapSave),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        isScrollable: true,
                        physics: const NeverScrollableScrollPhysics(),
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(icon: Text("Common")),
                          Tab(icon: Text("Video")),
                          Tab(icon: Text("Audio")),
                        ],
                      ),
                      // TODO: Add button to add extra args
                      IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    ],
                  ),
                  Divider(thickness: 0.5, height: 0),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _ArgsListView(_commonArgJson),
                        _ArgsListView(_videoArgJson),
                        _ArgsListView(_audioArgJson),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(width: 0, thickness: 0.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Input Files",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: onTapAddInput,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: inputNotifier,
                    builder:
                        (context, child) => ListView.builder(
                          itemCount: inputNotifier.value.length,
                          itemBuilder: (context, index) {
                            final item = inputNotifier.value.elementAt(index);
                            return ListTile(
                              title: Text(item.name),
                              subtitle: Text(item.path!),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => removeInput(item),
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputSetsNotifier with ChangeNotifier {
  _InputSetsNotifier(this.value);

  final Set<PlatformFile> value;

  void addAll(Iterable<PlatformFile> files) {
    value.addAll(files);
    notifyListeners();
  }

  void remove(PlatformFile file) {
    value.remove(file);
    notifyListeners();
  }
}

class _ArgsListView<T> extends StatelessWidget {
  _ArgsListView(this.argJson)
    : extraArgJson = (argJson[_extraArgsKey] as List<JsonMap>?);

  final JsonMap argJson;
  final List<JsonMap>? extraArgJson;

  static const _extraArgsKey = "extraArgs";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var arg in argJson.entries)
          if (arg.key != _extraArgsKey)
            _ArgItem(
              name: arg.key,
              value: arg.value,
              onChanged: (value) {
                argJson[arg.key] = value;
              },
            )
          else if (extraArgJson?.isNotEmpty ?? false) ...[
            Text("Extra Arguments"),
            for (var arg in extraArgJson!.map(CliArgJsonConverter().fromJson))
              ListTile(
                title: Text(arg.name),
                trailing: arg.value != null ? Text(arg.value!) : null,
              ),
          ],
      ],
    );
  }
}

class _ArgItem<T> extends StatefulWidget {
  const _ArgItem({
    required this.name,
    required this.value,
    required this.onChanged,
  });

  final String name;
  final T value;
  final void Function(T value) onChanged;

  @override
  State<_ArgItem<T>> createState() => _ArgItemState<T>();
}

class _ArgItemState<T> extends State<_ArgItem<T>> {
  late var value = widget.value;

  @override
  Widget build(BuildContext context) {
    if (widget.value is bool) {
      return SwitchListTile(
        title: Text(widget.name),
        value: value as bool,
        onChanged: (value) {
          final newVal = value as T;
          widget.onChanged(newVal);
          setState(() {
            this.value = newVal;
          });
        },
      );
    }
    return ListTile(
      title: Text(widget.name),
      subtitle: widget.value == null ? null : Text(widget.value.toString()),
    );
  }
}
