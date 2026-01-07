import 'package:flutter/material.dart';
import 'package:news_flutter/core/utils/appUtils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../components/resources/appColors.dart';
class FullArticleView extends StatefulWidget {
  final String url;
  const FullArticleView({super.key, required this.url});

  @override
  State<FullArticleView> createState() => _FullArticleViewState();
}

class _FullArticleViewState extends State<FullArticleView> {

  late WebViewController controller;

  bool loadFlag = false;

  @override
  void initState() {
    super.initState();
    onCreate();
  }
  void onCreate(){
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(AppColors.transparent)
    ..setNavigationDelegate(
    NavigationDelegate(
    onProgress: (int progress) {

    },
    onPageStarted: (String url) {
      if(!loadFlag){
        loadFlag = true;
        context.load;
      }
    },
    onPageFinished: (String url) {
      if(loadFlag){
        loadFlag = false;
        context.stopLoader;
      }
    },
      onWebResourceError: (error){
        if(loadFlag){
          loadFlag = false;
          context.stopLoader;
        }
      }
    ),

    )
    ..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: AppColors.black
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      body:  SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
