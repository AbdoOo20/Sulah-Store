import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/routing/route.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/appbars/custom_app_bar.dart';
import '../../../../component/buttons/custom_button.dart';
import '../../../../component/custom_scaffold.dart';
import '../../../../component/inputs/new/customTextFormFieldPassword.dart';
import '../../../../component/svg_icon.dart';

import 'new_password_view_model.dart';

class NewPassword extends StatelessWidget {
  NewPassword({super.key, required this.phone});
  final String phone;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

void _onSubmit(context) async {
    // final passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9]{8,}$';
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String password = _passwordController.text;
        String confirmPassword = _confirmPasswordController.text;
        if (password.isEmpty) {
          ToastUtils.showToast('passwordMustBeEntered'.tr());
        // } else if (!RegExp(passwordPattern).hasMatch(password)) {
        //   ToastUtils.showToast('passwordMatchConditions'.tr());
          // ToastUtils.showToast('Password must be at least 8 characters long, contain at least one number, one lowercase letter, and one uppercase letter.'.tr());
        }else if (password != confirmPassword) {
          ToastUtils.showToast('passwordDoesNotMatch'.tr());
        } else {
          Provider.of<NewPasswordViewModel>(context,listen: false).resetPassword(context,password,confirmPassword);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<NewPasswordViewModel>(context, listen: true).isLoading;
    return CustomScaffold(
      appBar: CustomAppBar(height: 55.h, color: AppColors.white,),
      body: Container(decoration:  const BoxDecoration(color: AppColors.white),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: SVGIcon(
                  Assets.newpasswordlogo,
                  width: 200.w,
                  height: 200.h,
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: ListAnimator(
                    children: [
                      Text(
                        LocaleKeys.enterthepasswordbig.tr(),
                        style: TextStyles()
                            .getTitleStyle(fontSize: 20.sp)
                            .customColor(AppColors.black),
                      ),
                      Text(
                        LocaleKeys.titalnewpas.tr(),
                        style: TextStyles()
                            .getRegularStyle(fontSize: 12.sp)
                            .customColor(AppColors.black),
                      ),
                      SizedBox(height: 5.h,),
                      Row(children: [
                        SVGIcon(Assets.lock,height: 20.h,width:20.w,color: AppColors.main,),
                        SizedBox(width: 5.w,),
                        Text(
                          LocaleKeys.kPassword.tr(),
                          style: TextStyles()
                              .getRegularStyle(fontSize: 12.sp)
                              .customColor(AppColors.black),
                        ),
                      ],),
                      _buildForm(),
                       SizedBox(height: (12.h)),
                    /*  Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Text(
                              'createPassword'.tr(),
                              style: TextStyles()
                                  .getTitleStyle(fontSize: 16.sp)
                                  .customColor(AppColors.main),
                              softWrap: true,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: AppColors.main30,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),),
                        child:Padding(
                          padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.main,
                                    maxRadius: 5.r,
                                    minRadius: 5.r,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'ItMustLessThan'.tr(),
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 12.sp)
                                        .customColor(AppColors.black),
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.main,
                                    maxRadius: 5.r,
                                    minRadius: 5.r,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'ContainLeastNumeric'.tr(),
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 12.sp)
                                        .customColor(AppColors.black),
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.main,
                                    maxRadius: 5.r,
                                    minRadius: 5.r,
                                  ),
                                  SizedBox(width: 10.w),

                                  Text(
                                    'ContainLeastLowercase'.tr(),
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 12.sp)
                                        .customColor(AppColors.black),
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.main,
                                    maxRadius: 5.r,
                                    minRadius: 5.r,
                                  ),                        SizedBox(width: 10.w),

                                  Text(
                                    'ContainLeastUppercase'.tr(),
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 12.sp)
                                        .customColor(AppColors.black),
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.main,
                                    maxRadius: 5.r,
                                    minRadius: 5.r,
                                  ),                        SizedBox(width: 10.w),

                                  Text(
                                    'languageEnglish'.tr(),
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 12.sp)
                                        .customColor(AppColors.black),
                                    softWrap: true,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: (7)),*/
                      Center(
                        child: CustomButton(
                          color: AppColors.main,
                          loading: isLoading,
                          title: LocaleKeys.tobesure.tr(),textColor: AppColors.white,
                          onTap: () {
                            _onSubmit(context);
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _buildForm(){
    return Form(key: _formKey,child: Column(
      children:  [
        CustomTextFormFiledPassword( hintText: LocaleKeys.kPassword, textInputType: TextInputType.text,backGroundColor: AppColors.textFieldColor,controller: _passwordController, borderColor: AppColors.grayLite,),
        SizedBox(height: 20.h,),
        Row(children: [
          SVGIcon(Assets.lock,height: 20.h,width:20.w,color: AppColors.main,),
          SizedBox(width: 5.w,),
          Text(
            LocaleKeys.ConfirmPassword.tr(),
            style: TextStyles()
                .getRegularStyle(fontSize: 12.sp)
                .customColor(AppColors.black),
          ),
        ],),
        SizedBox(height: 10.h,),
        CustomTextFormFiledPassword( hintText: LocaleKeys.kConfirmPassword, textInputType: TextInputType.text,backGroundColor: AppColors.textFieldColor,controller: _confirmPasswordController, borderColor: AppColors.grayLite,),
      ],
    ));
  }
}
