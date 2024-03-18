import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/export/core_export.dart';

class PackageButtonWidget extends StatefulWidget {
  const PackageButtonWidget({
    super.key,
    required this.callBack,
    this.width,
    this.padding,
    this.textStyle,
  });

  final Function callBack;
  final double? width;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  State<PackageButtonWidget> createState() => _PackageButtonWidgetState();
}

class _PackageButtonWidgetState extends State<PackageButtonWidget> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  late AlignmentTween begin;
  late AlignmentTween end;

  @override
  void initState() {
    begin = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    end = AlignmentTween(
      begin: Alignment.bottomRight,
      end: Alignment.bottomRight,
    );

    _controller = (AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonHelper.onTapHandler(callback: () {
          widget.callBack();
        });
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: widget.width,
              padding: widget.padding ?? IZISizeUtil.setEdgeInsetsSymmetric(vertical: IZISizeUtil.SPACE_3X),
              decoration: BoxDecoration(
                borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_2X),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff35FCC6).withOpacity(1),
                    const Color(0xff24F0F8).withOpacity(1),
                    const Color(0xff4475D5).withOpacity(1)
                  ],
                  stops: const [0, 0.394791, 1],
                  begin: begin.evaluate(_animation),
                  end: end.evaluate(_animation),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 5),
                    color: ColorResources.WHITE.withOpacity(.7),
                    blurRadius: 30,
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'sub_008'.tr,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ),
            );
          }),
    );
  }
}
