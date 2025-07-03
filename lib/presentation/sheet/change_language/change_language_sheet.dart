import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/routing/route.dart';
import '../../../../core/logger.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_assets.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../main.dart';
import '../../../data/repository/SaveUserData.dart';
import '../../../injection.dart';
import '../../component/buttons/custom_button.dart';
import '../../component/screen_state_layout.dart';
import '../../component/spaces.dart';
import '../../component/svg_icon.dart';
import '../../screens/splash/splash.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChangeLanguageSheet extends StatefulWidget {
  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();

  const ChangeLanguageSheet({super.key});
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  SaveUserData saveUserData = getIt();

  final tag = 'ChangeLanguageSheet';
 late Locale locale = context.locale;
  @override
  void initState() {
    super.initState();
    // locale = context.locale
  }

  void _onLanguageSelected() {
    log('onLanguageSelected', 'change language to (${locale.languageCode})');
    saveUserData.saveLang(locale.languageCode);
    if (saveUserData.isLoggedIn()) {
      // Provider.of<OtpViewModel>(context,listen: false).updateFCMToken();
    }
    // Navigator.pop(context);
    pushAndRemoveUntil(const Splash());
    context.setLocale(locale) ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top: 40.r),
      padding: EdgeInsets.only(bottom: 32.h, top: 4.h),
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:  const EdgeInsets.all(kScreenPaddingNormal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr(LocaleKeys.language),
                    style: TextStyles()
                        .getTitleStyle(fontSize: 16.sp)
                        .customColor(AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child:const SVGIcon(Assets.svgExitIcon),
                  ),
                ],
              ),
            ),
            ScreenStateLayout(
              builder: (context) => buildBody(context,
                  items: supportedLocales, selectedItem: locale,),
            ),
            const VerticalSpace(kScreenPaddingNormal),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kScreenPaddingNormal),
              child: CustomButton(title: tr(LocaleKeys.submit),onTap: () =>_onLanguageSelected(),color: AppColors.main,),
            )
          ]),
    );
  }

  Widget buildBody(BuildContext context, {required List<Locale> items, required Locale selectedItem}) {
    return Container(
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: ListView(
          shrinkWrap: true,
          children: items.map((e) => buildSingleChoiceItem(context, selectedItem, e)).toList()),
    );
  }

  Widget buildSingleChoiceItem(BuildContext context, Locale selectedItem, Locale item) {
    return RadioListTile<Locale>(
      groupValue: selectedItem,
      activeColor: AppColors.main,
      title: Text(tr(item.languageCode)),
      value: item,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            locale = value;
          });
        }
      },
    );
  }
}

Future<dynamic> showChangeLanguageSheet(BuildContext context) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const SafeArea(child: ChangeLanguageSheet()),
  );}
