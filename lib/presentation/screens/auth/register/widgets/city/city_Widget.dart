import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../data/model/body/RegisterBody.dart';
import '../../../../../component/animation/list_animator_data.dart';
import '../../../../../component/screen_state_layout.dart';
import '../../../../../component/svg_icon.dart';
import '../../RegisterViewModel.dart';
import 'cityViewModel.dart';
_getData(BuildContext context, bool reload){
  //Provider.of<CityWidgetViewModel>(context, listen: false).getCityList(context);

}
class CityWidget extends StatefulWidget {
  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  @override
  void initState() {
    super.initState();
    _getData(context, false);
  }
  var _cityIdSelected = -1;
  var _cityNameSelected = '';

  @override
  Widget build(BuildContext context) {
  //  var responseModel = context.watch<CityWidgetViewModel>().cityModel;

    return Column(
      children: [
        SizedBox(
          height: 60.h,
          child: Padding(
            padding:  const EdgeInsets.all(kScreenPaddingNormal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr(LocaleKeys.kCity),
                  style: TextStyles().getTitleStyle().customColor(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: ()=>Navigator.pop(context),
                  child:const SVGIcon(Assets.svgExitIcon),
                ),
              ],
            ),
          ),
        ),
        // Expanded(
        //   child: ScreenStateLayout(
        //     isLoading: responseModel == null,
        //     error: responseModel?.message,
        //     isEmpty: (responseModel?.data?.length ?? 0) == 0,
        //     onRetry: () => _getData(context, true),
        //     builder: (context) => ListAnimatorData(
        //       itemCount: responseModel?.data?.length,
        //       itemBuilder: (context, index) {
        //         if (responseModel?.data?[index] != null) {
        //           return Padding(
        //             padding: EdgeInsets.symmetric(vertical: kFormPaddingAllSmall.h),
        //             child: Container(
        //               height: 50,
        //               color: Colors.transparent,
        //               child: RadioListTile(
        //                 title: Text(responseModel?.data?[index].title ?? "",
        //                   style: TextStyles().getTitleStyle().customColor(AppColors.black),
        //                 ),
        //                 value: responseModel?.data?[index],
        //                 groupValue: _cityIdSelected,
        //                 onChanged: (value) {
        //                   setState(() {
        //                     _cityIdSelected = responseModel?.data?[index].id ?? 0;
        //                     _cityNameSelected = responseModel?.data?[index].title ?? "";
        //
        //                     /// set new data in provider
        //                     var registerData = Provider.of<RegisterViewModel>(context,listen: false);
        //                     RegisterBody registerBody = RegisterBody();
        //                     registerBody.logoImage = registerData.registerBody?.logoImage;
        //                     registerBody.backgroundImage = registerData.registerBody?.backgroundImage;
        //                     registerBody.commercialRegisterImage =  registerData.registerBody?.commercialRegisterImage;
        //                     registerBody.name = registerData.registerBody?.name;
        //                     registerBody.email = registerData.registerBody?.email;
        //                     registerBody.password = registerData.registerBody?.password;
        //                     registerBody.cityId = _cityIdSelected.toString();
        //                     registerBody.cityNameSelected = _cityNameSelected;
        //                     registerBody.neighborId = registerData.registerBody?.neighborId;
        //                     registerBody.neighborNameSelected = registerData.registerBody?.neighborNameSelected;
        //                     registerBody.googlePlaceId = registerData.registerBody?.googlePlaceId;
        //                     registerBody.phoneCode = registerData.registerBody?.phoneCode;
        //                     registerBody.phone = registerData.registerBody?.phone;
        //                     registerBody.address = registerData.registerBody?.address;
        //                     registerBody.longitude = registerData.registerBody?.longitude;
        //                     registerBody.latitude = registerData.registerBody?.latitude;
        //                     registerBody.taxNumber = registerData.registerBody?.taxNumber;
        //                     registerBody.departmentId =  registerData.registerBody?.departmentId;
        //                     registerBody.departmentNameSelected =  registerData.registerBody?.departmentNameSelected;
        //                     Provider.of<RegisterViewModel>(context,listen: false).registerData = registerBody;
        //                     NavigationService.goBack();
        //                   });
        //                 },
        //               ),
        //             ),
        //           );
        //         } else {
        //           return const SizedBox();
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ],
    );

  }
}

