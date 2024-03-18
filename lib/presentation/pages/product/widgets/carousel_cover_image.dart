import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/product/product_model.dart';

class CarouselCoverImage extends StatefulWidget {
  final ProductModel productModel;
  final Function(int) callBackIndex;
  final int currentIndex;
  final CarouselController controller;

  const CarouselCoverImage({
    super.key,
    required this.productModel,
    required this.callBackIndex,
    required this.currentIndex,
    required this.controller,
  });

  @override
  State<CarouselCoverImage> createState() => _CarouselCoverImageState();
}

class _CarouselCoverImageState extends State<CarouselCoverImage> {

  List<String> images = [];
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.currentIndex;
    images.addAll(widget.productModel.images);
    for(int i= 0; i < widget.productModel.idOptionProducts.length; i++){
      if(widget.productModel.idOptionProducts[i].images.isEmpty){
        images.add('');
      }else{
        images.add(widget.productModel.idOptionProducts[i].images.first);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          carouselController: widget.controller,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return IZIImage(
              images[itemIndex],
              width: Get.width,
            );
          },
          options: CarouselOptions(
            height: Get.width * 0.7,
            enlargeFactor: 0.25,
            viewportFraction: 1,
            onPageChanged: (index, data) {
              widget.callBackIndex(index);
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: IZISizeUtil.SPACE_3X,
          right: IZISizeUtil.SPACE_4X,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorResources.COLOR_D9D9D9,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '${currentIndex + 1}/${images.length}',
                style: AppText.text15.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }
}
