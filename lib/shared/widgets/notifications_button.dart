import 'package:emdad/modules/notifications/notifications_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('${Constants.defaultIconUrl}/notification.svg'),
      onPressed: () {
        navigateTo(context, const NotificationsScreen());
      },
    );
  }
}
