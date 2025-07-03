// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:sulah_store/core/extensions/num_extensions.dart';
// import 'package:sulah_store/core/res/text_styles.dart';
// import 'package:sulah_store/presentation/component/spaces.dart';
// import 'package:sulah_store/presentation/component/svg_icon.dart';
// import 'package:sulah_store/presentation/screens/setting/setting_view_model.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../core/resources/resources.dart';
//
//
// class CardPop extends StatefulWidget {
//   const CardPop({Key? key}) : super(key: key);
//
//   @override
//   _CardPopState createState() => _CardPopState();
// }
//
// class _CardPopState extends State<CardPop> {
//   _getData(BuildContext context){
//     Provider.of<SettingViewModel>(context, listen: false).getSettingApi(context);
//   }
//   @override
//   void initState() {
//     super.initState();
//     // Future.delayed(Duration(seconds: 1), () {
//     //   Navigator.of(context).pop(true);
//     // });
//     _getData(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.zero,
//       contentPadding: EdgeInsets.zero,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       content: Builder(
//         builder: (context) {
//           // var height = MediaQuery.of(context).size.height;
//           var width = MediaQuery.of(context).size.width;
//
//           return Container(
//             width: width - 32,
//             padding: EdgeInsets.only(
//                 top: 16.h, bottom: 20.h, right: 16.w, left: 12.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.only(top: 4.h),
//                   child: Icon(
//                     Icons.error_outline,
//                     color: AppColors.main,
//                     size: 20.r,
//                   ),
//                 ),
//                 SizedBox(width:8.w),
//                 Padding(
//                   padding:  EdgeInsets.only(top: 4.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             LocaleKeys.imageproduct.tr(),
//                             style: const TextStyle()
//                                 .titleStyle(fontSize: FontSize.s12.sp)
//                                 .customColor(AppColors.main),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height:12.w),
//                       Column(
//                      mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             Provider.of<SettingViewModel>(context, listen: false).settingModel?.data?.imagesText??'',
//                             style: const TextStyle()
//                                 .bodyStyle(fontSize: FontSize.s14.sp)
//                                 .customColor(AppColors.black),
//                                 softWrap:true ,
//                                  maxLines: 4,
//                           ),
//                         ],
//                       ),     SizedBox(height:12.w),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 InkWell(
//                   onTap: (){
//                     Navigator.of(context).pop(true);
//                   },
//                   child: SVGIcon(
//                     Assets.xIcon,
//                     width: 24.w,
//                     height: 24.h,
//                     ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
// }
//
// void enmation(BuildContext context)async{
//   showGeneralDialog(
//
//     barrierLabel: "Label",
//     barrierDismissible: false,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: Duration(milliseconds: 500),
//     context: context,
//     pageBuilder: (context, anim1, anim2) {
//       return
//         const CardPop();
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return SlideTransition(
//           position: Tween(
//               begin: const Offset(0, -1), end: const Offset(0, -0.33))
//               .animate(anim1),
//           child: child);
//     },
//   );
// }void
// pop(BuildContext context)async{
//   showGeneralDialog(
//     barrierLabel: "Label",
//     barrierDismissible: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: Duration(milliseconds: 500),
//     context: context,
//     pageBuilder: (context, anim1, anim2) {
//       return
//         const CardPop();
//     },
//     transitionBuilder: (context, anim1, anim2, child) {
//       return SlideTransition(
//           position: Tween(
//               begin: const Offset(0, -1), end: const Offset(0, -0.33))
//               .animate(anim1),
//           child: child);
//     },
//   );
// }