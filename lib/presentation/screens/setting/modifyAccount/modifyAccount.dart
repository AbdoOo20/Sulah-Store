import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/utils/showToast.dart';
import 'package:khedmaty_store/presentation/component/inputs/new/customTextFormField.dart';
import 'package:khedmaty_store/presentation/component/svg_icon.dart';
import 'package:khedmaty_store/presentation/screens/setting/modifyAccount/widget/changePicture.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../injection.dart';
import '../../../../data/model/body/RegisterBody.dart';
import '../../../component/animation/list_animator.dart';
import '../../../component/appbars/custom_app_bar.dart';
import '../../../component/buttons/custom_button.dart';
import '../../../component/custom_scaffold.dart';
import '../../auth/register/widgets/map_location.dart';
import 'modify_account_view_model.dart';
class ModifyAccount extends StatefulWidget {
  const ModifyAccount({Key? key}) : super(key: key);

  @override
  State<ModifyAccount> createState() => _ModifyAccountState();
}

class _ModifyAccountState extends State<ModifyAccount> {
  RegisterBody registerBody=getIt();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  setData(){
    final provider =Provider.of<ModifyAccountViewModel>(context, listen: false).saveUserData;
    _phoneController.text=provider.getUserPhone();
      _emailController.text=provider.getUserEmail();
      _nameController.text=provider.getUserName();
      registerBody.departmentId =provider.getUserDepartmentId();
  }
  void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String name = _nameController.text;
        String email = _emailController.text;
        String phone = _phoneController.text;
        if (email.isEmpty) {
          ToastUtils.showToast('emailMustBeEntered'.tr());
        } else if (!email.isValidEmail()) {
          ToastUtils.showToast('checkYourEmail'.tr());
        } else if (name.isEmpty) {
          ToastUtils.showToast('storeMustBeEntered'.tr());
        } else if (phone.isEmpty) {
          ToastUtils.showToast('phoneIsRequired'.tr());
        } else {
          registerBody.email=email;
          registerBody.title=name;
          registerBody.phone=phone;
          Provider.of<ModifyAccountViewModel>(context,listen: false).modifyAccount(context,registerBody);
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    setData();
}
  @override
  Widget build(BuildContext context) {
   bool isLoading =Provider.of<ModifyAccountViewModel>(context, listen: true).isLoading;
   final provider =Provider.of<ModifyAccountViewModel>(context, listen: false).saveUserData;

   return CustomScaffold(
       appBar: CustomAppBar(
         title: LocaleKeys.editAccount.tr(),
         titleColor: AppColors.black,
         color: Colors.transparent,
       ),
       body: Padding(
         padding: EdgeInsets.only(top: 12.h, right: 16.w, left: 16.w, bottom: 24.h),
         child: Column(children: [

           Expanded(child: _buildForm()),
           SizedBox(
             height: 10.h,
           ),
           CustomButton(
             loading: isLoading,
             onTap: () {
               _onSubmit(context);
             },
             color: AppColors.main,
             title:'submit'.tr(),
           ),
         ]),
       ));
  }
  _buildForm() {
    final provider =Provider.of<ModifyAccountViewModel>(context, listen: false).saveUserData;
    return Form(
      key: _formKey,
      child: ListAnimator(
        children: [
          const Center(child: ChangePicture()),
          SizedBox(height: 16.h,),
          CustomTextFormFiled(
            height: 60,
            hintText: LocaleKeys.branchName.tr(),
            image: Assets.market1,
            imageColor: AppColors.main,
            backGroundColor: AppColors.textFieldColor,
            controller: _nameController,
            textInputType: TextInputType.text,
            borderColor: AppColors.grayLite,
          ),
          // GestureDetector(
          //   onTap: () {
          //     showModalBottomSheet(
          //         context: context,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.vertical(
          //             top: Radius.circular(25.0.r),
          //           ),
          //         ),
          //         builder: (context) {
          //           return SectionWidget();
          //         });
          //   },
          //   child: Container(
          //     height: 64.h,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12.r),
          //         color: AppColors.textFieldColor,
          //         border: Border.all(width: 1.w,color: AppColors.grayLite)
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.only(left: 12.w,right: 12.w),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             Provider.of<SectionWidgetViewModel>(context,listen: true).saveUserData.getUserDepartmentTitle()==''?
          //             "Section".tr():Provider.of<SectionWidgetViewModel>(context,listen: true).saveUserData.getUserDepartmentTitle(),
          //             style: TextStyles()
          //                 .getRegularStyle(fontSize: 14.sp)
          //                 .customColor(AppColors.black),
          //           ),
          //           Row(
          //             children: [
          //               Icon(Icons.expand_more,size: 10,color: AppColors.main,),
          //               SizedBox(width: 10.w,),
          //               SVGIcon(
          //                 Assets.section,
          //                 height: 25.h,
          //                 width: 25.w,
          //                 color: AppColors.main,
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            height: 284.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.textFieldColor),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.location.tr(),
                        style: TextStyles()
                            .getRegularStyle(fontSize: 14.sp)
                            .customColor(AppColors.black),
                      ),
                      SVGIcon(
                        Assets.location,
                        color: AppColors.main,
                        height: 20.h,
                        width: 20.w,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 207.33.h,
                  margin:EdgeInsets.symmetric(horizontal: 16.r) ,
                  padding: EdgeInsets.only(
                      top: 4.h, bottom: 4.h, right: 4.w, left: 4.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.white),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: MapLocation(lat: provider.getUserLat(),long: provider.getUserLong(),address: provider.getUserAddress())),
                )
              ],
            ),
          ),
          // CustomTextFormFiled(
          //   height: 60,
          //   image: Assets.mobile,
          //   imageColor: AppColors.main,
          //   hintText: LocaleKeys.phoneNumber.tr(),
          //   textInputType: TextInputType.phone,
          //   backGroundColor: AppColors.textFieldColor,
          //   borderColor: AppColors.grayLite,
          //   controller: _phoneController,
          // ),
          CustomTextFormFiled(
            height: 60,
            image: Assets.email,
            imageColor: AppColors.main,
            hintText: LocaleKeys.email.tr(),
            textInputType: TextInputType.emailAddress,
            backGroundColor: AppColors.textFieldColor,
            borderColor: AppColors.grayLite,
            controller: _emailController,
          ),
          // CustomTextFormFiledPassword(
          //   image: Assets.lock,
          //   imageColor: AppColors.main,
          //   hintText: LocaleKeys.kPassword.tr(),
          //   textInputType: TextInputType.text,
          //   backGroundColor: AppColors.textFieldColor,
          //   controller: _passwordController,
          // ),
          // CustomTextFormFiledPassword(
          //   image: Assets.lock,
          //   imageColor: AppColors.main,
          //   hintText: LocaleKeys.kConfirmPassword.tr(),
          //   textInputType: TextInputType.text,
          //   backGroundColor: AppColors.textFieldColor,
          //   controller: _confirmPasswordController,
          // ),
        ],
      ),
    );
  }
}
