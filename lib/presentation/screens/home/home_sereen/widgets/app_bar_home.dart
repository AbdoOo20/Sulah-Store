import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/resources/resources.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:khedmaty_store/presentation/screens/setting/setting.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/routing/route.dart';
import '../../../../component/svg_icon.dart';
import '../../Notifications/Notifications.dart';
import '../homeViewModel.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}
class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
        builder: (context, data, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: SizedBox(
                          width: 48.w,
                          height: 42.5.h,
                          child: CommonNetworkImage(
                              imageUrl: data.saveUserData.getUserImage())),
                    ),
                    // SVGIcon(
                    //   Assets.logo,
                    //   width: 48.w,
                    //   height: 42.5.h,
                    // ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.hello.tr(),
                          style: TextStyles()
                              .getRegularStyle(fontSize: 12)
                              .customColor(AppColors.darkGray),
                        ),
                        Text(
                          data.saveUserData.getUserName(),
                          style: TextStyles()
                              .getTitleStyle(fontSize: 16)
                              .customColor(AppColors.semeBlack),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        push(const Setting());
                      },
                      child: Container(
                        width: (48.w),
                        height: (48.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.grayLite),
                        child: Center(
                          child: SVGIcon(
                            Assets.settingsIcon,
                            width: (24.w),
                            height: (24.h),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w)
                    // InkWell(
                    //   onTap: () {
                    //     // push(const Notifications());
                    //   },
                    //   child: Stack(
                    //     children: <Widget>[
                    //       Container(
                    //         width: (48.w),
                    //         height: (48.h),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(16.r),
                    //             color: AppColors.grayLite),
                    //         child: Center(
                    //           child: SVGIcon(
                    //             Assets.bell,
                    //             width: (24.w),
                    //             height: (24.h),
                    //           ),
                    //         ),
                    //       ),
                    //       // data.homeModel?.data?.notificationCount != null ||
                    //       //         data.homeModel?.data?.notificationCount != 0
                    //       //     ? SizedBox():
                    //       // Positioned(
                    //       //         top: 5,
                    //       //         right: 5,
                    //       //         child: Container(
                    //       //           padding: const EdgeInsets.all(2),
                    //       //           decoration: BoxDecoration(
                    //       //             borderRadius:
                    //       //                 BorderRadius.circular(100.r),
                    //       //             border: Border.all(
                    //       //                 width: .8.w,
                    //       //                 color: AppColors.grayLite),
                    //       //             color: AppColors.main,
                    //       //           ),
                    //       //           child: Center(
                    //       //             child: Text(
                    //       //               // data.homeModel?.data?.notificationCount.toString() ?? '',
                    //       //               '2',
                    //       //               style: TextStyles()
                    //       //                   .getTitleStyle(fontSize: 9.sp)
                    //       //                   .customColor(AppColors.white),
                    //       //             ),
                    //       //           ),
                    //       //         ),
                    //       //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ));
  }
}
