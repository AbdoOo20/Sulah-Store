import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/appbars/custom_app_bar.dart';
import '../../../../component/buttons/custom_button.dart';
import '../../../../component/custom_scaffold.dart';
import '../../../../component/inputs/new/customTextFormField.dart';
import '../../../../component/svg_icon.dart';
import '../newPassword/new_password_view_model.dart';
import '../otp/otp_view_model.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  void _set(context){
    _phoneController.text=Provider.of<NewPasswordViewModel>(context, listen: false).saveUserData.getUserPhone();
}
  void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String phone = _phoneController.text;
        if (phone.isEmpty) {
          ToastUtils.showToast('youMustEnterThePhoneNumber'.tr());
        }
        else {
          Provider.of<OtpViewModel>(context,listen: false).sendOTPFirebase(context,phone,'reset');
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _set(context);
  }
  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<OtpViewModel>(context, listen: true).loading;
    return CustomScaffold(
      appBar: CustomAppBar(height: 55.h, color: Colors.transparent,),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: SVGIcon(
                Assets.restpasswordlogo,
                width: 200.w,
                height: 200.h,
              ),
            ),
          ),
          const SizedBox(height: 70,),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: ListAnimator(
                  children: [
                    Text(
                      LocaleKeys.titalforget.tr(),
                      style: TextStyles()
                          .getTitleStyle(fontSize: 20.sp)
                          .customColor(AppColors.black),
                    ),
                    Text(
                      LocaleKeys.titalpassword.tr(),
                      style: TextStyles()
                          .getRegularStyle(fontSize: 12)
                          .customColor(AppColors.black),
                    ),
                    SizedBox(height: 5.w,),
                    Row(children: [
                      SVGIcon(Assets.phone,height: 20.h,width: 13.33.w),
                      SizedBox(width: 5.w,),
                      Text(LocaleKeys.phoneNumber.tr(),
                        style: TextStyles()
                            .getRegularStyle(fontSize: 12.sp)
                            .customColor(AppColors.black),
                      )
                    ],),
                    _buildForm(),
                    const SizedBox(height: (7)),
                    Center(
                      child: CustomButton(
                        color: AppColors.main,
                        loading: isLoading,
                        title: LocaleKeys.send.tr(),textColor: AppColors.white,
                        onTap: () {
                          _onSubmit(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  _buildForm(){
    return Form(
        key: _formKey,child: CustomTextFormFiled(  textInputType: TextInputType.phone, controller: _phoneController,backGroundColor: AppColors.textFieldColor,hintText: LocaleKeys.phoneNumber.tr(),
        borderColor: AppColors.grayLite,));
  }
}
