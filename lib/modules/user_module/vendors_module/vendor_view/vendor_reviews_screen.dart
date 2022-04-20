import 'package:emdad/modules/user_module/home_module/vendor_profile_cubit/vendor_profile_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/review_build_item.dart';
import 'package:flutter/material.dart';

class VendorReviewsScreen extends StatelessWidget {
  const VendorReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التعليقات'),
      ),
      body: VendorProfileBlocBuilder(
        builder: (context, state) {
          final ratings = VendorProfileCubit.instance(context).getRatings;
          return ListView.separated(
            itemCount: ratings.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) =>
                ReviewBuildItem(hasMargin: false, rateModel: ratings[index]),
          );
        },
      ),
    );
  }
}
