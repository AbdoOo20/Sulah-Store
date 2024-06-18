import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../component/images/network_image.dart';

class CustomCaredProducts extends StatefulWidget {
  const CustomCaredProducts({
    super.key,
    required this.url,
    required this.title,
    required this.productId,
   required this.isShow, required this.index,

  });

  final String url;
  final int index;
  final String title;
final num productId;
final int isShow;

  @override
  State<CustomCaredProducts> createState() => _CustomCaredProductState();
}

class _CustomCaredProductState extends State<CustomCaredProducts> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    bool eye = widget.isShow==1?true:false;
    return Container(
      padding: EdgeInsets.all(12.r),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(width: 1.w,color: AppColors.grayLite),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(children: [
        eye == false ?
        Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.visibility_off,
            color: AppColors.darkGray,
            size:20.r,
          ),
        ):const SizedBox(),
        SizedBox(
          width: 120.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CommonNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.url,
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 42.h,
            child: Text(
              widget.title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyles()

                  .getRegularStyle(
                    fontSize: 14.sp,
                  )
                  .customColor(AppColors.black),
            ),
          ),
        ),
      ]),
    );
  }
}
