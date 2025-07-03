import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/data/model/response/orders_model.dart';
import 'package:flutter/material.dart';

import 'custom_cared.dart';


class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    this.hasAcceptBut,  this.ordersModel,required this.type
  }) : super(key: key);
  final bool? hasAcceptBut;
  final OrdersModel? ordersModel;
  final String type;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: ordersModel?.data?.length ?? 0,//from API
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child:
            CustomCared(
              hasAcceptBut: hasAcceptBut, data: ordersModel?.data?[index], type: type,
            ),
          );
        });
  }
}