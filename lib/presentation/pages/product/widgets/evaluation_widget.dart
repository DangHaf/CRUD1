import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';

class EvaluationWidget extends StatelessWidget {
  final double rate;

  const EvaluationWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          if (index + 1 <= rate) {
            return const Icon(
              Icons.star_sharp,
              color: ColorResources.COLOR_FFD600,
            );
          }
          if (index < rate) {
            return const Icon(
              Icons.star_half_sharp,
              color: ColorResources.COLOR_FFD600,
            );
          }
          return const Icon(
            Icons.star_border,
            color: ColorResources.COLOR_FFD600,
          );
        },
      ),
    );
  }
}
