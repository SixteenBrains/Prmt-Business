import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdWebViewArgs {
  final String adUrl;

  AdWebViewArgs({required this.adUrl});
}

class AdWebView extends StatefulWidget {
  static const String routeName = '/adWebView';
  final String adUrl;
  const AdWebView({Key? key, required this.adUrl}) : super(key: key);

  static Route route({required AdWebViewArgs args}) {
    return MaterialPageRoute(
      builder: (_) => AdWebView(adUrl: args.adUrl),
    );
  }

  @override
  AdWebViewState createState() => AdWebViewState();
}

class AdWebViewState extends State<AdWebView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print('Url - ${widget.adUrl}');
    return SafeArea(child: WebView(initialUrl: widget.adUrl));
    // return const WebView(initialUrl: 'https://flutter.dev');
  }
}
