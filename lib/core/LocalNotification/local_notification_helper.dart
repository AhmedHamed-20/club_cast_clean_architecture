import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../constants/check_notfications_permissions.dart';

class LocalNotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channel Id 4',
      'channel name',
      onlyAlertOnce: true,
      colorized: true,
      enableVibration: true,
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentSound: true,
    ),
  );
  static Future<bool?> init() async {
    var intializationSettingsAdnroid = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: intializationSettingsAdnroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );
    tz.initializeTimeZones();
    return await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required int index,
    required DateTime eventTime,
  }) async {
    if (eventTime.isBefore(DateTime.now())) {
      flutterToast(
          msg: AppStrings.youCanNotScheduleNotificationInPast.tr(),
          backgroundColor: AppColors.toastError,
          textColor: AppColors.white);
      return;
    } else {
      if (await CheckNotificationsPermission.checkMicPermission()) {
        flutterToast(
            msg: AppStrings.youWillBeNotifiedAtEventDate.tr(),
            backgroundColor: AppColors.toastSuccess,
            textColor: AppColors.white);
        return await flutterLocalNotificationsPlugin.zonedSchedule(
          index,
          title,
          body,
          tz.TZDateTime.from(eventTime, tz.local),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
        );
      }
    }
  }

  static void showNotification({
    required String title,
    required String body,
    required int index,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      index,
      title,
      body,
      notificationDetails,
    );
  }
}
