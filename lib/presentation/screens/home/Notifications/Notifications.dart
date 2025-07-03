// import 'package:sulah_store/core/app_loader.dart';
// import 'package:sulah_store/core/extensions/num_extensions.dart';
// import 'package:sulah_store/presentation/component/component.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/res/text_styles.dart';
// import '../../../../core/resources/resources.dart';
// import '../../../../core/routing/route.dart';
// import '../orders/orderDetails/orderDetails.dart';
// import 'NotificationViewModel.dart';
//
// class Notifications extends StatefulWidget {
//   const Notifications({Key? key}) : super(key: key);
//
//   @override
//   State<Notifications> createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//   _loadData(context) =>
//       Provider.of<NotificationViewModel>(context, listen: false)
//           .getNotification(context);
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       appBar: CustomAppBar(
//         title: LocaleKeys.notification.tr(),
//         titleColor: AppColors.black,
//         color: Colors.transparent,
//       ),
//       body:
//           Consumer<NotificationViewModel>(builder: (context, builder, child) {
//         return RefreshIndicator(
//             onRefresh: () async => _loadData(context),
//             child: ScreenStateLayout(
//                 isLoading: builder.notificationModel == null,
//                 isEmpty: builder.notificationModel?.data?.isEmpty ?? false,
//                 onRetry: () => _loadData(context),
//                 builder: (context) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView.builder(
//                         itemCount: builder.notificationModel?.data?.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(
//                                 top: 16.h, right: 12.w, left: 12.w),
//                             child: InkWell(
//                               onTap: () {
//                                 if (builder.notificationModel?.data?[index]
//                                         .type ==
//                                     "order") {
//                                   push(OrderDetailsScreen(
//                                     id: builder.notificationModel
//                                             ?.data?[index].orderId ??
//                                         -1,
//                                     isFromOrders: false,
//                                   ));
//                                 } else if (builder.notificationModel
//                                         ?.data?[index].type ==
//                                     "driverOrder") {
//                                   push(const DriverRequests());
//                                 }
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     builder.notificationModel?.data?[index]
//                                             .body
//                                             .toString() ??
//                                         '',
//                                     style: TextStyles()
//                                         .getRegularStyle(fontSize: 14.sp)
//                                         .customColor(AppColors.darkGray),
//                                   ),
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         builder.notificationModel
//                                                 ?.data?[index].createdAt
//                                                 .toString() ??
//                                             '',
//                                         style: TextStyles()
//                                             .getRegularStyle(fontSize: 14.sp)
//                                             .customColor(AppColors.main),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 12.h),
//                                     decoration: const BoxDecoration(
//                                         border: Border(
//                                             top: BorderSide(
//                                                 color: AppColors.main20))),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     )));
//       },),
//     );
//   }
// }
