import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:morph/widgets/app_notification/app_notification_manager.dart';

const _kDuration = Duration(seconds: 3);
const _kAutoDismiss = true;
const _kIndicatorAnimationType = IndicatorAnimationType.rightToLeft;
const _kDismissible = true;
const _kShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
);
const _kAlignment = Alignment.bottomRight;
const _kPositionOffset = Offset(16, 16);

enum _NotificationType { success, error, info, warning }

class AppNotification extends StatelessWidget {
  const AppNotification({
    super.key,
    this.color,
    this.leading,
    this.title,
    this.content,
    this.duration = _kDuration,
    this.autoDismiss = _kAutoDismiss,
    this.indicatorAnimationType = _kIndicatorAnimationType,
    this.dismissible = _kDismissible,
    this.shape = _kShape,
    this.alignment = _kAlignment,
    this.positionOffset = _kPositionOffset,
  }) : _type = null;

  const AppNotification.success({
    super.key,
    this.color = Colors.green,
    this.leading,
    this.title,
    this.content,
    this.duration = _kDuration,
    this.autoDismiss = _kAutoDismiss,
    this.indicatorAnimationType = _kIndicatorAnimationType,
    this.dismissible = _kDismissible,
    this.shape = _kShape,
    this.alignment = _kAlignment,
    this.positionOffset = _kPositionOffset,
  }) : _type = _NotificationType.success;

  const AppNotification.error({
    super.key,
    this.color = Colors.red,
    this.leading,
    this.title,
    this.content,
    this.duration = _kDuration,
    this.autoDismiss = _kAutoDismiss,
    this.indicatorAnimationType = _kIndicatorAnimationType,
    this.dismissible = _kDismissible,
    this.shape = _kShape,
    this.alignment = _kAlignment,
    this.positionOffset = _kPositionOffset,
  }) : _type = _NotificationType.error;

  const AppNotification.info({
    super.key,
    this.color = Colors.blue,
    this.leading,
    this.title,
    this.content,
    this.duration = _kDuration,
    this.autoDismiss = _kAutoDismiss,
    this.indicatorAnimationType = _kIndicatorAnimationType,
    this.dismissible = _kDismissible,
    this.shape = _kShape,
    this.alignment = _kAlignment,
    this.positionOffset = _kPositionOffset,
  }) : _type = _NotificationType.info;

  const AppNotification.warning({
    super.key,
    this.color = Colors.orange,
    this.leading,
    this.title,
    this.content,
    this.duration = _kDuration,
    this.autoDismiss = _kAutoDismiss,
    this.indicatorAnimationType = _kIndicatorAnimationType,
    this.dismissible = _kDismissible,
    this.shape = _kShape,
    this.alignment = _kAlignment,
    this.positionOffset = _kPositionOffset,
  }) : _type = _NotificationType.warning;

  final Color? color;
  final Widget? leading;
  final String? title;
  final String? content;
  final ShapeBorder shape;
  final Duration duration;
  final bool autoDismiss;
  final IndicatorAnimationType indicatorAnimationType;
  final bool dismissible;
  final Alignment alignment;
  final Offset positionOffset;

  final _NotificationType? _type;

  void show(BuildContext context) {
    AppNotificationManager().show(context, this);

    if (autoDismiss) {
      Future.delayed(duration, () {
        if (context.mounted) dismiss();
      });
    }
  }

  void dismiss() {
    AppNotificationManager().remove(this);
  }

  Widget? get _leading =>
      leading ??
      (_type == null
          ? null
          : switch (_type) {
            _NotificationType.success => Icon(Icons.check_circle, color: color),
            _NotificationType.error => Icon(Icons.error, color: color),
            _NotificationType.info => Icon(Icons.info, color: color),
            _NotificationType.warning => Icon(Icons.warning, color: color),
          });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final leading = _leading;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.33,
      child: Material(
        elevation: 3,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (leading != null) leading,
                    Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (title != null)
                            Flexible(
                              child: Text(title!, style: textTheme.titleSmall),
                            ),
                          if (content != null)
                            Flexible(
                              child: Text(content!, style: textTheme.bodySmall),
                            ),
                        ],
                      ),
                    ),
                    Spacer(),
                    if (dismissible)
                      IconButton(onPressed: dismiss, icon: Icon(Icons.close)),
                  ],
                ),
              ),
            ),
            if (autoDismiss)
              _Indicator(
                animationType: indicatorAnimationType,
                color: color ?? Colors.blue,
                duration: duration,
              ),
          ],
        ),
      ),
    );
  }
}

enum IndicatorAnimationType { leftToRight, rightToLeft, shrink }

class _Indicator extends StatefulWidget {
  const _Indicator({
    required this.animationType,
    required this.color,
    required this.duration,
  });

  final IndicatorAnimationType animationType;
  final Color color;
  final Duration duration;

  static const height = 2.0;

  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _Indicator.height,
      width: double.infinity,
      child: Align(
        alignment: switch (widget.animationType) {
          IndicatorAnimationType.leftToRight => Alignment.centerRight,
          IndicatorAnimationType.rightToLeft => Alignment.centerLeft,
          IndicatorAnimationType.shrink => Alignment.center,
        },
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1, end: 0),
          duration: widget.duration,
          builder: (context, widthFactor, child) {
            return FractionallySizedBox(
              heightFactor: 1,
              widthFactor: widthFactor,
              child: child,
            );
          },
          child: ColoredBox(color: widget.color, child: SizedBox.expand()),
        ),
      ),
    );
  }
}
