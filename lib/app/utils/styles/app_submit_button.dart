import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_size.dart';

class AppSubmitButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final String? btnTitle;
  final Widget? widget;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final double? textSize;

  AppSubmitButton({super.key,
    this.onTap,
    this.textColor = AppColors.whiteColor,
    this.backgroundColor = AppColors.primaryColor,
    this.width,
    this.height,
    this.btnTitle,
    this.widget,
    this.textAlign,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 54.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ??
                Text(
                  btnTitle ?? '',
                  textAlign: textAlign ?? TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: textSize ?? AppSize.fontLargeX2,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
