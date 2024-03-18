import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/data/model/notification/notification_model.dart';

import 'package:timezone/data/latest_all.dart' as latest_all;
import 'package:timezone/timezone.dart' as time_zone;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class LocalNotificationAPI {
  ///
  /// [Note]: add this function below in to top function on [main].
  ///
  // @pragma('vm:entry-point')
  // void notificationTapBackground(NotificationResponse notificationResponse) {
  //   print('notification(${notificationResponse.id}) action tapped: '
  //       '${notificationResponse.actionId} with'
  //       ' payload: ${notificationResponse.payload}');
  //   if (notificationResponse.input?.isNotEmpty ?? false) {
  //     print('notification action tapped with input: ${notificationResponse.input}');
  //   }
  // }

  /// Declare [id notifications].
  int id = DateTime.now().microsecond;

  /// Declare [FlutterLocalNotificationsPlugin].
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Streams are created so that app can respond to notification-related events.
  /// Since the plugin is initialize in the [main] function.
  static final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();
  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  /// Import your [MethodChannel].
  static const MethodChannel platform = MethodChannel('HaQua');

  /// Import your [PortName].
  static const String portName = 'HaQua_Notification';

  /// Declare selected notification [payload].
  String? selectedNotificationPayload;

  /// A notification action which triggers a url launch event.
  static const String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event.
  static const String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  static const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  /// Declare notification app launch detail.
  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  /// Declare initialize [Router].
  String initialRoute = AuthRouters.SPLASH;

  ///
  /// Initialized local notification api.
  ///
  Future<void> initializeLocalNotification(
      {required Function(NotificationResponse notificationResponse)
          topFuncNotificationResponse}) async {
    ///
    /// Config local time zone.
    _configureLocalTimeZone();

    /// Get notification app launch detail.
    notificationAppLaunchDetails = !kIsWeb && Platform.isLinux
        ? null
        : await flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    initialRoute = AuthRouters.SPLASH;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      // TODO Pay load.
    }

    /// Initialized setting android (you can change icon local notification below).
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Setting options for local notification.
    /// Corresponds to the [UNNotificationCategory] type which is used to configure notification categories and accompanying options.
    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain(
            'id_1',
            'Action 1',
          ),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be. Done later
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
      notificationCategories: darwinNotificationCategories,
    );

    /// Initialization Setting for two platform (android and ios).
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    /// Initialize local notification and add to stream for pay load.
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        try {
          if (notificationResponse.payload != null) {
            final DataNotification data = DataNotification.fromMap(
                jsonDecode(notificationResponse.payload!)
                    as Map<String, dynamic>);
            if (data.entityType == 'VOUCHER') {
              Get.toNamed(AppRoute.VOUCHER_DETAIL, arguments: data.idVoucher);
              return;
            }
            if (data.entityType == 'PURCHASE') {
              Get.toNamed(
                AppRoute.DETAIL_ORDER,
                arguments: data.idPurchase,
              );
              return;
            }
          }
        } catch (_) {}

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.sink.add(notificationResponse.payload);

            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.sink.add(notificationResponse.payload);
            }
            break;
        }
      },

      /// In onDidReceiveBackgroundNotificationResponse below then we will import from top function in [main].
      onDidReceiveBackgroundNotificationResponse: topFuncNotificationResponse,
    );
  }

  ///
  /// Request permission in android 12+.
  ///
  Future<void> requestPermissionInAndroid() async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  ///
  ///  Config local time zone.
  ///
  Future<void> _configureLocalTimeZone() async {
    ///
    /// If isWeb or is Linux then return null else initializeTimeZones.
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    latest_all.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    time_zone.setLocalLocation(time_zone.getLocation(timeZoneName));
  }

  ///
  /// Func to check android permission granted.
  ///
  Future<bool> isAndroidPermissionGranted() async {
    bool granted = false;
    if (Platform.isAndroid) {
      granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return granted;
  }

  ///
  /// Func to get request permission.
  ///
  Future<bool> requestPermissions() async {
    bool isResult = false;
    if (Platform.isIOS || Platform.isMacOS) {
      isResult = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
                critical: true,
              ) ??
          false;
      isResult = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  MacOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
                critical: true,
              ) ??
          false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      isResult =
          await androidImplementation?.requestNotificationsPermission() ??
              false;
    }

    return isResult;
  }

  ///
  /// Func to configure did received notifications subject.
  ///
  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      developer.log(
          'Go to [screen] what you want..Configure select notification subject. $receivedNotification',
          name: 'Local notification background');
    });
  }

  ///
  /// Func to configure select notification subject.
  ///
  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      ///
      /// Go to [screen] what you want.
      developer.log(
          'Go to [screen] what you want..Configure select notification subject. $payload',
          name: 'Local notification');
    });
  }

  ///
  /// Func to close listen notification subject.
  ///
  void close() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
  }

  ///
  /// Optional helper convert image.
  ///
  /// [1]. Download and save file .
  Future<String> downloadAndSaveFile(
      {required String url, required String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  ///
  /// [2]. Base64 encode images.
  ///
  Future<String> base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  ///
  /// [3]. Get Byte array from url.
  ///
  Future<Uint8List> getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  ///
  /// Optional show local notification.
  /// You can choose type push local notification below.
  /// With [Payload] then we will send router name to [Navigator] to screen,

  ///
  /// [1]. Show plain notification with payload.
  ///
  Future<void> showNotificationWithPayload({
    required String title,
    required String body,
    String? payLoad,
    int? idNotification,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.1',
      'Notification 1.0.1',
      channelDescription: 'Notification with payload',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
      payload: payLoad ?? 'item x',
    );
  }

  ///
  /// [2]. Show notification with custom sound.
  ///
  Future<void> showNotificationCustomSound({
    required String title,
    required String body,
    required String payload,
    int? idNotification,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.2',
      'Notification 1.0.2',
      largeIcon:
          DrawableResourceAndroidBitmap('@drawable/calling_background_icon'),
      priority: Priority.max,
      importance: Importance.max,
      fullScreenIntent: true,
      sound: RawResourceAndroidNotificationSound('sound_notices'),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(sound: 'sound_notices.mp3');

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  ///
  /// [3]. Schedule notification to appear in 5 seconds based on local time zone.
  ///
  Future<void> zonedScheduleNotification({
    required String title,
    required String body,
    int? idNotification,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      time_zone.TZDateTime.now(time_zone.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Notification version 1.0.3',
          'Notification 1.0.3',
          channelDescription:
              'Schedule notification to appear in 5 seconds based on local time zone.',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  ///
  /// [4]. Repeat notification every minute.
  ///
  Future<void> repeatNotification({
    required String title,
    required String body,
    int? idNotification,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.4',
      'Notification 1.0.4',
      channelDescription: 'Repeat notification every minute.',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
    );
  }

  ///
  /// [5]. Show big picture notification using local images.
  ///
  Future<void> showBigPictureNotification({
    required String urlLargeIcon,
    required String urlBigPicture,
    required String contentTitleHtml,
    required String summaryTextHtml,
    required String title,
    required String body,
    int? idNotification,
  }) async {
    final String largeIconPath =
        await downloadAndSaveFile(url: urlLargeIcon, fileName: 'largeIcon');
    final String bigPicturePath =
        await downloadAndSaveFile(url: urlBigPicture, fileName: 'largeIcon');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: contentTitleHtml,
      htmlFormatContentTitle: true,
      summaryText: summaryTextHtml,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.5',
      'Notification 1.0.5',
      channelDescription: ' Show big picture notification using local images.',
      styleInformation: bigPictureStyleInformation,
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
    );
  }

  ///
  /// [6]. Show big picture notification using base64 String for images.
  ///
  Future<void> showBigPictureNotificationBase64({
    required String urlLargeIcon,
    required String urlBigPicture,
    required String contentTitleHtml,
    required String summaryTextHtml,
    required String title,
    required String body,
    int? idNotification,
  }) async {
    final String largeIcon = await base64encodedImage(urlLargeIcon);
    final String bigPicture = await base64encodedImage(urlBigPicture);

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(bigPicture),
            //Base64AndroidBitmap(bigPicture),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            contentTitle: contentTitleHtml,
            htmlFormatContentTitle: true,
            summaryText: summaryTextHtml,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.6',
      'Notification 1.0.6',
      channelDescription:
          'Show big picture notification using base64 String for images.',
      styleInformation: bigPictureStyleInformation,
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
    );
  }

  ///
  /// [7].  Show big picture notification using URLs for Images.
  ///
  Future<void> showBigPictureNotificationURL({
    required String urlLargeIcon,
    required String urlBigPicture,
    required String contentTitleHtml,
    required String summaryTextHtml,
    required String title,
    required String body,
    int? idNotification,
  }) async {
    final ByteArrayAndroidBitmap largeIcon =
        ByteArrayAndroidBitmap(await getByteArrayFromUrl(urlLargeIcon));
    final ByteArrayAndroidBitmap bigPicture =
        ByteArrayAndroidBitmap(await getByteArrayFromUrl(urlBigPicture));

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      contentTitle: contentTitleHtml,
      htmlFormatContentTitle: true,
      summaryText: summaryTextHtml,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Notification version 1.0.7',
      'Notification 1.0.7',
      channelDescription: 'Show big picture notification using URLs for Images',
      styleInformation: bigPictureStyleInformation,
    );
    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      idNotification ?? DateTime.now().microsecond,
      title,
      body,
      notificationDetails,
    );
  }

  ///
  /// [8]. Cancel Notification with id.
  ///
  Future<void> cancelNotification({
    required int idNotification,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(idNotification);
  }

  ///
  /// [9]. Cancel all notification.
  ///
  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

///
/// Create Received Notifications.
///
class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
