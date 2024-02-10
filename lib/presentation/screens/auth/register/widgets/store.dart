import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/injection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/screens/auth/register/widgets/upperPart.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../component/component.dart';
import '../../../../component/svg_icon.dart';
import '../../../../component/inputs/new/customTextFormField.dart';
import 'status.dart';

class Store extends StatefulWidget {
  const Store({
    super.key,
    required this.controller,
  });
  final PageController controller;
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  RegisterBody registerBody=getIt();
  File? _logoImage;

  Future<void> _getImage(ImageSource source, bool isImageLogo) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (isImageLogo) {
        _logoImage = pickedFile != null ? File(pickedFile.path) : null;
      }
    });
  }
  /// on next step register
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _storeController = TextEditingController();
 void _onSubmit(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String storeName = _storeController.text;
        if (_logoImage == null) {
          ToastUtils.showToast('productImage'.tr());
        }else if (storeName.isEmpty) {
          ToastUtils.showToast('storeMustBeEntered'.tr());
        } else {
          registerBody.image=_logoImage;
          registerBody.title=storeName;
          widget.controller.animateToPage(1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Status(
          width: MediaQuery.of(context).size.width / 4,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: kFormPaddingAllLarge * 2.4.h,
                right: kScreenPaddingNormal.w,
                left: kScreenPaddingNormal.w),
            child: ListAnimator(
              children: [
                const UpperPart(
                  title: LocaleKeys.kStore,
                  body: LocaleKeys.kStoreBody,
                ),
                Align(alignment: Alignment.center,
                  child: Stack(
                    children: [
                      GestureDetector(onTap: (){ tackImage(true);},
                        child: Container(
                            height: 124.h,
                            width: 124.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.grayLite, width: 1.w),
                                borderRadius:
                                    BorderRadius.circular(24.r),
                                color: Colors.transparent),
                            child: _logoImage == null
                                ? SVGIcon(
                                    Assets.logo,
                                    height: 74.h,
                                    width: 85.39.w,
                              color: AppColors.grayLite,
                                  )
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(24.r),
                                    child: Image.file(
                                      _logoImage!,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                      ),
                      Positioned(right: 10,bottom: 10,
                          child: SVGIcon(
                                                  Assets.add,
                                                  height: 23.43.h,
                                                  width: 23.43.w,
                                                ))
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kScreenPaddingNormal),
                    child: _buildForm()),
              ],
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(
              right: kScreenPaddingNormal,
              left: kScreenPaddingNormal,
              bottom: kScreenPaddingLarge.h,
              top: kScreenPaddingNormal),
          child: CustomButton(
            width: double.infinity,
            onTap: () {
              _onSubmit(context);
            },
            title: LocaleKeys.kNext.tr(),
            color: AppColors.main,
            height: 56.h,
          ),
        ),
      ],
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: CustomTextFormFiled(
        height: 60,
        backGroundColor: AppColors.textFieldColor,
        borderColor: AppColors.grayLite,
        image: Assets.storeName,
        imageColor: AppColors.main,
        hintText: LocaleKeys.kStoreName.tr(),
        controller: _storeController,
        textInputType: TextInputType.text,
      ),
    );
  }

  tackImage(bool isImageLogo) {
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
                title:  Text("takePicture".tr()),
                onTap: () {
                  _getImage(ImageSource.camera, isImageLogo);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title:  Text('chooseFromGallery'.tr()),
                onTap: () {
                  _getImage(ImageSource.gallery, isImageLogo);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
