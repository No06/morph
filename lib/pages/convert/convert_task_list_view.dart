part of 'convert_page.dart';

class _ConvertTaskListView extends StatelessWidget {
  const _ConvertTaskListView();

  @override
  Widget build(BuildContext context) {
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
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
        Expanded(child: ListView(padding: EdgeInsets.all(16), children: [])),
      ],
    );
  }
}
