import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/presentation/screens/auth/forgetPassword/otp/widget/custom_pin_code_text_field.dart';
import 'package:provider/provider.dart';
import '../../../../component/buttons/custom_button.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/appbars/custom_app_bar.dart';
import '../../../../component/custom_scaffold.dart';
import '../../../../component/svg_icon.dart';
import 'otp_view_model.dart';
import 'widget/resend_code.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.from});
  final String phone;
  final String from;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controller = TextEditingController();

  _onSubmit() {
    String otp = _controller.text;
    Provider.of<OtpViewModel>(context, listen: false)
        .verifyOTPFirebase(otp, widget.phone, context,widget.from);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<OtpViewModel>(context, listen: true).isLoading;

    return CustomScaffold(
      appBar: CustomAppBar(
        height: 55.h,
        color: AppColors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.white),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: SVGIcon(
                  Assets.otplogo,
                  width: 300.w,
                  height: 200.h,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListAnimator(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: (16.w)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r)),
                        color: AppColors.white),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: (32.h)),
                            Text(
                              LocaleKeys.titalotp.tr(),
                              style: TextStyles()
                                  .getTitleStyle(fontSize: 20.sp)
                                  .customColor(AppColors.black),
                            ),
                            SizedBox(height: (8.h)),
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.titalotpemail.tr(),
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 12.sp)
                                      .customColor(AppColors.black),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${widget.phone}',
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 12.sp)
                                      .customColor(AppColors.main),
                                )
                              ],
                            ),
                            SizedBox(height: (16.h)),
                            CustomPinCodeTextField(
                              controller: _controller,
                            ),
                            SizedBox(height: (16.h)),
                            ResendConfirmCode(phone: widget.phone,from: widget.from,),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       LocaleKeys.textOtp.tr(),
                            //       style: TextStyles()
                            //           .getRegularStyle(fontSize: 12.sp)
                            //           .customColor(AppColors.main),
                            //     ),
                            //     Text(
                            //       '00.45'.tr(),
                            //       style: TextStyles()
                            //           .getRegularStyle(fontSize: 12.sp)
                            //           .customColor(AppColors.black),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: (16.h)),
                            CustomButton(
                              title: LocaleKeys.tobesure.tr(),
                              textColor: AppColors.white,
                              height: 56.h,
                              color: AppColors.main,
                              loading: isLoading,
                              width: double.infinity,
                              onTap: () {
                                _onSubmit();
                                // push( NewPassword(phone: widget.phone));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
