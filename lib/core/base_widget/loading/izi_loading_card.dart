// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/core/export/core_export.dart';

///
/// Đang tải card dài.
///
class CardLoadingItem extends StatelessWidget {
  const CardLoadingItem({
    Key? key,
    this.count = 2,
    this.height = 70,
  }) : super(key: key);
  final int? count;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count ?? 10,
      shrinkWrap: true,
      padding: IZISizeUtil.setEdgeInsetsOnly(
        left: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
        right: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
        top: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
        bottom: IZISizeUtil.setSize(percent: .05),
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
          decoration: BoxDecoration(
            color: ColorResources.RED,
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 10),
          ),
          child: Row(
            children: [
              Shimmer.fromColors(
                period: const Duration(milliseconds: 600),
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: height ?? 70,
                  width: height ?? 70,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      period: const Duration(milliseconds: 600),
                      baseColor: ColorResources.RED,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        height: 10,
                        width: IZISizeUtil.getMaxWidth(),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      period: const Duration(milliseconds: 600),
                      baseColor: ColorResources.RED,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        height: 10,
                        width: IZISizeUtil.setSize(percent: .2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: IZISizeUtil.SPACE_2X);
      },
    );
  }
}
