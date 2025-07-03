import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/routing/route.dart';
import '../../core/res/text_styles.dart';
import '../../core/resources/app_assets.dart';
import '../../core/resources/app_colors.dart';
import '../../presentation/screens/home/home_sereen/home.dart';

class DialogDone extends StatefulWidget {
  const DialogDone({Key? key,required this.title, this.widget}) : super(key: key);
  final String title;
  final Widget? widget;
  @override
  State<DialogDone> createState() => _DialogDoneState();
}

class _DialogDoneState extends State<DialogDone> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {pushAndRemoveUntil(const Home());});
  }
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(24.r)),
        content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.paySuccessfully,height: 250.h,),
              SizedBox(width: 250.w,
                child: Text(
                  widget.title??'',
                  style: TextStyles()
                      .getRegularStyle(fontSize: 16.sp)
                      .customColor(AppColors.darkGray),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12.h,),
             widget.widget!=null? Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(child: widget.widget,),
                  Icon(Icons.arrow_forward_ios,color: AppColors.second,size: 12.r,)
                ],
              ):const SizedBox(),

            ],),),
      );
  }
}
