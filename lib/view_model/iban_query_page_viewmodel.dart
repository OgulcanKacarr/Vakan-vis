import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IbanQueryPageViewmodel extends ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Widget openWeb() {
    return WebView(
      initialUrl: 'https://iban.gen.tr/iban-cozumleme-ve-dogrulama',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

}
