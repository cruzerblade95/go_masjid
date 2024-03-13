import 'package:flutter/material.dart';
import 'package:go_masjid/app/utils/styles/app_colors.dart';
import '../../../app/utils/extensions/string_extensions.dart';

class AppRadioButton extends StatelessWidget {
  final String? label;
  final String? title;
  final String? value;
  final String? groupValue;
  final String? errorText;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onTap;

  AppRadioButton({
    this.label,
    required this.title,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.errorText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            this.label ?? '',
            style: TextStyle(
                color: AppColors.labelTextColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Muli"),
          ),
        InkWell(
          onTap: onTap,
          child: RadioListTile<String?>(
            title: Text(
              title ?? '',
              style: TextStyle(
                color: AppColors.labelTextColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: this.value,
            groupValue: this.groupValue,
            onChanged: this.onChanged,
          ),
        ),
        if (!errorText!.isNullOrWhiteSpace)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}

class AppRadioButtonListTile extends StatelessWidget {
  final String? label;
  final dynamic groupValue;
  final Function onChange;
  final List<RadioListItem1> radioList;
  final bool enable;
  final String? errorText;

  const AppRadioButtonListTile({
    Key? key,
    this.label,
    required this.onChange,
    required this.radioList,
    required this.groupValue,
    this.enable = true,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Text(
            label ?? '',
            style: TextStyle(
              fontFamily: 'Muli',
              color: AppColors.labelTextColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        // ...List.generate(
          // radioList.length,
              // (index) {
            // return RadioListTile<dynamic>(
            //   title: Text(
            //     radioList[index].title,
            //     style: TextStyle(
            //         color: AppColors.labelTextColor,
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.w500,
            //         fontFamily: 'Muli'),
            //   ),
            //   value: radioList[index].value,
            //   groupValue: groupValue,
            //   onChanged: enable ? onChange : null,
            // );
          // },
        // ),
        if (!errorText!.isNullOrWhiteSpace)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontFamily: 'Muli',
              ),
            ),
          ),
      ],
    );
  }
}

class RadioListItem1 {
  dynamic value;
  String title;

  RadioListItem1(this.value, this.title);
}
