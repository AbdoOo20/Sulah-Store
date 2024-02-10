import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import 'package:khedmaty_store/core/utils/showToast.dart';
import 'package:khedmaty_store/data/repository/SaveUserData.dart';
import 'package:khedmaty_store/injection.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_assets.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../component/component.dart';
import '../../../component/inputs/new/customTextFormField.dart';
import '../../../component/inputs/new/customTextFormFieldPassword.dart';
import '../../../component/svg_icon.dart';
import '../forgetPassword/reserPassword/reset_password.dart';
import '../register/register.dart';
import 'LoginViewModel.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String phone = _phoneController.text;
        String password = _passwordController.text;
        if (phone.isEmpty) {
          ToastUtils.showToast("phoneIsRequired".tr());
        // } else if (phone.length!=9) {
        //   ToastUtils.showToast('phoneNumberLength'.tr());
        } else if (password.isEmpty) {
          ToastUtils.showToast("passwordMustBeEntered".tr());
        } else {
          Provider.of<LoginViewModel>(context, listen: false)
              .login(phone, password, context);
        }
      }
    }
  }
SaveUserData saveUserData = getIt();
  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<LoginViewModel>().isLoading;
    return CustomScaffold(
      body: ListAnimator(
        children: [
          Row(
            children: [
              Container(
                height: 325.h,
                width: 300.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        Assets.lanchBackGround,
                      ),
                      fit: BoxFit.cover),
                ),
                padding: const EdgeInsets.only(
                    top: 0, left: kFormPaddingAllLarge * 10),
                child: SVGIcon(
                  Assets.logo,
                  height: 120.h,
                  width: 170.78.w,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.titalloginbig.tr(),
                  style: TextStyles()
                      .getTitleStyle(fontSize: 24.sp)
                      .customColor(AppColors.black),
                ),
                Text(
                  LocaleKeys.titallogin.tr(),
                  style: TextStyles()
                      .getRegularStyle(fontSize: 14.sp)
                      .customColor(AppColors.darkGray),
                ),
                SizedBox(height: 32.h),
                _buildForm(),
                SizedBox(height: (16).h),
                Align(alignment: Alignment.centerLeft,
                  child: InkWell(
                    // onTap: (){push(const ResetPassword());},
                    child: Text(
                      LocaleKeys.forgotYourPassword.tr(),textAlign: TextAlign.end,
                      style: TextStyles()
                          .getRegularStyle(fontSize: 11.sp)
                          .customColor(AppColors.main),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: CustomButton(
                    borderRadius: 12.r,
                    color: AppColors.main,
                    loading: isLoading,
                    title: tr(LocaleKeys.login),
                    onTap: () {
                      _onSubmit(context);
                    },
                  ),
                ),

                SizedBox(height: 24.h),
                Align(alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                           LocaleKeys.youHaveAccount.tr(),
                          style: TextStyles()
                              .getRegularStyle(fontSize: 14.sp)
                              .customColor(AppColors.darkGray)),
                      InkWell(onTap: (){push(Register());},
                        child: Text(LocaleKeys.createAccount.tr(),
                          style: TextStyles()
                              .getRegularStyle(fontSize: 14.sp)
                              .customColor(AppColors.main),
                        ),
                      )
                    ],
                  ),
                  ),
               SizedBox(height: 25.h)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormFiled(
              height: 60,
              backGroundColor: AppColors.textFieldColor,
              borderColor: AppColors.grayLite,
              image: Assets.mobile,imageColor: AppColors.main,
              textInputType: TextInputType.phone,
              controller: _phoneController,
              hintText: LocaleKeys.phoneNumber.tr(),
            ),
            SizedBox(height: (16).h),
            CustomTextFormFiledPassword(
              backGroundColor: AppColors.textFieldColor,
              borderColor: AppColors.grayLite,
              image: Assets.lock,
              imageColor: AppColors.main,
              hintText: LocaleKeys.Password,
              textInputType: TextInputType.visiblePassword,
              controller: _passwordController,
            ),
          ],
        ));
  }
}
