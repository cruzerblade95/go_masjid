import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_masjid/app/utils/styles/app_colors.dart';
import 'package:go_masjid/app/utils/styles/app_size.dart';
import '../../../app/utils/extensions/string_extensions.dart';

class AppSelectField extends StatelessWidget {
  final String? label;
  final dynamic value;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? hint;
  final VoidCallback? onTap;
  final bool readOnly;
  final ValueChanged<dynamic>? onSubmitted;
  final String? Function(dynamic)? validatorFunction;
  final ValueChanged<dynamic>? onSaveFunction;
  final ValueChanged<dynamic>? onChange;
  final FocusNode? focusNode;
  final String? errorText;
  final TextAlign? textAlign;
  final bool? obsecureText;
  final Color borderColor;
  final double? borderWidth;
  final List<TextInputFormatter>? inputFormatter;
  final List<DropdownMenuItem<dynamic>>? items;

  AppSelectField({
    this.value,
    this.items,
    this.label,
    this.validatorFunction,
    this.onSaveFunction,
    this.onChange,
    this.focusNode,
    this.onSubmitted,
    this.width = 300,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
    this.hint = "",
    this.onTap,
    this.readOnly = false,
    this.obsecureText,
    this.textAlign = TextAlign.center,
    this.errorText,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.inputFormatter,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: TextStyle(
            color: AppColors.labelTextColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'Muli',
          ),
        ),
        SizedBox(height: AppSize.spaceX8),
        DropdownButtonFormField(
          hint: Text(
            hint ?? '',
            style: TextStyle(
              fontFamily: 'Muli',
              fontSize: 14.0,
            ),
          ),
          isExpanded: true,
          value: value,
          items: items,
          onTap: () => FocusScope.of(context).unfocus(),
          onChanged: onChange,
          onSaved: onSaveFunction,
          validator: validatorFunction,
          decoration: InputDecoration(
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 16.0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

DropdownMenuItem appDropDownMenuItem(String itemValue, dynamic value) {
  return DropdownMenuItem(
    child: Text(
      itemValue.toLowerCase().capitalizeFirstofEach,
      style: TextStyle(
        fontFamily: 'Muli',
        color: AppColors.darkTextColor,
        fontSize: 14.0,
      ),
    ),
    value: value,
  );
}
