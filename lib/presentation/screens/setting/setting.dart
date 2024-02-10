import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/presentation/screens/setting/ratings/ratings.dart';
import 'package:khedmaty_store/presentation/screens/setting/setting_view_model.dart';
import 'package:khedmaty_store/presentation/screens/setting/wallet/wallet.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/routing/route.dart';
import '../../../data/repository/SaveUserData.dart';
import '../../../injection.dart';
import '../../component/svg_icon.dart';
import '../../sheet/change_language/change_language_sheet.dart';
import 'connect_Us/connect_us.dart';
import 'modifyAccount/modifyAccount.dart';
import 'widget/custom_switch.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<void> _loadData(BuildContext context) async {
    await Provider.of<SettingViewModel>(context, listen: false)
        .getProfile(context);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
  }
  SaveUserData saveUserData = getIt();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title:LocaleKeys.setting.tr(),
      ),
        body: Consumer<SettingViewModel>(
            builder: (context, data, child) => RefreshIndicator(
                onRefresh: () async => await _loadData(context),
                child: ScreenStateLayout(
                    isLoading: data.profileModel == null,
                    builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            top: 24.h, right: 16.w, left: 16.w),
                        child: Column(children: [
                          SizedBox(height: 24.h),
                          Expanded(
                            child: ListAnimator(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15),
                                      color: AppColors.grayLite),
                                  child: Column(children: [
                                    _buildItem(context,
                                        hasSwitch: true,
                                        value: data.profileModel?.data?.status==1?true:false,
                                        type: 'status',
                                        image: Assets.market1,
                                        title: LocaleKeys.available.tr(),
                                        onTap: () {},
                                        imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.editAccount,
                                        title: LocaleKeys.editAccount.tr(),
                                        onTap: () {
                                      push(const ModifyAccount());
                                    }, imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.walletIcon,
                                        title: LocaleKeys.wallet.tr(),
                                        onTap: () {
                                      push(const Wallet());
                                    }, imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.star,
                                        title: LocaleKeys.ratings.tr(),
                                        onTap: () {
                                      push(const Ratings());
                                    }, imageColor: AppColors.main),
                                    _buildItem(context,
                                        hasSwitch: true,
                                        value: data.profileModel?.data?.notificationStatus==1?true:false,
                                        type: 'notification-status',
                                        image: Assets.pillImage,
                                        title: tr(LocaleKeys.notification),
                                        onTap: () {
                                        },
                                        imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.langImage,
                                        title: tr(LocaleKeys.language),
                                        onTap: () {
                                      showChangeLanguageSheet(context);
                                    }, imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.connectUs1,
                                        title: tr(LocaleKeys.connectUs),
                                        onTap: () {
                                      push(ConnectUs());
                                    }, imageColor: AppColors.main),
                                    _buildItem(context,
                                        image: Assets.deleteAccount,
                                        title: LocaleKeys.deleteAnAccount.tr(), onTap: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                backgroundColor:
                                                    AppColors.main10,
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                ),
                                                title: Center(
                                                  child: Text(
                                                    LocaleKeys.alert.tr(),
                                                    style: TextStyles()
                                                        .getTitleStyle(
                                                            fontSize: 20)
                                                        .customColor(
                                                            Colors.red),
                                                  ),
                                                ),
                                                content: Text(
                                                  LocaleKeys
                                                      .deleteYourAccount
                                                      .tr(),
                                                  style: TextStyles()
                                                      .getTitleStyle(
                                                          fontSize: 16)
                                                      .customColor(
                                                          AppColors.black),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context,
                                                            LocaleKeys
                                                                .cancel
                                                                .tr()),
                                                    child: Text(
                                                      LocaleKeys.cancel
                                                          .tr(),
                                                      style: TextStyles()
                                                          .getTitleStyle(
                                                              fontSize: 16)
                                                          .customColor(
                                                              AppColors
                                                                  .main),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed:Provider.of<SettingViewModel>(context, listen: true).isDeleteProLoading?(){} :() =>
                                                        data.deleteAccount(
                                                            context),
                                                    child:Provider.of<SettingViewModel>(context, listen: true).isDeleteProLoading?SizedBox(
                                                        width: 20.w,height: 20.h,
                                                        child: const CircularProgressIndicator(strokeWidth: 2.5,color: AppColors.main,)): Text(
                                                      LocaleKeys.ok.tr(),
                                                      style: TextStyles()
                                                          .getTitleStyle(
                                                              fontSize: 16)
                                                          .customColor(
                                                              AppColors
                                                                  .main),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                        color: Colors.red,
                                        imageColor: Colors.red),
                                  ]),
                                ),
                                CustomTextButton(
                                  text: tr(LocaleKeys.logOut),
                                  textColor: AppColors.darkGray,
                                  textSize: 14.sp,
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor: AppColors.main10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        title: Center(
                                          child: Text(
                                            LocaleKeys.alert.tr(),
                                            style: TextStyles()
                                                .getTitleStyle(fontSize: 20)
                                                .customColor(Colors.red),
                                          ),
                                        ),
                                        content: Text(
                                          LocaleKeys.youLogOut.tr(),
                                          style: TextStyles()
                                              .getTitleStyle(fontSize: 16)
                                              .customColor(AppColors.black),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context,
                                                LocaleKeys.cancel.tr()),
                                            child: Text(
                                              LocaleKeys.cancel.tr(),
                                              style: TextStyles()
                                                  .getTitleStyle(
                                                      fontSize: 16)
                                                  .customColor(
                                                      AppColors.main),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed:Provider.of<SettingViewModel>(context, listen: true).isLogOutLoading?(){} : () {
                                              data.logOut(context);
                                            },
                                            child:Provider.of<SettingViewModel>(context, listen: true).isLogOutLoading?SizedBox(
                                                width: 20.w,height: 20.h,
                                                child: const CircularProgressIndicator(strokeWidth: 2.5,color: AppColors.main,)): Text(
                                              LocaleKeys.ok.tr(),
                                              style: TextStyles()
                                                  .getTitleStyle(
                                                      fontSize: 16)
                                                  .customColor(
                                                      AppColors.main),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ])))
                )));
  }
}

_buildItem(BuildContext context,
    {required String image,
    required String title,
    String? type,
    bool? value,
    Color? color,
    Color? imageColor,
    GestureTapCallback? onTap,
    bool? hasSwitch}) {
  return ListTile(
    onTap: onTap,
    trailing: hasSwitch == true
        ? SwitchScreen(
            type: type ?? '',
            value: value ?? false,
          )
        : color != null
            ? null
            : Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: color ?? AppColors.black,
              ),
    title: Text(
      title.tr(),
      style: TextStyles()
          .getRegularStyle(fontSize: 14.sp)
          .customColor(color ?? AppColors.semeBlack),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(left:5,right: 5 ),
      child: SVGIcon(
        image,
        color: imageColor,
        width: 22.w,
        height: 22.h,
      ),
    ),
  );
}

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key, required this.type, required this.value});

  final String type;
  final bool value;

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    bool isSwitch = !widget.value;
    return CustomSwitch(
      value: isSwitch,
      activeColor: AppColors.darkGray,
      inactiveColor: AppColors.main,
      onChanged: (value) {
        Provider.of<SettingViewModel>(context, listen: false)
            .updateAndNotification(context, widget.type);
        setState(() {
        });
      },
    );
  }
}
