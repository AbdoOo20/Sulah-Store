import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../component/component.dart';
import 'widgets/access.dart';
import 'widgets/documentation.dart';
import 'widgets/location.dart';
import 'widgets/store.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: tr(LocaleKeys.createAnAccount),
        titleColor: AppColors.black,
        color: AppColors.white),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Store(controller: controller,),
          Location(controller: controller,),
          Documentation(controller: controller),
          Access(controller: controller)
        ],
      ),
    );
  }
}






