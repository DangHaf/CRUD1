import 'package:get/get.dart';
import 'package:template/presentation/pages/account/personal_account_number/personal_account_number_binding.dart';
import 'package:template/presentation/pages/account/personal_account_number/personal_account_number_page.dart';
import 'package:template/presentation/pages/account/personal_information/personal_information_binding.dart';
import 'package:template/presentation/pages/account/personal_information/personal_information_page.dart';
import 'package:template/presentation/pages/account/point/point_binding.dart';
import 'package:template/presentation/pages/account/point/point_page.dart';
import 'package:template/presentation/pages/account/search_address/search_address_binding.dart';
import 'package:template/presentation/pages/account/search_address/search_address_page.dart';
import 'package:template/presentation/pages/address/add_address/add_address_binding.dart';
import 'package:template/presentation/pages/address/add_address/add_address_page.dart';
import 'package:template/presentation/pages/address/address/address_binding.dart';
import 'package:template/presentation/pages/address/address/address_page.dart';
import 'package:template/presentation/pages/address/edit_address/edit_address_binding.dart';
import 'package:template/presentation/pages/address/edit_address/edit_address_page.dart';
import 'package:template/presentation/pages/cart/transaction/other_payment/other_payment_binding.dart';
import 'package:template/presentation/pages/cart/transaction/other_payment/other_payment_page.dart';
import 'package:template/presentation/pages/cart/transaction/payment_confirm/payment_confirm_binding.dart';
import 'package:template/presentation/pages/cart/transaction/payment_confirm/payment_confirm_page.dart';
import 'package:template/presentation/pages/cart/transaction/payment_method/payment_method_binding.dart';
import 'package:template/presentation/pages/cart/transaction/payment_method/payment_method_page.dart';
import 'package:template/presentation/pages/cart/transaction/visa/visa_binding.dart';
import 'package:template/presentation/pages/cart/transaction/visa/visa_page.dart';
import 'package:template/presentation/pages/cart/voucher_cart/voucher_cart_binding.dart';
import 'package:template/presentation/pages/cart/voucher_cart/voucher_cart_page.dart';
import 'package:template/presentation/pages/comment/comment_product/comment_product_binding.dart';
import 'package:template/presentation/pages/comment/comment_product/comment_product_page.dart';
import 'package:template/presentation/pages/comment/comment_provider/comment_provider_binding.dart';
import 'package:template/presentation/pages/comment/comment_provider/comment_provider_page.dart';
import 'package:template/presentation/pages/notification/notification_binding.dart';
import 'package:template/presentation/pages/notification/notification_detail/notification_detail_binding.dart';
import 'package:template/presentation/pages/notification/notification_detail/notification_detail_page.dart';
import 'package:template/presentation/pages/notification/notification_page.dart';
import 'package:template/presentation/pages/order/detail_order/detail_order_binding.dart';
import 'package:template/presentation/pages/order/detail_order/detail_order_page.dart';
import 'package:template/presentation/pages/order/my_order/my_order_binding.dart';
import 'package:template/presentation/pages/order/my_order/my_order_page.dart';
import 'package:template/presentation/pages/order/return_order/return_order_binding.dart';
import 'package:template/presentation/pages/order/return_order/return_order_page.dart';
import 'package:template/presentation/pages/order/review/review_binding.dart';
import 'package:template/presentation/pages/order/review/review_page.dart';
import 'package:template/presentation/pages/product/product_detail_binding.dart';
import 'package:template/presentation/pages/product/product_detail_page.dart';
import 'package:template/presentation/pages/provider/leading_provider/leading_provider_binding.dart';
import 'package:template/presentation/pages/provider/leading_provider/leading_provider_page.dart';
import 'package:template/presentation/pages/provider/product_hot/product_hot_binding.dart';
import 'package:template/presentation/pages/provider/product_hot/product_hot_page.dart';
import 'package:template/presentation/pages/provider/provider_detail_binding.dart';
import 'package:template/presentation/pages/provider/provider_detail_page.dart';
import 'package:template/presentation/pages/search/search_binding.dart';
import 'package:template/presentation/pages/search/search_image/search_image_binding.dart';
import 'package:template/presentation/pages/search/search_image/search_image_page.dart';
import 'package:template/presentation/pages/search/search_page.dart';
import 'package:template/presentation/pages/search/search_product_provider/search_product_provider_binding.dart';
import 'package:template/presentation/pages/search/search_product_provider/search_product_provider_page.dart';
import 'package:template/presentation/pages/search/search_provider/search_provider_binding.dart';
import 'package:template/presentation/pages/search/search_provider/search_provider_page.dart';
import 'package:template/presentation/pages/student_management/add_student/add_student_binding.dart';
import 'package:template/presentation/pages/student_management/add_student/add_student_page.dart';
import 'package:template/presentation/pages/student_management/edit_student/edit_student_binding.dart';
import 'package:template/presentation/pages/student_management/edit_student/edit_student_page.dart';
import 'package:template/presentation/pages/student_management/student_management_binding.dart';
import 'package:template/presentation/pages/student_management/student_management_page.dart';
import 'package:template/presentation/pages/voucher/voucher_detail/voucher_detail_binding.dart';
import 'package:template/presentation/pages/voucher/voucher_detail/voucher_detail_page.dart';
import 'package:template/presentation/pages/voucher/voucher_page.dart';
import 'package:template/presentation/pages/voucher/voucher_binding.dart';
import 'package:template/presentation/pages/cart/payment/payment_binding.dart';
import 'package:template/presentation/pages/cart/payment/payment_page.dart';

