import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/services/firebase_remote_config_service/firebase_remote_config_service.dart';
import 'package:template/core/services/share_service/share_service.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/data/repositories/bank_account_repository.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/data/repositories/comment_repository.dart';
import 'package:template/data/repositories/feedback_repositories.dart';
import 'package:template/data/repositories/file_download_repositories.dart';
import 'package:template/data/repositories/home_repository.dart';
import 'package:template/data/repositories/in_app_api.dart';
import 'package:template/data/repositories/lookup_repository.dart';
import 'package:template/data/repositories/notification_repository.dart';
import 'package:template/data/repositories/order_repository.dart';
import 'package:template/data/repositories/point_repository.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:template/data/repositories/provider_repository.dart';
import 'package:template/data/repositories/setting_repository.dart';
import 'package:template/data/repositories/student_repositories.dart';
import 'package:template/data/repositories/transaction_repository.dart';
import 'package:template/data/repositories/voucher_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<LoggingInterceptor>(LoggingInterceptor());

  /// Firebase remote config.
  sl.registerSingleton<FirebaseRemoteConfigService>(FirebaseRemoteConfigService());

  /// Local Notification.
  sl.registerSingleton<LocalNotificationAPI>(LocalNotificationAPI());

  /// Image upload.
  sl.registerLazySingleton(() => ImageUploadRepository());

  /// download file.
  sl.registerLazySingleton(() => FileDownloadRepository());

  // In app purchase.
  sl.registerSingleton<InAppPurchaseService>(InAppPurchaseService());

  // Register isar.
  // final _isar = await IsarRepository().init();

  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerSingleton<DioClient>(DioClient());

  // Socket IO.
  sl.registerLazySingleton<SocketIO>(() => SocketIO());

  // Auth.
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositories());

  // Convert.
  sl.registerLazySingleton<ConvertFileToTextRepository>(() => ConvertFileToTextRepository());

  // Settings.
  sl.registerLazySingleton<FeedbackRepository>(() => FeedbackRepository());

  // In App API.
  sl.registerLazySingleton<InAppAPI>(() => InAppAPI());

  // Share service
  sl.registerLazySingleton<ShareService>(() => ShareService());

  // Settings.
  sl.registerLazySingleton<SettingOldRepository>(() => SettingOldRepository());

  // Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());
  sl.registerLazySingleton<SettingRepository>(() => SettingRepository());
  sl.registerLazySingleton<NotificationRepository>(() => NotificationRepository());
  sl.registerLazySingleton<AccountRepository>(() => AccountRepository());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepository());
  sl.registerLazySingleton<VoucherRepository>(() => VoucherRepository());
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository());
  sl.registerLazySingleton<ProviderRepository>(() => ProviderRepository());
  sl.registerLazySingleton<CartRepository>(() => CartRepository());
  sl.registerLazySingleton<LookupRepository>(() => LookupRepository());
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepository());
  sl.registerLazySingleton<BankAccountRepository>(() => BankAccountRepository());
  sl.registerLazySingleton<CommentRepository>(() => CommentRepository());
  sl.registerLazySingleton<AddressRepository>(() => AddressRepository());
  sl.registerLazySingleton<OrderRepository>(() => OrderRepository());
  sl.registerLazySingleton<PointRepository>(() => PointRepository());
  sl.registerLazySingleton<StudentRepository>(() => StudentRepository());

}
