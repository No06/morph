part of 'run_page.dart';

final _tasksProvider = ChangeNotifierProvider((ref) => _TasksNotifier([]));

class _TasksNotifier with ChangeNotifier {
  _TasksNotifier(this.tasks);

  final List<FfmpegTask> tasks;

  void add(FfmpegTask task) {
    tasks.add(task);
    notifyListeners();
  }

  void addAll(Iterable<FfmpegTask> tasks) {
    this.tasks.addAll(tasks);
    notifyListeners();
  }

  void remove(FfmpegTask task) {
    tasks.remove(task);
    notifyListeners();
  }
}