mixin AppRoute {
  static const String NOTIFICATION = '/notification';
  static const String DETAIL_NOTIFICATION = '/detail_notification';
  static const String SEARCH = '/search';
  static const String SEARCH_PRODUCT_PROVIDER = '/search_product_provider';
  static const String PERSONAL_INFORMATION = '/personal_information';
  static const String SEARCH_ADDRESS = '/search_address';
  static const String VOUCHER = '/voucher';
  static const String VOUCHER_DETAIL = '/voucher_detail';
  static const String DETAIL_PRODUCT = '/detail_product';
  static const String DETAIL_PROVIDER= '/detail_provider';
  static const String COMMENT_PRODUCT = '/comment_product';
  static const String COMMENT_PROVIDER = '/comment_provider';
  static const String PAYMENT = '/payment';
  static const String ADDRESS = '/address';
  static const String ADD_ADDRESS = '/add_address';
  static const String EDIT_ADDRESS = '/edit_address';
  static const String PAYMENT_CONFIRM = '/payment_confirm';
  static const String PAYMENT_METHOD = '/payment_method';
  static const String OTHER_PAYMENT = '/other_payment';
  static const String VISA_PAYMENT = '/visa_payment';
  static const String SEARCH_PROVIDER = '/search_provider';
  static const String VOUCHER_CART = '/voucher_cart';
  static const String MY_ORDER = '/my_order';
  static const String DETAIL_ORDER = '/detail_order';
  static const String LEADING_PROVIDER = '/leading_provider';
  static const String REVIEW = '/review';
  static const String PERSONAL_ACCOUNT = '/personal_account';
  static const String RETURN_ORDER = '/return_order';
  static const String POINT = '/point';
  static const String SEARCH_IMAGE = '/search_image';
  static const String PRODUCT_HOT = '/product_hot';
  static const String STUDENT_MANAGEMENT = '/student_management';
  static const String EDIT_STUDENT = '/edit_student';
  static const String ADD_STUDENT = '/add_student';
  static const String ADD_SUBJECT= '/add_subject';


  static List<GetPage> listPage = [
    GetPage(
      name: NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: SEARCH_PROVIDER,
      page: () => const SearchProviderPage(),
      binding: SearchProviderBinding(),
    ),
    GetPage(
      name: VISA_PAYMENT,
      page: () => const VisaPage(),
      binding: VisaBinding(),
    ),
    GetPage(
      name: DETAIL_NOTIFICATION,
      page: () => NotificationDetailPage(),
      binding: NotificationDetailBinding(),
    ),
    GetPage(
      name: PERSONAL_INFORMATION,
      page: () => PersonalInformationPage(),
      binding: PersonalInformationBinding(),
    ),
    GetPage(
      name: SEARCH_ADDRESS,
      page: () => SearchAddressPage(),
      binding: SearchAddressBinding(),
    ),
    GetPage(
      name: DETAIL_PRODUCT,
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: COMMENT_PRODUCT,
      page: () => CommentProductPage(),
      binding: CommentProductBinding(),
    ),
    GetPage(
      name: COMMENT_PROVIDER,
      page: () => CommentProviderPage(),
      binding: CommentProviderBinding(),
    ),
    GetPage(
      name: VOUCHER,
      page: () => VoucherPage(),
      binding: VoucherBinding(),
    ),
    GetPage(
      name: VOUCHER_DETAIL,
      page: () => VoucherDetailPage(),
      binding: VoucherDetailBinding(),
    ),
    GetPage(
      name: PAYMENT,
      page: () => const PaymentPage(),
      binding:  PaymentBinding(),
    ),
    GetPage(
      name: ADDRESS,
      page: () => const AddressPage(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: ADD_ADDRESS,
      page: () => const AddAddressPage(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: EDIT_ADDRESS,
      page: () => const EditAddressPage(),
      binding: EditAddressBinding(),
    ),
    GetPage(
      name: PAYMENT_CONFIRM,
      page: () => const PaymentConfirmPage(),
      binding: PaymentConfirmBinding(),
    ),
    GetPage(
      name: PAYMENT_METHOD,
      page: () => const PaymentMethodPage(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: OTHER_PAYMENT,
      page: () => const OtherPaymentPage(),
      binding: OtherPaymentBinding(),
    ),
    GetPage(
      name: VISA_PAYMENT,
      page: () => const VisaPage(),
      binding: VisaBinding(),
    ),
    GetPage(
      name: DETAIL_PROVIDER,
      page: () => ProviderDetailPage(),
      binding:  ProviderDetailBinding(),
    ),
    GetPage(
      name: VOUCHER_CART,
      page: () => const VoucherCartPage(),
      binding: VoucherCartBinding(),
    ),
    GetPage(
      name: DETAIL_ORDER,
      page: () => const DetailOrderPage(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: MY_ORDER,
      page: () => const MyOrderPage(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: LEADING_PROVIDER,
      page: () => LeadingProviderPage(),
      binding:  LeadingProviderBinding(),
    ),
    GetPage(
      name: REVIEW,
      page: () => ReviewPage(),
      binding:  ReviewBinding(),
    ),
    GetPage(
      name: PERSONAL_ACCOUNT,
      page: () => PersonalAccountNumberPage(),
      binding: PersonalAccountNumberBinding(),
    ),
    GetPage(
      name: RETURN_ORDER,
      page: () => const ReturnOrderPage(),
      binding:  ReturnOrderBinding(),
    ),
    GetPage(
      name: POINT,
      page: () => const PointPage(),
      binding: PointBinding(),
    ),
    GetPage(
      name: SEARCH_PRODUCT_PROVIDER,
      page: () => const SearchProductProviderPage(),
      binding: SearchProductProviderBinding(),
    ),
    GetPage(
      name: LEADING_PROVIDER,
      page: () => LeadingProviderPage(),
      binding:  LeadingProviderBinding(),
    ),
    GetPage(
      name: RETURN_ORDER,
      page: () => const ReturnOrderPage(),
      binding:  ReturnOrderBinding(),
    ),
    GetPage(
      name: SEARCH_IMAGE,
      page: () => const SearchImagePage(),
      binding:  SearchImageBinding(),
    ),
    GetPage(
      name: PRODUCT_HOT,
      page: () => const ProductHotPage(),
      binding:  ProductHotBinding(),
    ),
    GetPage(
      name: STUDENT_MANAGEMENT,
      page: () =>  StudentManagementPage(),
      binding:  StudentManagementBinding(),
    ),
    GetPage(
      name: EDIT_STUDENT,
      page: () =>  EditStudentPage(),
      binding:  EditStudentBinding(),
    ),
    GetPage(
      name: ADD_STUDENT,
      page: () =>  AddStudentPage(),
      binding:  AddStudentBinding(),
    ),

  ];
}
