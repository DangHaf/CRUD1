import 'dart:developer';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:template/core/services/in_app_purchase_service/id_subscription.dart';

class InAppPurchaseService {
  InAppPurchaseService() {
    //
    // Init service.
    _initService();
  }
  // Instance in app purchase.
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  // Instance products.
  static List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  // Instance trial products.
  static List<ProductDetails> _productsTrial = [];
  List<ProductDetails> get productsTrial => _productsTrial;

  // Instance trial monthly products.
  static ProductDetails? _productTrialMonthly;
  ProductDetails? get productTrialMonthly => _productTrialMonthly;

  // Instance monthly products.
  static ProductDetails? _productMonthly;
  ProductDetails? get productMonthly => _productMonthly;

  // Instance price month before discount.
  static double _priceMonthBeforeDiscount = 0;
  double get priceMonthBeforeDiscount => _priceMonthBeforeDiscount;

  ///
  /// Init service.
  ///
  Future<void> _initService() async {
    final bool _isAvailable = await _inAppPurchase.isAvailable();

    if (!_isAvailable) {
      log('In app purchase is not available');
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse _productDetailResponse =
        await _inAppPurchase.queryProductDetails(IdSubscription.listProductId.toSet());

    if (_productDetailResponse.error != null) {
      _products = _productDetailResponse.productDetails;
    }

    final List<ProductDetails> _items = _productDetailResponse.productDetails;

    _products.clear();

    // Sort products.
    for (final e in _items) {
      //
      // Get trial product.
      if (e.id == IdSubscription.monthlyId && e.rawPrice <= 0.0) {
        _productTrialMonthly = e;
      }

      // Get monthly product.
      if (e.id == IdSubscription.monthlyId && e.rawPrice > 0.0) {
        _productMonthly = e;
      }

      // Get monthly product before discount.
      if (e.id == IdSubscription.weeklyId && e.rawPrice > 0.0) {
        _priceMonthBeforeDiscount = e.rawPrice * 4;
      }

      if (IdSubscription.listProductId.contains(e.id) && e.rawPrice > 0.0) {
        _products.add(e);
      }
    }

    // Revert.
    _products = _products.reversed.toList();

    // Get product trial.
    if (_productTrialMonthly != null) {
      _productsTrial = List.from(_products);
      _productsTrial.removeWhere((element) => element.id == IdSubscription.monthlyId);
      _productsTrial.insert(0, _productTrialMonthly!);
    }
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
