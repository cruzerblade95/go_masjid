import 'package:flutter/material.dart';

class FastAppIcons extends StatelessWidget {
  final String image;
  final VoidCallback  onPressed;
  final String label;


  const FastAppIcons({
    Key? key,
    required this.label,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: IconButton(
            icon: Image.asset(image),
            onPressed: onPressed,
          ),
        ),
        SizedBox(
          height: 0.002,
        ),
        Container(
          width: 61,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Muli',
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
