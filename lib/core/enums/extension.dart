import 'package:get/get.dart';
import 'package:template/core/enums/enums.dart';
extension EvaluationTypeExtension on EvaluationType {
  String get title {
    switch (this) {
      case EvaluationType.ALL:
        return 'product_detail_017'.tr;
      case EvaluationType.HAVE_CONTENT:
        return 'product_detail_018'.tr;
      case EvaluationType.NEAREST:
        return 'product_detail_019'.tr;
      case EvaluationType.TALLEST:
        return 'product_detail_020'.tr;
      case EvaluationType.SHORTEST:
        return 'product_detail_021'.tr;
    }
  }
}