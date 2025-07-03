
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../component/appbars/custom_app_bar.dart';


class PayWebViewScreen extends StatefulWidget {
  const PayWebViewScreen({Key? key, required this.id, required this.link}) : super(key: key);
final int id;
final String link;
  @override
  State<PayWebViewScreen> createState() => _PayWebViewScreenState();
}

class _PayWebViewScreenState extends State<PayWebViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: Colors.white,
        title: LocaleKeys.completePaymentInformation.tr(),
      ),
      body: WebView(
        initialUrl: "${widget.link}${widget.id}",
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {

        },
        onPageFinished: (String url) {

        },
        onWebViewCreated: (WebViewController webViewController) {

        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text('Current URL: $_currentUrl'),
      //   ),
      // ),
    );
  }
}