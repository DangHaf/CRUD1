import 'dart:developer';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:template/app_binding.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/config/routes/app_pages.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/config/theme/app_theme.dart';
import 'package:template/config/theme/light_theme.dart';
import 'package:template/firebase_options.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'core/di_container.dart' as di;
import 'package:flutter/foundation.dart' show kDebugMode;

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

DateTime? now;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize mobile ads.
  MobileAds.instance.initialize();

  // Init firebase.
  await Firebase.initializeApp(
    name: "NailSupply",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // If debug mode is disable.
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }

  // Set local.
  time_ago.setLocaleMessages('vi', time_ago.ViMessages());

  // Init Get it.
  await di.init();

  // Setup firebase services.
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  LocalNotificationAPI().initializeLocalNotification(
    topFuncNotificationResponse: notificationTapBackground,
  );
  await FcmService().init();
  await FcmService().initForegroundNotification();
  FcmService().backgroundHandler();

  // Set timezone
  IZITimeZone().initializeTimeZones();

  // Get device token.
  String? _deviceToken = '';

  try {
    _deviceToken = await messaging.getToken();
    log('Device id: $_deviceToken');
    di.sl<SharedPreferenceHelper>().setTokenDevice(_deviceToken.toString());
  } catch (e, s) {
    log('Error get device token at $e and $s');
  }

  /// Instance Easy Loading.
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..progressColor = ColorResources.WHITE
    ..backgroundColor = ColorResources.COLOR_3B71CA
    ..indicatorColor = ColorResources.WHITE
    ..textColor = ColorResources.WHITE
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: ColorResources.WHITE,
    )
    ..dismissOnTap = false;

  // Set Device Orientation.
  _setOrientation();

  // Run app.
  runApp(const MyApp());
}

///
/// Set Device Orientation.
///
void _setOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 800),
      useInheritedMediaQuery: true,
      builder: (context, index) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            initialRoute: AuthRouters.SPLASH,
            initialBinding: AppBinding(),
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
            defaultTransition: Transition.rightToLeft,
            transitionDuration: const Duration(),
            getPages: AppPages.list,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            localizationsDelegates: localizationsDelegates,
            supportedLocales: LocalizationService.locales,
            builder: EasyLoading.init(
              builder: (context, widget) {
                return Theme(
                  data: lightTheme,
                  child: MediaQuery(
                    // Setting font does not change with system font size
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.0,
                      boldText: false,
                    ),
                    child: widget!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
