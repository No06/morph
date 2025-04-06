part of 'convert_page.dart';

class _ConvertListView extends StatelessWidget {
  const _ConvertListView({required this.items});

  final List<_ListItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isFirst = index == 0;
        final isLast = index == items.length - 1;
        return HookBuilder(
          builder: (context) {
            final isExpaned = useState(false);
            return ExpansionListTile(
              isExpaned: isExpaned.value,
              title: ListTile(
                leading: item.icon,
                title: Text(item.title),
                trailing: Icon(Icons.expand_less),
                shape:
                    isFirst
                        ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        )
                        : null,
                onTap: () => isExpaned.value = !isExpaned.value,
              ),
              child: ColoredBox(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.08),
                child: Column(
                  children: List.generate(item.children.length, (index) {
                    final child = item.children[index];
                    final isLastChild = index == item.children.length - 1;
                    return ListTile(
                      shape:
                          isLast && isLastChild
                              ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              )
                              : null,
                      leading: child.icon ?? const SizedBox(),
                      title: Text(child.title),
                      onTap: child.onTap,
                    );
                  }),
                ),
              ),
            );
          },
        );
      },
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
