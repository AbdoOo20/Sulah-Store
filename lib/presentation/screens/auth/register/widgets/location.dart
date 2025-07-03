import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../injection.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/svg_icon.dart';
import '../RegisterViewModel.dart';
import 'bottomPart.dart';
import 'map_location.dart';
import 'status.dart';
import 'upperPart.dart';

class Location extends StatefulWidget {
  const Location({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  RegisterBody registerBody = getIt();
  RegisterViewModel registerViewModel = getIt();
  final TextEditingController _iBANBankAccountNumberController =
      TextEditingController();

  void _onSubmit(context) async {
    String iban =_iBANBankAccountNumberController.text;
    registerBody.iban=iban;
    if (registerBody.address?.isEmpty??false) {
          ToastUtils.showToast('theLocationMustBeSpecified'.tr());

        }else{
          widget.controller.animateToPage(2,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(builder: (context, data, child) {
      return Column(
        children: [
          Status(width: MediaQuery.of(context).size.width / 2),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: kFormPaddingAllLarge * 2.4.h,
                  right: kScreenPaddingNormal,
                  left: kScreenPaddingNormal),
              child: ListAnimator(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const UpperPart(
                    title: LocaleKeys.kLocation,
                    body: LocaleKeys.kLocationBody,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kScreenPaddingNormal),
                    child: Container(
                      height: 274.33.h,
                        width: 343.w,
                        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.textFieldColor,
                            borderRadius:BorderRadius.circular(12.r) ,
                            border: Border.all(color:AppColors.textFieldBorderColor)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.kLocation.tr(),
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 14.sp)
                                      .customColor(AppColors.black),
                                  softWrap: true,
                                ),
                                SVGIcon(
                                  Assets.location,
                                  width: 24.w,
                                  height: 24.h,
                                  color: AppColors.main,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  height: 207.33.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: const MapLocation(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          BottomPart(
            controller: widget.controller,
            next: () {
             _onSubmit(context);
            },
            previous: () {
              widget.controller.animateToPage(0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
            },
          ),
          SizedBox(height: 32.h),
        ],
      );
    });
  }
}
