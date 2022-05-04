import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCheckWrapper extends StatelessWidget {
  const ProfileCheckWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final appCubit = AppCubit.get(context);
          if (appCubit.getUser != null) return child;
          if (state is GetUserProfileLoadingState) return const DefaultLoader();
          if (state is GetUserProfileErrorState) {
            return EmptyData(
              emptyText: state.error,
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.png',
                  width: 0.8.sw,
                ),
                Text(
                  'Cant get profile try again',
                  style: headersTextStyle(),
                ),
                state is GetUserProfileLoadingState
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          await appCubit.getUserProfile();
                        },
                        child: Text(
                          'Try again!',
                          style: headersTextStyle(),
                        ),
                      ),
                TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.errorColor)),
                    onPressed: () {
                      SharedMethods.signOutVendor(context);
                    },
                    child: const Text('Logout')),
              ],
            ),
          );
        },
      ),
    );
  }
}
