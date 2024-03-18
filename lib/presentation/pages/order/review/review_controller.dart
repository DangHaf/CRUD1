import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/comment/rate_request.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/repositories/comment_repository.dart';

class ReviewController extends GetxController {
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();

  String idUser = sl<SharedPreferenceHelper>().getIdUser;
  String idStore = '';
  String idOrder = '';
  List<PurchaseDetailModel> listData = [];

  RxBool ignoring = false.obs;

  List<ItemReviewModel> reviews = [];

  @override
  void onInit() {
    idStore = Get.arguments['idStore'] as String;
    idOrder = Get.arguments['idOrder'] as String;
    listData = Get.arguments['purchase'] as List<PurchaseDetailModel>;
    mapDataReview();
    super.onInit();
  }

  Future<void> rateOrder() async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_043'.tr);
    await _commentRepository.addRateOrder(
      rateRequest: listRateRequest,
      onSuccess: () {
        IZIAlert().success(message: 'rate_005'.tr);
        Get.back();
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  List<RateRequest> get listRateRequest {
    final List<RateRequest> rateRequest = [];
    for (int i = 0; i < reviews.length; i++) {
      final item = reviews[i];
      rateRequest.add(
        RateRequest(
          idOptionProducts: item.idOptionProducts,
          idProduct: item.product.id!,
          idStore: idStore,
          idUser: idUser,
          idPurchase: idOrder,
          point: item.rating,
          content: item.contentComment,
        ),
      );
    }
    return rateRequest;
  }

  void onChangeRate(int index, int value) {
    reviews[index].rating = value;
  }

  void onChangeContent(int index, String value) {
    reviews[index].contentComment = value;
  }

  void mapDataReview() {
    for (int i = 0; i < listData.length; i++) {
      if (i == 0) {
        reviews.add(
          ItemReviewModel(
            idOrder: idOrder,
            idOptionProduct: [listData[i].idOptionProduct!],
            product: listData[i].idOptionProduct!.product!,
          ),
        );
      } else {
        bool hasInList = false;
        for (int j = 0; j < reviews.length; j++) {
          if (listData[i].idOptionProduct?.product?.id ==
              reviews[j].product.id) {
            hasInList = true;
            reviews[j].idOptionProduct.add(listData[i].idOptionProduct!);
            break;
          }
        }
        if (!hasInList) {
          reviews.add(
            ItemReviewModel(
              idOrder: idOrder,
              idOptionProduct: [listData[i].idOptionProduct!],
              product: listData[i].idOptionProduct!.product!,
            ),
          );
        }
      }
    }
  }
}
