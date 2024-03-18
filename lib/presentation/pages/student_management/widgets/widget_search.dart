import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

class WidgetSearch extends StatefulWidget {
   const WidgetSearch({super.key});

  @override
  State<WidgetSearch> createState() => _WidgetSearchState();
}

class _WidgetSearchState extends State<WidgetSearch> {
  late TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90, left: 16),
      child: Row(
        children: [
          Container(
            width: 285,
            height: 35,
            decoration: BoxDecoration(
              color: ColorResources.COLOR_F3F4F6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 44),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      // controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter keyword to find out...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(bottom: 12, left: 16, right: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      ImagesPath.icSearch,
                      width: 16.r,
                      height: 16.r,
                      color: ColorResources.COLOR_EDAC02,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: ColorResources.COLOR_F3F4F6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              ImagesPath.icSettingStudent,
              width: 30.r,
              height: 30.r,
            ),
          ),
        ],
      ),
    );
  }
}
