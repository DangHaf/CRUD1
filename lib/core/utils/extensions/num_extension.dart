import 'package:intl/intl.dart';

extension NumExtension on num {
  String get price {
    return NumberFormat("###,###.##", "en_US").format(this);
  }

  String get quantity {
    return NumberFormat("###,###.##", "en_US").format(this);
  }

  String get averagePoint {
    return NumberFormat("###,###.##", "en_US").format(this);
  }
}