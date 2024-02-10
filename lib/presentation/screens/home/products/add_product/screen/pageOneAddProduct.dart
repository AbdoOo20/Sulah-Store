import 'dart:io';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/resources/locale_keys.g.dart';
import 'package:khedmaty_store/data/model/body/porduct_body.dart';
import 'package:khedmaty_store/injection.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:khedmaty_store/presentation/component/inputs/new/customTextFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/utils/showToast.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../component/new/custom_dropdown_button.dart';
import '../../../../../component/svg_icon.dart';
import '../../../../auth/register/widgets/status.dart';
import '../add_product_view_model.dart';
import '../widget/title_item.dart';

class PageOneAddProduct extends StatefulWidget {
  const PageOneAddProduct(
      {Key? key,
      this.oneProduct,
      required this.isEdite,
      required this.controller})
      : super(key: key);
  final OneProduct? oneProduct;
  final bool isEdite;
  final PageController controller;

  @override
  State<PageOneAddProduct> createState() => _AddProductsState();
}

class _AddProductsState extends State<PageOneAddProduct> {
  final _formKey = GlobalKey<FormState>();
  ProductsBody productsBody = getIt();
  AddProductViewModel addProductViewModel = getIt();
  int _type = 0;
  PickedFile ?file;
  /// required
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  setData() {
    print("kkkkkk___${widget.oneProduct?.title}");
    if (widget.oneProduct != null && widget.isEdite == true) {
      addProductViewModel.init(widget.oneProduct);
      _nameController.text = widget.oneProduct?.title ?? "";
      _detailsController.text = widget.oneProduct?.description ?? "";
      _type=int.tryParse(widget.oneProduct?.type??'')??0;
      Provider.of<AddProductViewModel>(context, listen: false).
      initSelectedDepartments(widget.oneProduct?.department?.id,
          widget.oneProduct?.department?.title);
      print('tttttttttttt1${widget.oneProduct?.department?.title}');
    }else{
      addProductViewModel.images=[];
      _nameController.text='';
      _detailsController.text='';
      Provider.of<AddProductViewModel>(context, listen: false).selectedDepartments=null;
    }
  }
  void _removeImage(context, int productId, int index) async {
    await Provider.of<AddProductViewModel>(context, listen: false)
        .removeItemAndImage(context, productId, 'product_images')
        .then((value) => value.response == null
            ? null
            : addProductViewModel.images.removeAt(index));
  }

