import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget({
    super.key,
    required this.jsonPath,
    required this.width,
    this.height,
    this.boxFit,
    this.controller,
    this.callBackLoaded,
  });

  final String jsonPath;
  final double width;
  final double? height;
  final BoxFit? boxFit;
  final AnimationController? controller;
  final Function? callBackLoaded;

  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  ///
  /// Get controller.
  ///
  AnimationController _getController() {
    return widget.controller ?? _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.jsonPath,
      controller: _getController(),
      onLoaded: (composition) {
        _getController().duration = composition.duration;

        if (widget.controller == null) {
          _getController().repeat();
        } else {
          if (widget.callBackLoaded != null) {
            widget.callBackLoaded!();
          }
        }
      },
      fit: widget.boxFit ?? BoxFit.cover,
      width: widget.width,
      height: widget.height,
    );
  }
}
