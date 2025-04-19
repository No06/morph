import 'package:flutter/material.dart';
import 'package:morph/widgets/app_notification/app_notification.dart';

class AppNotificationManager {
  AppNotificationManager._();

  factory AppNotificationManager() => _instance;

  static final AppNotificationManager _instance = AppNotificationManager._();

  final Map<AppNotification, OverlayEntry> _notificationEntryMap = {};

  void show(BuildContext context, AppNotification notification) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Align(
            alignment: Alignment.bottomRight,
            child: Stack(
              children: [
                Positioned(
                  right: notification.positionOffset.dx,
                  bottom: notification.positionOffset.dy,
                  child: notification,
                ),
              ],
            ),
          ),
    );
    overlay.insert(overlayEntry);
    _notificationEntryMap.addAll({notification: overlayEntry});
  }

  void remove(AppNotification notification) {
    final overlayEntry = _notificationEntryMap[notification];
    if (overlayEntry == null) return;
    if (overlayEntry.mounted) {
      overlayEntry.remove();
      overlayEntry.dispose();
    }
    _notificationEntryMap.remove(notification);
  }
}