  Future<void> _loadData(BuildContext context) async {
    await Provider.of<AddProductViewModel>(context, listen: false)
        .getDepartments(context);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductViewModel>(
        builder: (context, data, _) => RefreshIndicator(
            onRefresh: () async {
              _loadData(context);
            },
            child: ScreenStateLayout(
                isLoading: data.departmentModel == null,
                builder: (context) => ListAnimator(
                      children: [
                        Status(width: MediaQuery.of(context).size.width / 2),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 24.h, left: 16.w, right: 16.w, bottom: 24.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleItem(
                                  image: Assets.section, title: 'Section'.tr()),
                              SizedBox(height: 8.h),
                              Container(
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: AppColors.textFieldColor,
                                      border: Border.all(
                                          width: 1.w,
                                          color: AppColors.grayLite)),
                                  child: CustomDropdownButton(
                                    items: data.departments,
                                    value: data.selectedDepartments?.title ??
                                        "choose".tr(),
                                    onChanged: (DropdownItem? newValue) {
                                      setState(() {
                                        data.selectedDepartments = newValue;
                                      });
                                    },
                                  )),
                              SizedBox(height: 8.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleItem(
                                          image: Assets.imageproduct,
                                          title: LocaleKeys.imageproduct.tr()),
                                    ],
                                  ),
                                  Text(
                                    LocaleKeys.maximumPhotos.tr(),
                                    style: TextStyles()
                                        .getRegularStyle(fontSize: 14.sp)
                                        .customColor(AppColors.darkGray),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                           if(widget.isEdite)   localImage(),
                              if(widget.isEdite)   SizedBox(height: 8.h),

                              SizedBox(
                                height: 130.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            tackImage();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.5.w),
                                              height: 125.62.h,
                                              width: 167.5.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.w,
                                                      color:
                                                          AppColors.grayLite),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: AppColors.white),
                                              child: Center(
                                                  child: SVGIcon(
                                                Assets.pickImage,
                                                height: 60.5.h,
                                                width: 60.5.h,
                                              ))),
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              addProductViewModel.images.length,
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return localImageFile(
                                                addProductViewModel
                                                    .images[index],
                                                index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              _buildForm(),
                              CustomButton(
                                color: AppColors.main,
                                title: tr(LocaleKeys.kNext),
                                onTap: () {
                                  // widget.controller.animateToPage(1,
                                  //     duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                                  _onSubmit(context, addProductViewModel.images);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))));
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TitleItem(
                image: Assets.productname, title: LocaleKeys.productname.tr()),
            SizedBox(height: 8.h),
            CustomTextFormFiled(
              height: 60.h,
              borderColor: AppColors.grayLite,
              hintText: '',
              backGroundColor: AppColors.productScreenColor,
              controller: _nameController,
            ),
            SizedBox(height: 8.h),
            TitleItem(
                image: Assets.productDescription,
                title: LocaleKeys.productDescription.tr()),
            SizedBox(height: 8.h),
            CustomTextFieldArea(
              controller: _detailsController,
              background: AppColors.productScreenColor,
              maxLength: 6,
            ),
            SizedBox(height: 8.h),
            TitleItem(image: Assets.store, title: LocaleKeys.made.tr()),
            SizedBox(height: 8.h),
            Container(
              margin: EdgeInsets.only(top: 8.5.h, bottom: 17.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      borderRadius: 16.r,
                      height: 50.h,
                      width: 167.5.w,
                      onTap: () {
                        setState(() {
                          _type = 0;
                        });
                      },
                      title: LocaleKeys.original.tr(),
                      textColor: _type == 0 ? AppColors.white : AppColors.black,
                      color: _type == 0 ? AppColors.main : AppColors.grayLite),
                  CustomButton(
                      borderRadius: 16.r,
                      height: 50.h,
                      width: 167.5.w,
                      onTap: () {
                        setState(() {
                          _type = 1;
                        });
                      },
                      title: LocaleKeys.copycat.tr(),
                      textColor: _type == 1 ? AppColors.white : AppColors.black,
                      color: _type == 1 ? AppColors.main : AppColors.grayLite),
                ],
              ),
            ),
            /* TitleItem(
                image: Assets.preparationTime,
                title: LocaleKeys.preparationTime.tr()),
            Container(
              margin: EdgeInsets.only(top: 8.5.h, bottom: 17.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 205.w,
                    child: CustomTextFormFiled(
                      textInputType: TextInputType.number,
                      height: 60.h,
                      hintText: '0.0',
                      hintColor: AppColors.darkGray,
                      controller: _makeTimeController,
                      borderColor: AppColors.grayLite,
                      backGroundColor: AppColors.textFieldColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0.r),
                            ),
                          ),
                          builder: (context) {
                            return const MakeTime();
                          });
                    },
                    child: Container(
                      width: 130.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.w, color: AppColors.grayLite),
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.textFieldColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              Provider.of<ProductsViewModel>(context,
                                          listen: true)
                                      .makeTimeTitle ??
                                  widget.oneProduct?.makeTimeModel?.title ??
                                  LocaleKeys.choose.tr(),
                              style: TextStyles()
                                  .getRegularStyle(fontSize: 14.sp)
                                  .customColor(AppColors.black),
                            ),
                            Icon(Icons.expand_more_rounded,
                                color: AppColors.black, size: 24.r)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: SVGIcon(
                        Assets.preparationTime,
                        width: (20.w),
                        height: (20.h),
                        color: AppColors.main,
                      ),
                    ),
                    Text(
                      LocaleKeys.isProductShipped.tr(),
                      style: TextStyles()
                          .getTitleStyle(fontSize: 14.sp)
                          .customColor(AppColors.black),
                    )
                  ],
                ),
                 SwitchShipping(isSwitched: productsBody.isShipping==1?true:false,)
              ],
            ),*/
            SizedBox(
              height: 10.h,
            )
          ],
        ));
  }

  void _onSubmit(context, List<PickedFile> image) async {
    String name = _nameController.text;
    String description = _detailsController.text;
    var provider = Provider.of<AddProductViewModel>(context, listen: false);
    if (_formKey.currentState != null) {
      _formKey.currentState!.save();
      if (provider.selectedDepartments == null) {
        ToastUtils.showToast('selectSection'.tr());
      } else if (image.isEmpty && widget.isEdite == false) {
        ToastUtils.showToast('imageIsRequired'.tr());
      } else if (name.isEmpty) {
        ToastUtils.showToast('nameIsRequired'.tr());
      } else if (description.isEmpty) {
        ToastUtils.showToast('productDescriptionRequired'.tr());
      } else {
        productsBody.title = name;
        productsBody.description = description;
        if(widget.isEdite==true){
          if(file!=null){
            File mainImage = File(file!.path);
            productsBody.mainImage = mainImage;
          }
        }
        productsBody.departmentId = '${provider.selectedDepartments?.id ?? ' '}';
        productsBody.type = _type;
        widget.controller.animateToPage(1,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    }
  }

  Future<void> _getImage(ImageSource source,{bool? isMain}) async {
    final picker = ImagePicker();
    PickedFile? pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
      });
      if(isMain==true){
        file=pickedFile;
      }else{
        addProductViewModel.addImage(pickedFile);

      }
    }
  }
  tackImage({bool? isMain}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0.r),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text("takePicture".tr()),
                onTap: () {
                  if(widget.isEdite){
                    if (addProductViewModel.images.length < 2) {
                      _getImage(ImageSource.camera,isMain: isMain);
                    } else {
                      ToastUtils.showToast('maximumPhotos'.tr());
                    }
                  }else{
                    if (addProductViewModel.images.length < 3) {
                      _getImage(ImageSource.camera,isMain: isMain);
                    } else {
                      ToastUtils.showToast('maximumPhotos'.tr());
                    }
                  }

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text('chooseFromGallery'.tr()),
                onTap: () {
                  if(widget.isEdite){
                    if (addProductViewModel.images.length < 2) {
                      _getImage(ImageSource.gallery,isMain: isMain);
                    } else {
                      ToastUtils.showToast('maximumPhotos'.tr());
                    }
                  }else{
                    if (addProductViewModel.images.length < 3) {
                      _getImage(ImageSource.gallery,isMain: isMain);
                    } else {
                      ToastUtils.showToast('maximumPhotos'.tr());
                    }
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Widget localImageFile(PickedFile file, int index) {
    print("Pathhhhhh=>${file.path}");
    return SizedBox(
      height: 125.62.h,
      width: 167.5.w,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.5.w),
            height: 125.62.h,
            width: 167.5.w,
            decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: AppColors.grayLite),
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.textFieldColor),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: file.path.startsWith('http')
                  ? CommonNetworkImage(imageUrl: file.path)
                  : Image.file(
                      File(file.path),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
                onTap: () => setState(() {
                      if (widget.isEdite) {
                        file.path.startsWith('http')
                            ? _removeImage(
                                context,
                                widget.oneProduct?.images?[index].id ?? -1,
                                index)
                            : addProductViewModel.images.removeAt(index);
                      } else {
                        addProductViewModel.images.removeAt(index);
                      }
                    }),
                child: const SVGIcon(Assets.cancleOrder)),
          ),
        ],
      ),
    );
  }
  Widget localImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: (){

          tackImage(isMain: true);
        },
        child: Container(
            height: 125.62.h,
            width: 167.5.w,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(
                    8.r),
                color: AppColors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Center(
                  child:file==null? CommonNetworkImage(imageUrl: widget.oneProduct?.mainImage):Image.file(
                    File(file!.path),
                    fit: BoxFit.cover,
                  )),
            )),
      ),
    );
  }
}
