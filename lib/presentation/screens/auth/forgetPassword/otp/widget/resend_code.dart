import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/res/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/resources/resources.dart';
import '../otp_view_model.dart';

class ResendConfirmCode extends StatefulWidget {
  @override
  State <ResendConfirmCode> createState() => _ResendConfirmCodeState();
  const ResendConfirmCode({super.key, required this.phone, required this.from});
  final String phone;
  final String from;
}

class _ResendConfirmCodeState extends State<ResendConfirmCode> {
  late Timer _timer;
  int _start = 45;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool isLoading =
        Provider.of<OtpViewModel>(context, listen: true).loading;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (_start == 0)
          SizedBox(
            child: !isLoading
                ? InkWell(
                    onTap: () {
                      Provider.of<OtpViewModel>(context, listen: false)
                          .sendOTPFirebase(context, widget.phone, widget.from);
                    },
                    child: Text(
                      tr(LocaleKeys.textOtp),
                      textAlign: TextAlign.center,
                      style: TextStyles()
                          .getRegularStyle(fontSize: 12.sp)
                          .customColor(AppColors.main),
                    ),
                  )
                : SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: const CircularProgressIndicator(
                        strokeWidth: 3
                      ),
                    )),
          ),
        SizedBox(
          width: 8.w
        ),
        if (_start != 0)
          Text(
            '00:${_start.toString()}',
            style: TextStyles()
                .getRegularStyle(fontSize: 12.sp)
                .customColor(AppColors.black),
          ),
      ],
    );
  }
}
