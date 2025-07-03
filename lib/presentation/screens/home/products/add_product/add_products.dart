import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/presentation/screens/home/products/add_product/screen/pageOneAddProduct.dart';
import 'package:sulah_store/presentation/screens/home/products/add_product/screen/pageTwoAddProduct.dart';

import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/products_Model.dart';
import '../../../../component/appbars/custom_app_bar.dart';
import '../../../../component/custom_scaffold.dart';

class AddProducts extends StatelessWidget {
  AddProducts({Key? key, required this.isEdite, this.oneProducts}) : super(key: key);
  final OneProduct? oneProducts;
  final bool isEdite;
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
          title: (isEdite==false)?LocaleKeys.addaProducts.tr()
              : LocaleKeys.edit.tr(),
          titleColor: AppColors.black,
          color: AppColors.white),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PageOneAddProduct(controller: controller, isEdite: isEdite,oneProduct: oneProducts,),
          PageTwoAddProduct(controller: controller, isEdite: isEdite,oneProduct: oneProducts,),
        ],
      ),
    );
  }
}






