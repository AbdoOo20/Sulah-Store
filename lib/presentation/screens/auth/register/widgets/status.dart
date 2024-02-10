import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';

import '../../../../../core/resources/app_colors.dart';
class Status extends StatelessWidget {
  const Status({
    super.key, required this.width
  });
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      color: AppColors.redLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: double.infinity,
            width:  width,
            decoration: BoxDecoration(
                color: AppColors.main,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r))),
          ),
        ],
      ),
    );
  }
}
