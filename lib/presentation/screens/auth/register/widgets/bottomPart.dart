
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../component/component.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({
    super.key,
    required this.controller, required this.previous, required this.next, this.hintNext, this.previousLoading, this.nextLoading,
  });

  final PageController controller;
  final void Function() previous;
  final void Function() next;
  final String? hintNext;
  final bool? previousLoading;
  final bool? nextLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
          top: 10.h
        , right: 10.w,
          left: 10.w
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           CustomButton(
             loading: previousLoading??false,
             onTap: previous,
           title: LocaleKeys.kPrevious.tr(),color:Colors.transparent,
             borderColor: AppColors.black,
             textColor: AppColors.black,
             width:156.5.w ,
             height: 56.h,
           ),
          CustomButton(
           loading: nextLoading??false,
            color: AppColors.main,
            onTap:next,
            title: hintNext?.tr()??LocaleKeys.kNext.tr(),
            width:156.5.w ,
            height: 56.h,
            textColor:  AppColors.white,
          ),
        ],
      ),
    );
  }
}
