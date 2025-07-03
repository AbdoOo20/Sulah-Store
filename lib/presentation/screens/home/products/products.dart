import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/app_colors.dart';
import 'package:sulah_store/presentation/component/component.dart';
import 'package:sulah_store/presentation/screens/home/products/custom_card_product/custom_card_product.dart';
import 'package:sulah_store/presentation/screens/home/products/products_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../../core/routing/route.dart';
import 'add_product/add_products.dart';
import 'custom_card_product/custom_add_product.dart';
import 'custom_card_product/edit_bottom_sheet.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  // final String? categoryId;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  Future<void> _loadData(BuildContext context) async {
    await Provider.of<ProductsViewModel>(context, listen: false)
        .getProducts(context, '');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Products.tr(),
        titleColor: AppColors.black,
        color: Colors.transparent,
      ),
      body: Container(
        color: AppColors.productScreenColor,
        child: RefreshIndicator(
            onRefresh: () async => await _loadData(context),
            child: Consumer<ProductsViewModel>(
                builder: (context, productsData, child) => Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                            child: InkWell(
                                onTap: () {
                                  push(AddProducts(isEdite: false));
                                },
                                child: const AddProduct()),
                          ),
                          Expanded(
                              child: ScreenStateLayout(
                                  isLoading:
                                      (productsData?.productsModel?.data ==
                                              null ||
                                          productsData.loading == true),
                                  isEmpty: productsData
                                          ?.productsModel?.data?.isEmpty ??
                                      false,
                                  onRetry: () => _loadData(context),
                                  builder: (context) => GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1 / 1.3,
                                          crossAxisSpacing: 8.h,
                                          mainAxisSpacing: 8.h,
                                        ),
                                        itemCount: productsData
                                            .productsModel?.data?.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20.r),
                                                  ),
                                                ),
                                                builder: (context) =>
                                                    EditBottomSheet(
                                                  oneProduct: productsData
                                                      .productsModel
                                                      ?.data?[index],
                                                  index: index,
                                                ),
                                              );
                                            },
                                            child: CustomCaredProducts(
                                              url: productsData
                                                      .productsModel
                                                      ?.data?[index]
                                                      .mainImage ??
                                                  "",
                                              title: productsData.productsModel
                                                      ?.data?[index].title ??
                                                  "",
                                              productId: productsData
                                                      .productsModel
                                                      ?.data?[index]
                                                      .id ??
                                                  0,
                                              isShow: productsData.productsModel
                                                      ?.data?[index].isShow ??
                                                  0,
                                              index: index,
                                            ),
                                          );
                                        },
                                      )))
                        ],
                      ),
                    ))),
      ),
    );
  }
}
