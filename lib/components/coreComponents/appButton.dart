import 'package:flutter/material.dart';


import '../resources/appColors.dart';
import '../resources/fontSize.dart';
import '../resources/textStyles.dart';
import 'TextView.dart';
import 'tapGesture.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Function()? onTap;
  final double? radius;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool fillWidth;
  final Widget? child;
  final Key? tapKey;
  const AppButton({super.key, this.label, this.onTap, this.radius, this.labelStyle, this.buttonColor, this.buttonBorderColor, this.padding, this.margin, this.fillWidth = true, this.child, this.tapKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: S.s20, vertical: S.s20),
            width: fillWidth ? double.maxFinite : null,
            decoration: BoxDecoration(
                color: buttonColor ?? AppColors.primaryColor,
                borderRadius: BorderRadius.circular(radius ??S.s10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(text: label ?? '',
                  textStyle:  labelStyle ?? TextStyles.medium14White,
                ),
                child ?? const SizedBox()
              ],
            ),
          ),
          Positioned.fill(child: TapGesture(onTap: onTap,tapKey: tapKey,))
        ],
      ),
    );
  }
}