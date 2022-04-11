import 'package:emdad/modules/auth_module/screens/update_profile/update_profile_widgets/background_stack.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تغيير الرقم السري',
          style: thirdTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BackgroundStack(
        child: Text('Hello'),
      ),
    );
  }
}
