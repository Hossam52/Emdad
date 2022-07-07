import 'package:emdad/modules/auth_module/cubit/auth_cubit.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkipAuthButton extends StatelessWidget {
  const SkipAuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoginGuestUserLoadingState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return TextButton.icon(
          onPressed: () {
            AuthCubit.get(context).loginGuestUser(context);
          },
          icon: const Icon(Icons.navigate_before),
          label: Text(context.tr.skip),
        );
      },
    );
  }
}
