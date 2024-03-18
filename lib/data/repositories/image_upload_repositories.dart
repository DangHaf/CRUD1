import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/end_points/end_point.dart';

class ImageUploadRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ImageUploadRepository();

  ///
  /// Add image.
  ///
  Future<List<UrlImageResponse>> addImages(List<File> files) async {
    //
    // Create data to return.
    List<UrlImageResponse> _urlImageResponseList = [];

    try {
      final _responseTemp =
          await dioClient!.uploadImages(EndPoint.UPLOAD, files: files);
      final ApiResponse _apiResponseTemp =
          ApiResponse.withSuccess(_responseTemp);

      // Check null API Response.
      if (!IZIValidate.nullOrEmpty(_apiResponseTemp.response) &&
          _apiResponseTemp.response.statusCode! >= 200 &&
          _apiResponseTemp.response.statusCode! <= 300) {
        //
        // Call back data success
        final _resultsTemp =
            _apiResponseTemp.response.data['files'] as List<dynamic>;

        // Add results to Image request.
        final ImageRequest _imageRequest = ImageRequest();
        _imageRequest.files = _resultsTemp.map((e) => e.toString()).toList();

        // Confirm temp files.
        await confirmImagesFullType(items: _imageRequest).then((value) {
          _urlImageResponseList = value;
        });
        return _urlImageResponseList;
      } else {
        return _urlImageResponseList;
      }
    } catch (e) {
      // IZIAlert().error(message: ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());
      print("Error catch $e");
      return _urlImageResponseList;
    }
  }

  ///
  /// Confirm images with optional.
  ///
  Future<List<UrlImageResponse>> confirmImagesFullType({
    required ImageRequest items,
  }) async {
    //
    // Create data to return.
    final List<UrlImageResponse> _urlImageResponseList = [];

    try {
      final _response =
          await dioClient!.post(EndPoint.UPLOAD_LOCAL, data: items.toMap());
      final ApiResponse _apiResponse = ApiResponse.withSuccess(_response);

      // Check null API Response.
      if (!IZIValidate.nullOrEmpty(_apiResponse.response) &&
          _apiResponse.response.statusCode! >= 200 &&
          _apiResponse.response.statusCode! <= 300) {
        final _results = _apiResponse.response.data as List<dynamic>;

        // Filter url image.
        for (final _item in _results) {
          //
          // Compare List<dynamic> to List<String>.
          final List<String> _imageUrls =
              (_item as List<dynamic>).map((e) => e.toString()).toList();

          // Add url image response to list.
          _urlImageResponseList.add(
            UrlImageResponse(
              originImage: !IZIValidate.nullOrEmpty(_imageUrls[0])
                  ? _imageUrls[0]
                  : _imageUrls.first,
              extraLargeImage: !IZIValidate.nullOrEmpty(_imageUrls[1])
                  ? _imageUrls[1]
                  : _imageUrls.first,
              largeImage: !IZIValidate.nullOrEmpty(_imageUrls[2])
                  ? _imageUrls[2]
                  : _imageUrls.first,
              mediumImage: !IZIValidate.nullOrEmpty(_imageUrls[3])
                  ? _imageUrls[3]
                  : _imageUrls.first,
              smallImage: !IZIValidate.nullOrEmpty(_imageUrls[4])
                  ? _imageUrls[4]
                  : _imageUrls.first,
              extraSmallImage: !IZIValidate.nullOrEmpty(_imageUrls[5])
                  ? _imageUrls[5]
                  : _imageUrls.first,
            ),
          );
        }

        return _urlImageResponseList;
      } else {
        return _urlImageResponseList;
      }
    } catch (e) {
      IZIAlert().error(
          message:
              ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());
      print("Error catch $e");
      return _urlImageResponseList;
    }
  }

  ///
  /// Upload temp image.
  ///
  Future<List<String>> tempImageUpload(List<File> files) async {
    //
    // Create data to return.
    final List<String> _urlImageResponseList = [];

    late Response<dynamic> _responseTemp;

    try {
      _responseTemp = await dioClient!.uploadImages('/uploads', files: files);
    } catch (e) {
      IZIAlert().error(
          message:
              ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());
      return _urlImageResponseList;
    }

    final ApiResponse _apiResponseTemp = ApiResponse.withSuccess(_responseTemp);

    // Check null API Response.
    if (!IZIValidate.nullOrEmpty(_apiResponseTemp.response) &&
        _apiResponseTemp.response.statusCode! >= 200 &&
        _apiResponseTemp.response.statusCode! <= 300) {
      //
      // Call back data success
      _urlImageResponseList.addAll(
          (_apiResponseTemp.response.data['files'] as List<dynamic>)
              .map((e) => e.toString())
              .toList());

      return _urlImageResponseList;
    } else {
      return _urlImageResponseList;
    }
  }

  ///
  /// Add video & audio.
  ///
  Future<List<String>> addFilesVideoOrAudio(List<File> files) async {
    //
    // Create data to return.
    List<String> _urlFiles = [];

    try {
      final _responseTemp =
          await dioClient!.uploadImages('/uploads', files: files);
      final ApiResponse _apiResponseTemp =
          ApiResponse.withSuccess(_responseTemp);

      // Check null API Response.
      if (!IZIValidate.nullOrEmpty(_apiResponseTemp.response) &&
          _apiResponseTemp.response.statusCode! >= 200 &&
          _apiResponseTemp.response.statusCode! <= 300) {
        //
        // Call back data success
        final _resultsTemp =
            _apiResponseTemp.response.data['files'] as List<dynamic>;

        // Add results to Image request.
        final ImageRequest _imageRequest = ImageRequest();
        _imageRequest.files = _resultsTemp.map((e) => e.toString()).toList();

        await _confirmVideo(items: _imageRequest).then((value) {
          _urlFiles = value;
        });

        return _urlFiles;
      } else {
        return _urlFiles;
      }
    } catch (e) {
      IZIAlert().error(
          message:
              ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());
      print("Error catch $e");
      return _urlFiles;
    }
  }

  ///
  /// Confirm video & audio
  ///
  Future<List<String>> _confirmVideo({
    required ImageRequest items,
  }) async {
    //
    // Create data to return.
    final List<String> _urlVideoList = [];

    try {
      final _response =
          await dioClient!.post('/uploads/local-tmp', data: items.toMap());
      final ApiResponse _apiResponse = ApiResponse.withSuccess(_response);

      // Check null API Response.
      if (!IZIValidate.nullOrEmpty(_apiResponse.response) &&
          _apiResponse.response.statusCode! >= 200 &&
          _apiResponse.response.statusCode! <= 300) {
        final _results = _apiResponse.response.data as List<dynamic>;

        _urlVideoList.addAll(_results
            .map((e) => (e as List<dynamic>).first.toString())
            .toList());
        return _urlVideoList;
      } else {
        return _urlVideoList;
      }
    } catch (e) {
      IZIAlert().error(
          message:
              ApiResponse.withError(ApiErrorHandler.getMessage(e)).toString());
      print("Error catch $e");
      return _urlVideoList;
    }
  }

  Future<String?> upLoadImage(List<File> files) async {
    try {
      final res = await dioClient!.uploadImages(EndPoint.UPLOAD, files: files);
      final data = List<String>.from(res.data['files'] as List<dynamic>);
      return data.first;
    } catch (e) {
      return null;
    }
  }
}
