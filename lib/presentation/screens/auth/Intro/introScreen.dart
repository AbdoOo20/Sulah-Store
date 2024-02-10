import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/screens/auth/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_assets.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../../core/routing/route.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../injection.dart';
import '../../../component/buttons/custom_button.dart';
import '../../../component/custom_scaffold.dart';
import '../../../component/svg_icon.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SaveUserData saveUserData = getIt();
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<String> _imagePaths = [
    Assets.intro1,
    Assets.intro2,
    Assets.intro3,
  ];
  final List<String> _textTitlePaths = [
    LocaleKeys.introBigTitle1.tr(),
    LocaleKeys.introBigTitle2.tr(),
    LocaleKeys.introBigTitle3.tr(),
  ];
  final List<String> _textSubTitlePaths = [
    LocaleKeys.introTitle1.tr(),
    LocaleKeys.introTitle2.tr(),
    LocaleKeys.introTitle3.tr(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child:Column(
          children: [
            SizedBox(
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 8.w,bottom: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SVGIcon(Assets.logo,height: 50.h,width: 111.w,),
                    CustomButton(
                        width: 70.w,
                        height: 38.h,
                        isRounded: false,
                        borderRadius: 20.r,
                        fontSize: 12.r,
                        borderColor: AppColors.grayLite,
                        color: AppColors.grayLite,
                        title: LocaleKeys.skip.tr(),
                        textColor: AppColors.black,
                        onTap: (){
                          saveUserData.saveIsIntroShow(true);
                          pushAndRemoveUntil(const LoginScreen());
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimationConfiguration.synchronized(
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 1000),
                      child: AnimationLimiter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(_imagePaths[_currentPage],
                                  width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.460,
                                // width: MediaQuery.of(context).size.width,height:380.h,
                              ),
                              Column(
                                children: [
                                  Text(
                                    _textTitlePaths[_currentPage],
                                    style: TextStyles()
                                        .getTitleStyle(fontSize: 28.sp)
                                        .customColor(AppColors.darkGray),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Text(
                                      _textSubTitlePaths[_currentPage],
                                      style: TextStyles()
                                          .getRegularStyle(fontSize: 14.sp)
                                          .customColor(AppColors.darkGray),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect:  const ExpandingDotsEffect(
                      activeDotColor: AppColors.main,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                  ),
                  SizedBox(height: 15.h,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _currentPage == 0 ? const SizedBox():
                      InkWell(
                        onTap: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                          }
                        },
                        child: SizedBox(
                          height: 50.h,
                          width: 50.w,
                          child: SVGIcon(Assets.back,height: 50.h,width: 50.w,),
                        ),
                      ),
                      SizedBox(width: 7.w,),
                      _currentPage == 2 ?
                      CustomButton(
                          width: 70.w,
                          height: 50.h,
                          isRounded: false,
                          borderRadius: 25.r,
                          fontSize: 12.r,
                          borderColor: AppColors.grayLite,
                          color: AppColors.grayLite,
                          title: LocaleKeys.start.tr(),
                          textColor: AppColors.black,
                          onTap: (){
                            saveUserData.saveIsIntroShow(true);
                            pushAndRemoveUntil(const LoginScreen());
                          })
                          :
                      InkWell(
                        onTap: () {
                          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        },
                        child: SizedBox(
                          height: 50.h,
                          width: 50.w,
                          child: SVGIcon(Assets.next,height: 50.h,width: 50.w,),
                        ),
                      ),
                    ],
                  )


                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}