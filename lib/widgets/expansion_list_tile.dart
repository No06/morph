import 'package:flutter/material.dart';

class ExpansionListTile extends StatefulWidget {
  const ExpansionListTile({
    super.key,
    required this.title,
    required this.child,
    required this.isExpaned,
  });

  final Widget title;
  final Widget child;
  final bool isExpaned;

  @override
  State<ExpansionListTile> createState() => _ExpansionListTileState();
}

class _ExpansionListTileState extends State<ExpansionListTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      value: widget.isExpaned ? 1 : 0,
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void forward() {
    controller.forward();
  }

  void reverse() {
    controller.reverse();
  }

  @override
  void didUpdateWidget(ExpansionListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpaned != oldWidget.isExpaned) {
      widget.isExpaned ? forward() : reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title,
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return SizeTransition(
              axisAlignment: 1,
              sizeFactor: animation,
              child: child,
            );
          },
          child: widget.child,
        ),
      ],
    );
  }
}
