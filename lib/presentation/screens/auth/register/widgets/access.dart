import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../injection.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/inputs/new/customTextFormFieldPassword.dart';
import '../../forgetPassword/otp/otp_view_model.dart';
import '../RegisterViewModel.dart';
import 'bottomPart.dart';
import '../../../../component/inputs/new/customTextFormField.dart';
import 'status.dart';
import 'upperPart.dart';

class Access extends StatelessWidget {
  Access({
    super.key,
    required this.controller,
  });
  RegisterBody registerBody=getIt();
  TargetPlatform getDeviceType() {/// for software_type
    return defaultTargetPlatform;
  }

  final PageController controller;
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
 void _onSubmit(context) async {
   TargetPlatform deviceType = getDeviceType();/// for software_type
   final passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9]{8,}$';
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String phone = _phoneController.text;
        String email = _emailController.text;
        String password = _passwordController.text;
        String confirmPassword = _confirmPasswordController.text;
        if (email.isEmpty) {
          ToastUtils.showToast('emailMustBeEntered'.tr());
        } else if (!email.isValidEmail()) {
          ToastUtils.showToast('checkYourEmail'.tr());
        } else if (phone.isEmpty) {
          ToastUtils.showToast('youMustEnterThePhoneNumber'.tr());
        } else if (password.isEmpty) {
          ToastUtils.showToast('passwordMustBeEntered'.tr());
        } else if (password != confirmPassword) {
        } else {
          registerBody.email=email;
          String modifiedPhone = Provider.of<OtpViewModel>(context,listen: false).removeLeadingZeroFromString(phone);
          registerBody.phone=modifiedPhone;
          registerBody.password=password;
          registerBody.registerFrom=deviceType.name.toLowerCase();
          registerBody.passwordConfirmation=confirmPassword;
          // Provider.of<OtpViewModel>(context,listen: false).sendOTPFirebase(context,phone,'register');
          Provider.of<RegisterViewModel>(context,listen: false).registerAPI(context,registerBody);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Status(width: MediaQuery.of(context).size.width),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                top: kScreenPaddingBigNormal,
                right: kScreenPaddingNormal,
                left: kScreenPaddingNormal),
            child: ListAnimator(
              children: [
                const UpperPart(
                    title: LocaleKeys.kAccess, body: LocaleKeys.kAccessBody),
                _buildForm(),
              ],
            ),
          ),
        ),
        BottomPart(
          nextLoading:context.watch<RegisterViewModel>().isLoading ,
          hintNext: LocaleKeys.kStart,
          controller: controller,
          next: () {
            _onSubmit(context);
          },
          previous: () => controller.animateToPage(2, duration: const Duration(seconds: 1), curve: Curves.easeInOut),
        )
      ],
    );
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormFiled(
              image: Assets.email,
              borderColor: AppColors.main30,
              backGroundColor: AppColors.textFieldColor,
              imageColor: AppColors.main,
              hintText: LocaleKeys.email.tr(),
              textInputType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: kScreenPaddingNormal,),
            CustomTextFormFiled(
              image: Assets.mobile,
              borderColor: AppColors.main30,
              backGroundColor: AppColors.textFieldColor,
              imageColor: AppColors.main,
              hintText: LocaleKeys.phoneNumber.tr(),
              textInputType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(height: kScreenPaddingNormal,),
            CustomTextFormFiledPassword(
              image: Assets.lock,
              borderColor: AppColors.main30,
              backGroundColor: AppColors.textFieldColor,
              imageColor: AppColors.main,
              hintText: LocaleKeys.kPassword,
              textInputType: TextInputType.text,
              controller: _passwordController,
            ),
            const SizedBox(height: kScreenPaddingNormal,),
             CustomTextFormFiledPassword(
              image: Assets.lock,
               borderColor: AppColors.main30,
               backGroundColor: AppColors.textFieldColor,
               imageColor: AppColors.main,
              hintText: LocaleKeys.kConfirmPassword,
              controller: _confirmPasswordController,
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(vertical: 8.h),
            //   child: Row(
            //     children: [
            //       Text(
            //         'createPassword'.tr(),
            //         style: TextStyles()
            //             .getTitleStyle(fontSize: 16.sp)
            //             .customColor(AppColors.main),
            //         softWrap: true,
            //         textAlign: TextAlign.start,
            //       ),
            //     ],
            //   ),
            // ),
            // Card(
            //   color: AppColors.main30,
            //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),),
            //   child:Padding(
            //     padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             CircleAvatar(
            //             backgroundColor: AppColors.main,
            //             maxRadius: 5.r,
            //             minRadius: 5.r,
            //             ),
            //             SizedBox(width: 10.w),
            //             Text(
            //               'ItMustLessThan'.tr(),
            //               style: TextStyles()
            //                   .getTitleStyle(fontSize: 12.sp)
            //                   .customColor(AppColors.black),
            //               softWrap: true,
            //               textAlign: TextAlign.start,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             CircleAvatar(
            //             backgroundColor: AppColors.main,
            //             maxRadius: 5.r,
            //             minRadius: 5.r,
            //             ),
            //             SizedBox(width: 10.w),
            //             Text(
            //               'ContainLeastNumeric'.tr(),
            //               style: TextStyles()
            //                   .getTitleStyle(fontSize: 12.sp)
            //                   .customColor(AppColors.black),
            //               softWrap: true,
            //               textAlign: TextAlign.start,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             CircleAvatar(
            //             backgroundColor: AppColors.main,
            //             maxRadius: 5.r,
            //             minRadius: 5.r,
            //             ),
            //             SizedBox(width: 10.w),
            //
            //             Text(
            //               'ContainLeastLowercase'.tr(),
            //               style: TextStyles()
            //                   .getTitleStyle(fontSize: 12.sp)
            //                   .customColor(AppColors.black),
            //               softWrap: true,
            //               textAlign: TextAlign.start,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             CircleAvatar(
            //             backgroundColor: AppColors.main,
            //             maxRadius: 5.r,
            //             minRadius: 5.r,
            //             ),                        SizedBox(width: 10.w),
            //
            //             Text(
            //               'ContainLeastUppercase'.tr(),
            //               style: TextStyles()
            //                   .getTitleStyle(fontSize: 12.sp)
            //                   .customColor(AppColors.black),
            //               softWrap: true,
            //               textAlign: TextAlign.start,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             CircleAvatar(
            //             backgroundColor: AppColors.main,
            //             maxRadius: 5.r,
            //             minRadius: 5.r,
            //             ),                        SizedBox(width: 10.w),
            //
            //             Text(
            //               'languageEnglish'.tr(),
            //               style: TextStyles()
            //                   .getTitleStyle(fontSize: 12.sp)
            //                   .customColor(AppColors.black),
            //               softWrap: true,
            //               textAlign: TextAlign.start,
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )
            // PasswordFieldValidator(
            //   key: _passKey,
            //   minLength: 8,
            //   minLengthMessage: 'ItMustLessThan'.tr(),
            //   uppercaseCharCount: 1,
            //   uppercaseCharMessage: 'ContainLeastUppercase'.tr(),
            //   lowercaseCharCount: 1,
            //   lowercaseMessage: 'ContainLeastLowercase'.tr(),
            //   numericCharCount: 1,
            //   numericCharMessage:'ContainLeastNumeric'.tr(),
            //   specialCharCount: 1,
            //   specialCharacterMessage:'ContainLeastSpecial'.tr() ,
            //   defaultColor: AppColors.main,
            //   successColor: AppColors.green,
            //   failureColor: AppColors.main,
            //   controller: _passwordController,
            // ),
            // FlutterPwValidator(
            //   key: validatorKey,
            //   controller: _passwordController,
            //   minLength: 8,
            //   uppercaseCharCount: 1,
            //   lowercaseCharCount: 1,
            //   numericCharCount: 1,
            //   width: 400.w,
            //   height: 200.h,
            //   onSuccess: () {
            //     // print("MATCHED");
            //     // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            //     //     content: new Text("Password is matched")));
            //   },
            //   onFail: () {
            //     // print("NOT MATCHED");
            //   },
            // ),
          ],
        ));
  }
}
