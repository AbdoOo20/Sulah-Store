// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../../../core/resources/app_colors.dart';
//
//
// class CustomPinCodeTextField extends StatelessWidget {
//   const CustomPinCodeTextField({super.key});
//   @override
//   Widget build(BuildContext context) {
//     //put on provider in logic
//     //late String otpPinCode;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 28),
//       child: PinCodeTextField(
//         appContext: context,
//         textGradient:  LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             AppColors.main,
//             AppColors.main,
//           ],
//         ),
//         //autoFocus: false,
//         keyboardType: TextInputType.number,
//         length: 6,
//         cursorColor: AppColors.grayTextField,
//         // obscureText: false,
//         animationType: AnimationType.scale,
//
//         pinTheme: PinTheme(
//           // shape: PinCodeFieldShape.underline,
//           // borderRadius: BorderRadius.circular(5),
//
//           // fieldHeight: 45,
//           // fieldWidth: 35,
//           // borderWidth: 0,
//           // activeColor: Colors.transparent,
//
//           inactiveColor: AppColors.grayTextField,
//           activeColor: AppColors.grayTextField,
//           selectedColor: AppColors.grayTextField,
//           //inactiveFillColor: MyColors.gray,
//           // activeFillColor: Colors.transparent,
//           //
//           // selectedFillColor: Colors.transparent,
//         ),
//         animationDuration: const Duration(milliseconds: 300),
//         //backgroundColor: Colors.blue.shade50,
//         //enableActiveFill: true,
//         onCompleted: (submitedCode) {
//           // otpPinCode = submitedCode;
//           print("Completed");
//         },
//         onChanged: (value) {
//           print(value);
//         },
//       ),
//     );
//   }
// }
