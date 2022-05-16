import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key, this.emptyText, this.displayImage = true})
      : super(key: key);
  final String? emptyText;
  final bool displayImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (displayImage) SvgPicture.asset('assets/images/no_data.svg'),
        Center(
          child: Text(emptyText ?? 'No data available'),
        ),
      ],
    );
  }
}
