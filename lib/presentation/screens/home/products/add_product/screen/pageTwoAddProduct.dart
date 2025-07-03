import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/presentation/component/animation/list_animator.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../../core/utils/showToast.dart';
import '../../../../../../data/model/body/compatible_with_body.dart';
import '../../../../../../data/model/body/porduct_body.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../../injection.dart';
import '../../../../../component/buttons/custom_button.dart';
import '../../../../../component/inputs/new/customTextFormField.dart';
import '../../../../../component/screen_state_layout.dart';
import '../../../../auth/register/widgets/status.dart';
import '../../products_view_model.dart';
import '../add_product_view_model.dart';
import '../widget/add_Offer.dart';
import '../widget/chick_box.dart';
import '../widget/title_item.dart';
import 'compatible_with_provider.dart';

class PageTwoAddProduct extends StatefulWidget {
  const PageTwoAddProduct(
      {Key? key,
      this.oneProduct,
      required this.isEdite,
      required this.controller})
      : super(key: key);
  final OneProduct? oneProduct;
  final bool isEdite;
  final PageController controller;

  @override
  State<PageTwoAddProduct> createState() => _PageTwoAddProductState();
}

class _PageTwoAddProductState extends State<PageTwoAddProduct> {
  final _formKey = GlobalKey<FormState>();
  ProductsBody productsBody = getIt();
  CompatibleWithViewModel compatibleWith = getIt();
  ProductsViewModel productViewModel = getIt();
  AddProductViewModel addProductViewModel = getIt();
  bool _isChecked = false;

  /// required
  final TextEditingController _priceController = TextEditingController();
  setData() {
    compatibleWith.compatibleWithBody=[];
    if (widget.oneProduct != null && widget.isEdite == true) {
      ///set price
      _priceController.text = widget.oneProduct?.price.toString() ?? '';
      ///set compatible With
      for(int i=0;i<(widget.oneProduct?.productsAdditions?.length??0);i++) {
       CompatibleWithBody body =CompatibleWithBody();
       body.car=widget.oneProduct?.productsAdditions?[i].car?.title;
       body.carId=widget.oneProduct?.productsAdditions?[i].car?.id.toString();
       body.brandId=widget.oneProduct?.productsAdditions?[i].brand?.id.toString();
       body.brand=widget.oneProduct?.productsAdditions?[i].brand?.title;
       body.manufactureYear=widget.oneProduct?.productsAdditions?[i].manufactureYear;
       Provider.of<CompatibleWithViewModel>(context, listen: false).addAddition(body);
}

  /// set Offer
      _isChecked = widget.oneProduct?.productsOffers == null ? false:true;
        widget.oneProduct?.productsOffers?.type == "percentage"
            ? productViewModel.typeOfferSelect = true
            : productViewModel.typeOfferSelect = false;
        productViewModel.discountValueController.text =
            widget.oneProduct?.productsOffers?.value.toString() ?? "00";
        productViewModel.startDateController.text =
            widget.oneProduct?.productsOffers?.fromDate ?? "";
        productViewModel.endDateController.text =
            widget.oneProduct?.productsOffers?.toDate ?? "";
    }else{
      _priceController.text='';
    }
  }

  Future<void> _loadData(BuildContext context) async {
    await Provider.of<CompatibleWithViewModel>(context, listen: false)
        .getBrands(context);
    await Provider.of<CompatibleWithViewModel>(context, listen: false).getCars(context);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
    setData();
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ProductsViewModel>().isLoading;
    return Consumer<CompatibleWithViewModel>(
        builder: (context, data, _) => RefreshIndicator(
            onRefresh: () async {
              _loadData(context);
            },
            child: ScreenStateLayout(
                isLoading: data.carsModel == null || data.brandsModel == null,
                builder: (context) => ListAnimator(
                      children: [
                        Status(width: MediaQuery.of(context).size.width / 1),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 24.h, left: 16.w, right: 16.w),
                          child: Column(
                            children: [
                              _buildForm(),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked();
                                    });
                                  },
                                  child: ChickBoxWidget(isChecked: _isChecked)),
                              _isChecked
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 19.h, bottom: 25.5.h),
                                      child: AddOffer(
                                        productsModel: widget.oneProduct,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 10.h,
                                    ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      width: 165.5.w,
                                      color: AppColors.white,
                                      title: tr(LocaleKeys.Previous),
                                      textColor: AppColors.black,
                                      borderColor: AppColors.black,
                                      borderRadius: 12,
                                      onTap: () {
                                        widget.controller.animateToPage(0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      },
                                    ),
                                    CustomButton(
                                      width: 165.5.w,
                                      color: AppColors.main,
                                      borderRadius: 12,
                                      loading: isLoading,
                                      title: tr(LocaleKeys.submit),
                                      onTap: () {
                                        _onSubmit(context, _isChecked ? 1 : 0);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))));
  }

