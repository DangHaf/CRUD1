import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../core/export/core_export.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.callBack,
    required this.currentIndex,
    required this.index,
    required this.data,
  });
  final Function callBack;
  final int currentIndex;
  final int index;
  final ProductDetails data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          CommonHelper.onTapHandler(callback: () {
            callBack();
          });
        },
        child: Container(
          margin: IZISizeUtil.setEdgeInsetsOnly(right: index != 2 ? IZISizeUtil.SPACE_2X : 0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: IZISizeUtil.setSize(percent: currentIndex == index ? .17 : .15),
                    decoration: BoxDecoration(
                      borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
                      color: currentIndex == index
                          ? ColorResources.WHITE.withOpacity(.1)
                          : ColorResources.LANGUAGE_UN_SELECT,
                      border: Border.all(
                        color: currentIndex == index
                            ? ColorResources.PRIMARY_4
                            : ColorResources.LIGHT_GREY.withOpacity(.5),
                        width: .8,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_1X),
                              child: Text(
                                data.title.split(' ').first,
                                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                      color: ColorResources.WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Text(
                              data.description,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorResources.WHITE,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          data.price,
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: ColorResources.WHITE,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Item recommend.
              if (currentIndex == index && index == 1)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: IZISizeUtil.setEdgeInsetsSymmetric(
                          horizontal: IZISizeUtil.SPACE_2X,
                          vertical: IZISizeUtil.SPACE_2X * .7,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 7),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff35FCC6).withOpacity(1),
                              const Color(0xff24F0F8).withOpacity(1),
                              const Color(0xff4475D5).withOpacity(1)
                            ],
                            stops: const [0, 0.394791, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(5, 15),
                              color: ColorResources.WHITE.withOpacity(.7),
                              blurRadius: 30,
                              spreadRadius: -12,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Recommend',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
