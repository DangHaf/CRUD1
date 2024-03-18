import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String notificationChannelId = 'hiyou_channel';
const String FCM_TOPIC_DEFAULT = 'fcm_all';
const String NOTIFICATION_KEY = 'notification_key';
const String NOTIFICATION_TITLE = 'title';
const String NOTIFICATION_BODY = 'body';

Locale localeResolutionCallback(
    Locale? locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.first;
  }
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

List<LocalizationsDelegate> localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
];

const String PasswordAppStore = 'e2a68251d00248f3a60766c922ddb55a';

const String FeaturesToolCollection = 'Featured';
const String AdsConfig = 'ads_config';

// Total time detector.
const int TOTAL_TIME_DETECTOR_GHOST = 25;
const int TIME_PLAY_SOUND_FOUND_GHOST_1 = TOTAL_TIME_DETECTOR_GHOST - 14;
const int TIME_PLAY_SOUND_FOUND_GHOST_2 = TOTAL_TIME_DETECTOR_GHOST - 3;

/// Type token login.
const String GOOGLE = 'GOOGLE';
const String FACEBOOK = 'FACEBOOK';
const String APPLE = 'APPLE';
// Type User
const String CUSTOMER = 'CUSTOMER';
const String DIAMOND = 'DIAMOND';
const String GOLD = 'GOLD';
const String SILVER = 'SILVER';
const String FREE = 'FREE';
const String BASIC = 'BASIC';

// ignore: non_constant_identifier_names
final String MAP_KEY = Platform.isAndroid
    ? 'AIzaSyBxSzM2JXY73V6JcCO1CizWojZcxFQJuUM'
    : 'AIzaSyAX6Bc6QBn-C_m_DhG-1kNZ8w5OTw6qm3w';

const String BASE_GEOLOCATOR =
    'https://maps.googleapis.com/maps/api/geocode/json';

const String TEXT_MULTI_LINE =
    ' multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line multiple line';
const String NAIL_SUPPLY = 'NAIL_SUPPLY';

/// type post
const String VOUCHER = 'VOUCHER';

/// Priority post
const URGENT = 'URGENT';
const VERY_URGENT = 'VERY_URGENT';

/// Gender
const OTHER = 'OTHER';
const MALE = 'MALE';
const FEMALE = 'FEMALE';

/// Sort type product
const NEW = 'NEW';
const SAVING = 'SAVING';
const OUTSTANDING = 'OUTSTANDING';
const FOR_YOU = 'FOR_YOU';
const HOT_SELL = 'HOT_SELL';

/// Type product
const PAINT = 'PAINT';
const MACHINERY = 'MACHINERY';
const EQUIPMENT = 'EQUIPMENT';
const OTHER_TYPE = 'OTHER';

/// Transaction status.
const String CHECKING = 'CHECKING';
const String SUCCESS = 'SUCCESS';
const String FAILURE = 'FAILURE';

/// Transaction type.
const String RECHARGE = 'RECHARGE';
const String WITHDRAW_MONEY = 'WITHDRAW_MONEY';
const String PAYMENT = 'PAYMENT';

/// PayPal
const String CLIENT_ID = '';
const String SECRETKEY = '';
const String NOTE_PAYPAL = 'Contact us for any questions on your order.';
const String CURRENCY = 'USD';
const String DESCRIPTION = 'Payment via Paypal';

/// Type transaction
const String MONEY = 'MONEY';
const String PERCENT = 'PERCENT';
const String PAYPAL = 'PAYPAL';
const String TRANSFER = 'TRANSFER';
const String VISA = 'VISA';
const String APPLE_PAY = 'APPLE_PAY';
const String BANK = 'BANK';

/// ORDER
const String WAIT_FOR_CONFIRMATION = 'WAIT_FOR_CONFIRMATION';
const String CONFIRMED = 'CONFIRMED';
const String PACKING = 'PACKING';
const String DELIVERING = 'DELIVERING';
const String DELIVERED = 'DELIVERED';
const String RECEIVED = 'RECEIVED';
const String CUSTOMER_CANCELED = 'CUSTOMER_CANCELED';
const String STORE_CANCELED = 'STORE_CANCELED';
const String RETURN = 'RETURN';
const String ACCEPT_RETURN = 'ACCEPT_RETURN';
const String REFUSE_RETURN = 'REFUSE_RETURN';

/// Point history
const String SHARE_DOWNLOAD = "SHARE_DOWNLOAD";

