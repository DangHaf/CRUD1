import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/comment/comment_model.dart';
import 'package:template/data/model/comment/comment_quantity_model.dart';
import 'package:template/data/repositories/comment_repository.dart';

class CommentProductController extends GetxController {
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();

  final RefreshController refreshController = RefreshController();

  final Rx<EvaluationType> _currentType = EvaluationType.ALL.obs;

  EvaluationType get currentType => _currentType.value;

  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  int page = 1;
  int limit = 10;
  int _totalRecord = 0;
  late String productId;

  bool get isLoadMore => _totalRecord > comments.length;

  RxList<CommentModel> comments = <CommentModel>[].obs;

  Rx<CommentQuantity> cmtQuantity = CommentQuantity().obs;

  @override
  void onInit() {
    productId = Get.arguments as String;
    initData();
    super.onInit();
  }

  Future<void> initData({bool isRefresh = false}) async {
   await Future.wait([
      getDataTotal(),
      initDataComment(isRefresh: isRefresh),
    ]);
   refreshController.refreshCompleted();
  }

  Future<void> getDataTotal() async {
    await _commentRepository.getCountCommentType(
      id: productId,
      onSuccess: (data) async {
        cmtQuantity.value = data;
      },
      onError: (e) {},
    );
  }

  Future<void> initDataComment({bool isRefresh = false}) async {
    if (!isRefresh) {
      page = 1;
      _isLoading.value = true;
    } else {
      page = 1;
    }
    await getListComment();
    _isLoading.value = false;
  }

  void onChangeType(EvaluationType type) {
    if (type == currentType) {
      return;
    }
    _currentType.value = type;
    initDataComment();
  }

  Future<void> getListComment({
    bool isLoadMore = false,
  }) async {
    await _commentRepository.paginateType(
      page,
      limit,
      id: productId,
      type: currentType.name,
      onSuccess: (data) async {
        if (!isLoadMore) {
          comments.clear();
        }
        comments.addAll(data.result);
        _totalRecord = data.totalResults;
        page++;
      },
      onError: (e) {},
    );
    if (isLoadMore) {
      refreshController.loadComplete();
    }
  }

  void onTapLike({required int index}) {
    if (!comments[index].isLike) {
      comments[index].userLikes.add(sl<SharedPreferenceHelper>().getIdUser);
      _commentRepository.setLike(
        idComment: comments[index].id!,
        onSuccess: () {},
        onError: (error) {
          comments[index]
              .userLikes
              .remove(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    } else {
      comments[index].userLikes.remove(sl<SharedPreferenceHelper>().getIdUser);
      _commentRepository.setUnLike(
        idComment: comments[index].id!,
        onSuccess: () {},
        onError: (error) {
          comments[index].userLikes.add(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    }
    comments.refresh();
  }
}
