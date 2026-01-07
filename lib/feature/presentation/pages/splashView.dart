import 'package:flutter/material.dart';
import 'package:news_flutter/core/utils/appUtils.dart';


import '../../../components/coreComponents/textView.dart';
import '../../../components/resources/textStyles.dart';
import 'homeTabs.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      context.replaceNavigator(const HomeTabs());
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextView(text: 'News',textStyle: TextStyles.semiBold20Black,),
      ),
    );
  }
}
