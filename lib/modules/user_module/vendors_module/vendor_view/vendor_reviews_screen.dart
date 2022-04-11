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
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) => const ReviewBuildItem(hasMargin: false),
      ),
    );
  }
}
