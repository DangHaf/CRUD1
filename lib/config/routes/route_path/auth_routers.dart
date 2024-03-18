import 'package:get/get.dart';
import 'package:template/presentation/pages/auth/forgot_password/forgot_password_binding.dart';
import 'package:template/presentation/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:template/presentation/pages/auth/login/login_binding.dart';
import 'package:template/presentation/pages/auth/login/login_page.dart';
import 'package:template/presentation/pages/auth/otp/otp_binding.dart';
import 'package:template/presentation/pages/auth/otp/otp_page.dart';
import 'package:template/presentation/pages/auth/register/register_binding.dart';
import 'package:template/presentation/pages/auth/register/register_page.dart';
import 'package:template/presentation/pages/auth/reset_password/reset_password_binding.dart';
import 'package:template/presentation/pages/auth/reset_password/reset_password_page.dart';
import 'package:template/presentation/pages/dash_board/dash_board_binding.dart';
import 'package:template/presentation/pages/dash_board/dash_board_page.dart';
import 'package:template/presentation/pages/introduction/introduction_binding.dart';
import 'package:template/presentation/pages/introduction/introduction_page.dart';
import 'package:template/presentation/pages/splash/splash_page.dart';

mixin AuthRouters {
  static const String SPLASH = '/splash';
  static const String INTRODUCTION = '/introduction';
  static const String DASH_BOARD = '/dash_board';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot_password';
  static const String RESET_PASSWORD = '/reset_password';
  static const String OTP = '/otp';

  static List<GetPage> listPage = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: INTRODUCTION,
      page: () => IntroductionPage(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: DASH_BOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: FORGOT_PASSWORD,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RESET_PASSWORD,
      page: () => ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: OTP,
      page: () => OTPPage(),
      binding: OTPBinding(),
    ),
    GetPage(
      name: REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}
