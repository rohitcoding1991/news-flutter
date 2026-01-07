import 'package:flutter/material.dart';
import 'package:news_flutter/core/utils/appUtils.dart';

import '../../coreComponents/TextView.dart';
import '../../coreComponents/appButton.dart';
import '../../coreComponents/imageView.dart';
import '../../resources/appColors.dart';
import '../../resources/appIcons.dart';
import '../../resources/fontSize.dart';
import '../../resources/textStyles.dart';

class FailureMessageDialog extends StatelessWidget {
  final Function()? onTap;
  final String message;
  final Function()? dismiss;
  const FailureMessageDialog({super.key, this.onTap, this.dismiss, required this.message});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.isPortraitMode ? mainView() : Expanded(child: SingleChildScrollView(
          child: mainView(),
        ))
      ],
    );
  }

  Widget  mainView(){
    return  Column(
      children: [
        const  ImageView(url: AppIcons.backButton,
          tintColor: AppColors.primaryColor,
          size: S.s40 * 2,),
        TextView(text: message, textStyle: TextStyles.regular16Black,
          textAlign: TextAlign.center,
          margin: const EdgeInsets.only(top: S.s10, bottom: S.s30),
        ),

        AppButton(
          padding: const EdgeInsets.symmetric(horizontal: S.s40,vertical: S.s16) ,
          onTap: onTap,
          label: 'OK',
          labelStyle: TextStyles.medium14White,
        )
      ],
    );

  }
}