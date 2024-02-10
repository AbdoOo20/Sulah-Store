import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/component/buttons/custom_button.dart';
import 'package:khedmaty_store/presentation/component/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../data/model/body/contact_UsBody.dart';
import '../../../../core/helper/socialMediaHelper.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/utils/showToast.dart';
import '../../../component/animation/list_animator.dart';
import '../../../component/appbars/custom_app_bar.dart';
import '../../../component/custom_scaffold.dart';
import '../../../component/inputs/custom_text_field_area.dart';
import '../../../component/inputs/custom_text_field_normal.dart';
import '../../../component/inputs/new/customTextFormField.dart';
import '../../../component/spaces.dart';
import '../setting_view_model.dart';
import 'contactUs_view_model.dart';

class ConnectUs extends StatelessWidget {
  ConnectUs({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  SocialMediaHelper socialMediaHelper =SocialMediaHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loading =
        Provider.of<ContactUsViewModel>(context, listen: true).isLoading;
    return CustomScaffold(
        appBar: CustomAppBar(
          color: Colors.transparent,
          title: LocaleKeys.connectUs.tr(),
          titleColor: AppColors.black,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: 16.w, right: 16.w, top: 24.h, bottom: 24.h),
          child: Column(
            children: [
              Expanded(
                child: ListAnimator(
                  children: [
                    SVGIcon(Assets.topCon,
                        width: 196.42025756835938.w, height: 150.h),
                    VerticalSpace(12.h),
                    // Center(
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           socialMediaHelper.openEmailApp(Provider.of<SettingViewModel>(context,
                    //               listen: false)
                    //               .settingModel
                    //               ?.data
                    //               ?.email??"");
                    //         },
                    //         child: Container(
                    //           width: 166.5.w,
                    //           height: 44.h,
                    //           padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(100.r),
                    //               color: AppColors.main30),
                    //           child: Center(
                    //               child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               SVGIcon(
                    //                 Assets.gmail,
                    //                 width: 24.w,
                    //                 height: 24.h,
                    //               ),
                    //               Text(
                    //                 LocaleKeys.email.tr(),
                    //                 style: TextStyles()
                    //                     .getRegularStyle(fontSize: 14.sp)
                    //                     .customColor(AppColors.main),
                    //               )
                    //             ],
                    //           )),
                    //         ),
                    //       ),
                    //       SizedBox(width: 8.w),
                    //       InkWell(
                    //         onTap: () {
                    //           socialMediaHelper.openWhatsApp(Provider.of<SettingViewModel>(context,
                    //               listen: false)
                    //               .settingModel
                    //               ?.data
                    //               ?.whatsapp
                    //               ??'' );
                    //
                    //         },
                    //         child: Container(
                    //           width: 166.5.w,
                    //           height: 44.h,
                    //           padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(100.r),
                    //               color: AppColors.green1),
                    //           child: Center(
                    //               child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               SVGIcon(
                    //                 Assets.whatsApp,
                    //                 width: 24.w,
                    //                 height: 24.h,
                    //               ),
                    //               Text(
                    //                 'whatsApp'.tr(),
                    //                 style: TextStyles()
                    //                     .getRegularStyle(fontSize: 14.sp)
                    //                     .customColor(AppColors.green),
                    //               )
                    //             ],
                    //           )),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // VerticalSpace(12.h),
                    // Center(
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       InkWell(
                    //           onTap: () {
                    //             socialMediaHelper.openFacebookApp(Provider.of<SettingViewModel>(context,
                    //                 listen: false)
                    //                 .settingModel
                    //                 ?.data
                    //                 ?.facebook
                    //                 ??'' );
                    //
                    //           },child: SVGIcon(Assets.faceBook,width: 48.w,height: 48.h,)),
                    //       SizedBox(width: 8.w),
                    //       InkWell(
                    //           onTap: () {
                    //             socialMediaHelper.openInstagramApp(Provider.of<SettingViewModel>(context,
                    //                 listen: false)
                    //                 .settingModel
                    //                 ?.data
                    //                 ?.instagram
                    //                 ??'' );
                    //
                    //           },child: SVGIcon(Assets.cameraSetting,width: 48.w,height: 48.h,)),
                    //       SizedBox(width: 8.w),
                    //       InkWell(
                    //           onTap: () {
                    //             socialMediaHelper.openTwitterApp(Provider.of<SettingViewModel>(context,
                    //                 listen: false)
                    //                 .settingModel
                    //                 ?.data
                    //                 ?.twitter
                    //                 ??'' );
                    //
                    //           },child: SVGIcon(Assets.tatter,width: 48.w,height: 48.h,)),
                    //       SizedBox(width: 8.w),
                    //       InkWell(
                    //           onTap: () {
                    //             socialMediaHelper.openInstagramApp(Provider.of<SettingViewModel>(context,
                    //                 listen: false)
                    //                 .settingModel
                    //                 ?.data
                    //                 ?.snapchat
                    //                 ??'' );
                    //
                    //           },child: SVGIcon(Assets.alarmSetting,width: 48.w,height: 48.h,)),
                    //     ],
                    //   ),
                    // ),
                    VerticalSpace(12.h),
                    _buildForm(context),
                    VerticalSpace(48.h),
                  ],
                ),
              ),
              CustomButton(
                  color: AppColors.main,
                  borderRadius: 16.r,
                  loading: loading,
                  title: LocaleKeys.send.tr(),
                  onTap: () {
                    _onSubmit(context);
                  })
            ],
          ),
        ));
  }

  _buildForm(context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFieldNormal(
              noBorder: false,
              background: Colors.transparent,
              iconSVG: Assets.personSvg,
              hint: LocaleKeys.name.tr(),
              controller: _nameController,
            ),
            VerticalSpace(12.h),
            CustomTextFieldNormal(
              background: Colors.transparent,
              iconSVG: Assets.emailSvg,
              hint: LocaleKeys.email.tr(),
              controller: _emailController,
            ),
            VerticalSpace(12.h),
            CustomTextFieldNormal(
              background: Colors.transparent,
              iconSVG: Assets.messageSubject,
              hint: LocaleKeys.messageTitle.tr(),
              controller: _subjectController,

            ),
            VerticalSpace(12.h),
            CustomTextFieldArea(
              lines: 7,
              background: Colors.transparent,
              iconSVG: Assets.messageSvg,
              hint: LocaleKeys.message.tr(),
              controller: _messageController,
            ),
          ],
        ));
  }

  void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String name = _nameController.text;
        String email = _emailController.text;
        String subject = _subjectController.text;
        String message = _messageController.text;
        if (name.isEmpty) {
          ToastUtils.showToast('nameIsRequired'.tr());
        } else if (email.isEmpty) {
          ToastUtils.showToast('emailIsRequired'.tr());
        } else if (email.isValidEmail()) {
          ToastUtils.showToast('checkYourEmail'.tr());
        } else if (subject.isEmpty) {
          ToastUtils.showToast('messageTitleReq'.tr());
        } else if (message.isEmpty) {
          ToastUtils.showToast('messageIsRequired'.tr());
        } else {
          ContactUsBody body = ContactUsBody();
          body.message = message;
          body.email = email;
          body.name = name;
          body.subject = subject;
          Provider.of<ContactUsViewModel>(context, listen: false)
              .contactUsApi(context, body);
        }
      }
    }
  }
}
