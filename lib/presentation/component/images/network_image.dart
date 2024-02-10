import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
class CommonNetworkImage extends StatelessWidget {

  final String? imageUrl;
  final BoxFit? fit;

  const CommonNetworkImage(
      {Key? key,
      this.fit= BoxFit.fill ,
      required this.imageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl ?? '',
      placeholder: (context, url) =>  Center(child: SizedBox(width:20.w,height:20.h,child:const CircularProgressIndicator(strokeWidth: 3,))),
      errorWidget: (context, url, error) =>  const Icon(Icons.error),
    );
  }
}
