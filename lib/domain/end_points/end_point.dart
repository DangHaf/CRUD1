// ignore_for_file: non_constant_identifier_names

import 'package:template/core/utils/app_constants.dart';

class EndPoint {
  EndPoint._();

  //
  // API.
  // static const String BASE_URL = 'https://p30nailnew.izisoft.io/';
  static const String BASE_URL = 'https://training.izisoft.io/';

  static const String SOCKET_URL = 'wss://socket1.crudcode.tk';

  //
  // Auth.
  static const String signInAccount = '/auth/signin-with-device';

  // Characters.
  static const String character = '/a3-characters';

  // Category.
  static const String category = '/a3-categories';

  // Conversation.
  static const String conversation = '/a3-conversations';

  // messages.
  static const String messages = '/a3-messages';

  // Convert image.
  static const String convertFile = '/messages/upload-file-to-text';

  // Convert file.
  static const String convertImage = '/messages/upload-image-to-text';

  // Settings.
  static const String settings = '/app9-settings/one';

  // Feedback.
  static const String feedback = '/app9-feedbacks';

  // Auth.
  static const String users = '/users';

  // DIY.
  static const String diy = '/a3-diy';

  // Tool collection.
  static const String toolCollection = '/a3-tool-categories';

  // Tool generator.
  static const String toolGenerator = '/a3-tool-categories/use';

  // DIY Chat.
  static const String diyChat = '/a3-diy-messages';

  // Verify Receipt Apple.
  static const String receiptAppleSanBox =
      'https://sandbox.itunes.apple.com/verifyReceipt';
  static const String receiptAppleProduct =
      'https://buy.itunes.apple.com/verifyReceipt';

  // Text to audio.
  static const String textToAudio =
      'http://p55product10test.izisoft.io/text-to-audio';

  static String SING_IN_WITH_SOCIAL = "v1/auth/signin-with-social";
  static String SING_IN_WITH_LOCAL = "v1/auth/signin-local";
  static String SING_UP_WITH_LOCAL = "v1/auth/signup-local";
  static String SEND_OPT_PHONE = "v1/otps/send-otp-phone";
  static String PHONE_COUNTRY = "v1/phone-countries";
  static String SIGN_OUT = "v1/auth/sign-out";
  static String SETTING = "v1/settings";
  static String UPDATE_PASSWORD_PHONE = "v2/users/update-password/phone";
  static String NOTIFICATION = "v1/notifications";
  static String USER = "v2/users";
  static String USER_V1 = "v1/users";
  static String UPLOAD = "v1/uploads";
  static String UPLOAD_LOCAL = "v1/uploads/local-tmp";
  static String FAVORITE_POST = "v2/posts/like/paginate";
  static String PROPOSE_POST = "v2/posts/propose/paginate";
  static String DETAIL_POST = "v2/posts";
  static String VOUCHER = "v2/voucher-products";
  static String PRODUCT_OUTSTANDING = "v2/products/outstanding/paginate";
  static String PRODUCT_HIGHLIGHT = "v2/products/highlight/paginate";
  static String PRODUCT_PAGINATE = "/v2/products/paginate";
  static String BANNER = "/v2/banners?appType=$NAIL_SUPPLY";
  static String NEWS = "/v2/news/paginate";
  static String PROVIDER = "/v2/products/store/paginate";
  static String LEADING_PROVIDER = "/v2/stores/supplier/paginate";
  static String STORE = "/v2/stores/paginate";
  static String STATE = "v1/states";
  static String CITY = "v1/cities";
  static String BANK_ACCOUNT = "v1/bank-accounts";
  static String TRANSACTION = "v1/transactions";
  static String PRODUCT = "v2/products";
  static String VOUCHER_PRODUCT = "v2/carts/voucher";
  static String CART_PAGINATE = "v2/carts/paginate";
  static String CART = "v2/carts";
  static String CART_PAYMENT = "v2/carts/payment";
  static String ADD_CART = "v2/carts/add-product";
  static String ADD_CART_MANY = "v2/carts/add-many-product";
  static String PROVIDERS = "/v2/stores";
  static String COMMENT_STATISTIC = "v2/rates/statistic-rate";
  static String COMMENT_STATISTIC_PROVIDER = "v2/rates/statistic-rate-store";
  static String COMMENT_PAGINATE = "v2/rates/paginate";
  static String COMMENT = "v2/rates";
  static String CART_VOUCHER = "v2/carts/voucher";
  static String PURCHASES = "v2/purchases";
  static String PURCHASES_PAGINATE = "v2/purchases/paginate";
  static String PURCHASES_COUNT_STATUS = "v2/purchases/count-status";
  static String ADDRESS = "v2/addresses";
  static String COMMENT_PAGINATE_TYPE_RATE = "v2/rates/paginate-type-rate";
  static String PRODUCT_PROPOSE = "v2/products/propose-product";
  static String COUNT_CART = "v2/carts/count";
  static String RATE_MANY = "v2/rates/many";
  static String POINT_HISTORY_PAGINATE = "v2/history-points/paginate";
  static String POINT_HISTORY = "v2/history-points";
  static String USER_POINT = "v2/user-points";
  static String PRODUCT_SEARCH = "v2/products/search";
  static String TYPE_PRODUCT = "v2/type-products";

  static String STUDENT = "v1/students";

}
