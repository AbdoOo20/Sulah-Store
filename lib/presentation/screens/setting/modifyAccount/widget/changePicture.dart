
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../injection.dart';
import '../../../../component/svg_icon.dart';
import '../modify_account_view_model.dart';

class ChangePicture extends StatefulWidget {
  const ChangePicture({Key? key}) : super(key: key);



  @override
  _ChangePictureState createState() => _ChangePictureState();
}

class _ChangePictureState extends State<ChangePicture> {
  RegisterBody registerBody=getIt();
  File? _image;
  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
      _image!=null ?registerBody.image=_image:null;
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<ModifyAccountViewModel>(context, listen: false).saveUserData;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: InkWell(
            onTap: (){showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  )),
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
            );},
            child: Container(height: 124.h,width: 124.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),),
              child:_image ==null?CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:  provider.getUserImage(),
                errorWidget: (context, url, error) =>
                    SVGIcon(
                      Assets.logo,
                      height: 48.h,
                      width: 48.w,
                    ),
              ):Image.file(_image!,fit: BoxFit.fill)),
          ),
        ),
        Positioned(
            bottom: 6.h,
            right: 10.w,
            child:
            const SVGIcon(Assets.add,))
      ],
    );
  }
}
