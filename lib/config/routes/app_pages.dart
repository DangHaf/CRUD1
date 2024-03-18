import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';

mixin AppPages {
  static List<GetPage> list = [
    ...AuthRouters.listPage,
    ...AppRoute.listPage,
  ];
}
