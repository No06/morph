part of 'run_page.dart';

class _ConfigListView extends StatelessWidget {
  const _ConfigListView({required this.items});

  final List<_ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _ListItemBuilder(item: item);
        },
      ),
    );
  }
}

class _ListItemBuilder extends HookWidget {
  const _ListItemBuilder({required this.item});

  final _ListItem item;

  @override
  Widget build(BuildContext context) {
    final isExpaned = useState(false);
    final iconRotateAngle = pi;
    return ExpansionListTile(
      isExpaned: isExpaned.value,
      title: ListTile(
        leading: item.icon,
        title: Text(item.title),
        trailing: TweenAnimationBuilder(
          tween:
              isExpaned.value
                  ? Tween<double>(begin: 0, end: iconRotateAngle)
                  : Tween<double>(begin: iconRotateAngle, end: 0),
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          builder: (context, angle, child) {
            return Transform.rotate(angle: angle, child: child);
          },
          child: const Icon(Icons.expand_less),
        ),
        onTap: () => isExpaned.value = !isExpaned.value,
      ),
      child: Column(
        children: List.generate(item.children.length, (index) {
          final child = item.children[index];
          return ListTile(
            leading: child.icon ?? const SizedBox(),
            title: Text(child.title),
            onTap: child.onTap,
          );
        }),
      ),
    );
  }
}

class _ListItem {
  const _ListItem({
    required this.icon,
    required this.title,
    required this.children,
  });

  final Icon icon;
  final String title;
  final List<_ListItemChild> children;
}

class _ListItemChild {
  const _ListItemChild({required this.title, this.icon, this.onTap});

  final Icon? icon;
  final String title;
  final VoidCallback? onTap;
}