  void _onSubmit(context, int isOffer) async {
    String price = _priceController.text;
    String discountValue = productViewModel.discountValueController.text;
    String startDate = productViewModel.startDateController.text;
    String endDate = productViewModel.endDateController.text;
    ///compatible with
    List<ProductListBody>? productList = [];
    for (int i = 0; i < (compatibleWith.compatibleWithBody.length); i++) {
      ProductListBody body = ProductListBody();
      body.manufactureYear = compatibleWith.compatibleWithBody[i].manufactureYear;
      body.brandId = compatibleWith.compatibleWithBody[i].brandId;
      body.carId = compatibleWith.compatibleWithBody[i].carId;
      productList.add(body);
    }
    productsBody.productList = productList;
    bool isAllDataInterred =true;
    for (int i = 0; i < (productsBody.productList?.length ?? 0); i++) {
        if ((productsBody.productList?[i].carId== null) ||
            (productsBody.productList?[i].manufactureYear== null) ||
            (productsBody.productList?[i].brandId ==null)) {
          ToastUtils.showToast('allAdditionalDataMustEntered'.tr());
          isAllDataInterred=false;
        }
    }
    if (_formKey.currentState != null) {
      _formKey.currentState!.save();

      if (price.isEmpty) {
        ToastUtils.showToast('priceIsRequired'.tr());
      }
      else if (productsBody.productList?.isEmpty ?? true) {
        ToastUtils.showToast('allAdditionalDataMustEntered'.tr());
      }
      else if (isAllDataInterred==false) {
        ToastUtils.showToast('allAdditionalDataMustEntered'.tr());
      }
      else if (isOffer == 1 && (discountValue.isEmpty || startDate.isEmpty || endDate.isEmpty)) {

        ToastUtils.showToast('allBidDataMustEntered'.tr());
      }
      else {
        productsBody.price = price;
        productsBody.isOffer = isOffer;
        ///offer
        if (isOffer == 1) {
          productsBody.offerType =
              productViewModel.typeOfferSelect ? "percentage" : "value";
          productsBody.offerValue = discountValue;
          productsBody.offerStartDate = startDate;
          productsBody.offerEndDate = endDate;
        }
        Provider.of<ProductsViewModel>(context, listen: false).createProduct(
            context,
            productsBody,
            widget.isEdite,
            widget.oneProduct?.id.toString(),
            addProductViewModel.images);
      }
    }
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Provider.of<CompatibleWithViewModel>(context, listen: false)
                .buildCompatibleWith(
              widget.isEdite,
              widget.oneProduct,
            ),
            TitleItem(image: Assets.price, title: LocaleKeys.theprice.tr()),
            Container(
              margin: EdgeInsets.only(top: 8.5.h, bottom: 24.h),
              height: 62.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.textFieldColor,
                border: Border.all(
                  color: AppColors.grayLite,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 289.w,
                    child: CustomTextFormFiled(
                      height: 60.h,
                      textInputType: TextInputType.number,
                      hintText: "${widget.oneProduct?.price ?? 00}",
                      backGroundColor: AppColors.textFieldColor,
                      controller: _priceController,
                    ),
                  ),
                  Container(
                    width: 51.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: AppColors.main,
                    ),
                    child: Center(
                        child: Text(
                      LocaleKeys.rial.tr(),
                      style: TextStyles()
                          .getTitleStyle(fontSize: 14.sp)
                          .customColor(AppColors.white),
                    )),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ));
  }
  void isChecked() {
    _isChecked = !_isChecked;
  }
}
