import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../injection.dart';
import '../../../../component/animation/list_animator.dart';
import '../../../../component/svg_icon.dart';
import 'bottomPart.dart';
import 'status.dart';
import 'upperPart.dart';

class Documentation extends StatefulWidget {
   const Documentation({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  State<Documentation> createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation> {
  RegisterBody registerBody = getIt();

  bool isChecked = false;

  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  void _onSubmit(context) async {
    if (_image == null) {
      print('isclicked');
      ToastUtils.showToast('commercialRegistrationMustUploaded'.tr());
    }
    else {
      print('gffffffff${registerBody.iban}');
      registerBody.workingDocument = _image;
      widget.controller.animateToPage(
          3, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Status(width: (MediaQuery
            .of(context)
            .size
            .width / 4) * 3),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: kFormPaddingAllLarge * 2.4.h,
                right: kScreenPaddingNormal,
                left: kScreenPaddingNormal),
            child: ListAnimator(
              children: [
                const UpperPart(
                  title: LocaleKeys.kDocumentation,
                  body: LocaleKeys.kDocumentationBody,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: kScreenPaddingNormal),
                  child: Container(
                    height: 240.5.h,
                    width: 343.w,
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: AppColors.textFieldBorderColor)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.kCommercialRecord.tr(),
                              style: TextStyles()
                                  .getRegularStyle(fontSize: 14.sp)
                                  .customColor(AppColors.black),
                              softWrap: true,
                            ),
                            SVGIcon(
                              Assets.commercialRecord,
                              width: 24.w,
                              height: 24.h,
                              color: AppColors.main,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: InkWell(onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.r),

                                  )
                              ),
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: Text('takePicture'.tr()),
                                        onTap: () {
                                          _getImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: Text('chooseFromGallery'.tr()),
                                        onTap: () {
                                          _getImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                            child: Container(
                              height: 155.5.h,
                              width: 311.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  color: AppColors.white),
                              child: _image == null ?
                              const Center(child:
                              SVGIcon(Assets.imageCommercial)
                              ) : ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.file(
                                    _image!, fit: BoxFit.fill,)),
                            ),
                          ),
                        )
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
          previous: () =>
              widget.controller.animateToPage(
                  1, duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}