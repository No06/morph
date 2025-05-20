import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:morph/models/ffmpeg/arg/preset/audio_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/common_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/extra_args.dart';
import 'package:morph/models/ffmpeg/arg/preset/video_args.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task.dart';
import 'package:morph/models/ffmpeg/task/ffmpeg_task_config.dart';
import 'package:morph/models/json_map.dart';
import 'package:morph/utils/form_validator.dart';
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
  late final _commonArg = (widget.config?.commonArgs ?? CommonArgs()).toJson();
  late final _videoArg = (widget.config?.videoArgs ?? VideoArgs()).toJson();
  late final _audioArg = (widget.config?.audioArgs ?? AudioArgs()).toJson();
  late final _extraArg = (widget.config?.extraArgs ?? ExtraArgs()).toJson();

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
      commonArgs: CommonArgs.fromJson(_commonArg),
      videoArgs: VideoArgs.fromJson(_videoArg),
      audioArgs: AudioArgs.fromJson(_audioArg),
      extraArgs: ExtraArgs.fromJson(_extraArg),
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
            child: ClipRect(
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
                          _ArgsListView(args: _commonArg, onChanged: () {}),
                          _ArgsListView(args: _videoArg, onChanged: () {}),
                          _ArgsListView(args: _audioArg, onChanged: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
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

class _ArgsListView extends StatefulWidget {
  const _ArgsListView({required this.args, required this.onChanged});

  final JsonMap args;
  final void Function() onChanged;

  @override
  State<_ArgsListView> createState() => _ArgsListViewState();
}

class _ArgsListViewState extends State<_ArgsListView> {
  void _onTapAddExtraArg(BuildContext context) async {
    final result = await _ExtraArgDialog.show(context);
    if (result == null) return;
    if (widget.args['extraArgs'] == null) {
      widget.args['extraArgs'] = [];
    }
    setState(() {
      widget.args['extraArgs']?.add(CliArgJsonConverter().toJson(result));
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final extraArgs = (widget.args['extraArgs'] as List?)?.cast<JsonMap>();
    final extraArgsCount = extraArgs?.length ?? 0;
    final extraArgsItems = List<_ArgItem?>.filled(extraArgsCount, null);

    final argsCount = widget.args.length - 1; // -1 for extraArgs
    final argsItems = List<_ArgItem?>.filled(argsCount, null);

    final argEntries = widget.args.entries;
    var isExtraArgAlreadyAdded = false;
    for (var i = 0; i < argEntries.length; i++) {
      final entry = argEntries.elementAt(i);
      // Handle extraArgs separately
      if (!isExtraArgAlreadyAdded && entry.key == "extraArgs") {
        isExtraArgAlreadyAdded = true;
        for (var i = 0; i < extraArgsCount; i++) {
          final extraArg = extraArgs![i];
          extraArgsItems[i] = _ArgItem(
            name: extraArg.values.elementAt(0),
            value: extraArg.values.elementAt(1),
            onChanged: (value) {
              extraArg[extraArg.keys.first] = value;
              widget.onChanged();
            },
          );
        }
      } else {
        // Handle other args
        argsItems[isExtraArgAlreadyAdded ? i - 1 : i] = _ArgItem(
          name: entry.key,
          value: entry.value,
          onChanged: (value) {
            widget.args[entry.key] = value;
            widget.onChanged();
          },
        );
      }
    }

    return SizedBox.expand(
      child: Stack(
        children: [
          ListView(
            children: [
              ...argsItems.cast<_ArgItem>(),
              if (extraArgsItems.isNotEmpty) ...[
                const Divider(thickness: 0.5, height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Extra Arguments",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ...extraArgsItems.cast<_ArgItem>(),
              ],
              // FloatingActionButton space
              SizedBox(height: 32),
            ],
          ),
          Align(
            alignment: Alignment(0.9, 0.9),
            child: FloatingActionButton(
              onPressed: () => _onTapAddExtraArg(context),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArgItem<T> extends HookWidget {
  const _ArgItem({
    super.key,
    required this.name,
    required this.value,
    required this.onChanged,
  });

  final String name;
  final T value;
  final void Function(T value) onChanged;

  @override
  Widget build(BuildContext context) {
    final valueState = useState(this.value);
    final value = valueState.value;

    if (value is bool) {
      return SwitchListTile(
        title: Text(name),
        value: value as bool,
        onChanged: (newVal) {
          onChanged(newVal as T);
          valueState.value = newVal as T;
        },
      );
    }

    final valueIsNull = value == null;
    final textController = useTextEditingController(
      text: valueIsNull ? "" : value.toString(),
    );
    return ListTile(
      title: Text(name),
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 120),
        child: TextField(
          controller: textController,
          readOnly: !valueIsNull,
          decoration: InputDecoration(hintText: valueIsNull ? "Default" : null),
        ),
      ),
    );
  }
}

class _ExtraArgDialog extends HookWidget {
  const _ExtraArgDialog();

  static Future<CliArg?> show(BuildContext context) => showDialog<CliArg>(
    context: context,
    builder: (context) => const _ExtraArgDialog(),
  );

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final valueController = useTextEditingController();
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text("Add Extra Argument"),
      actions: [
        TextButton(onPressed: Navigator.of(context).pop, child: Text("Cancel")),
        FilledButton(
          onPressed: () {
            final name = nameController.text;
            final value = valueController.text;
            Navigator.of(context).pop(CliArg(name: name, value: value));
          },
          child: Text("Add"),
        ),
      ],
      scrollable: true,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Name"),
              validator: FormValidator.notEmpty,
            ),
            TextFormField(
              controller: valueController,
              decoration: InputDecoration(hintText: "Value"),
              validator: FormValidator.notEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
