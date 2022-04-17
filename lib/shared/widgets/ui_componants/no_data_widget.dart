import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({
    Key? key,
    this.text,
    required this.onPressed,
  }) : super(key: key);

  String? text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 45,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Text(
            text ?? 'No data',
            style: thirdTextStyle().copyWith(color: Colors.grey),
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
