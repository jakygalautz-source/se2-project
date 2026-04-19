import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_pilot/models/next_intake_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/models/next_reminder_helper.dart';

class NotificationsService {
  NotificationsService._();

  static final NotificationsService instance = NotificationsService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Vienna'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _notifications.initialize(settings: initSettings);
  }

  Future<void> requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  Future<void> scheduleNextReminder(NextIntakeModel nextReminder) async {
    const androidDetails = AndroidNotificationDetails(
      'pill_pilot_reminders',
      'Pill Pilot Reminders',
      channelDescription:
          'Reminder notifications for upcoming medication intake',
      importance: Importance.max,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    final scheduledDate = tz.TZDateTime.from(
      nextReminder.scheduledDateTime,
      tz.local,
    );

    final title = 'Pill Pilot';
    final body = nextReminder.medications.length == 1
        ? '${nextReminder.medications.first.name} ist jetzt fällig'
        : '${nextReminder.medications.length} Medikamente sind jetzt fällig';

    debugPrint("Scheduling next reminder...");
    debugPrint("scheduledDateTime: ${nextReminder.scheduledDateTime}");
    debugPrint("medication count: ${nextReminder.medications.length}");
    debugPrint("title: $title");
    debugPrint("body: $body");

    try {
      await _notifications.zonedSchedule(
        id: 0,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: nextReminder.dayPart.name,
      );

      debugPrint("Notification scheduled successfully");

      final pending = await _notifications.pendingNotificationRequests();
      debugPrint("PENDING COUNT: ${pending.length}");
      for (final item in pending) {
        debugPrint(
          "PENDING ID: ${item.id}, TITLE: ${item.title}, BODY: ${item.body}",
        );
      }
    } catch (e, st) {
      debugPrint("zonedSchedule ERROR: $e");
      debugPrintStack(stackTrace: st);
      rethrow;
    }
  }

  Future<void> rescheduleFromCurrentData({
    required ReminderTimeModel reminderTimeModel,
    required List<Medication> medications,
  }) async {
    await cancelAll();

    final nextReminder = NextReminderHelper.calculate(
      now: DateTime.now(),
      reminderTimeModel: reminderTimeModel,
      medications: medications,
    );

    if (nextReminder == null) return;

    await scheduleNextReminder(nextReminder);
  }

  Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'pill_pilot_reminders',
      'Pill Pilot Reminders',
      channelDescription: 'Test notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id: 999,
      title: 'Test',
      body: 'Notification funktioniert',
      notificationDetails: notificationDetails,
    );
  }
}
