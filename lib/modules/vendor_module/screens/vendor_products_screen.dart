import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/product_card_build_item.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:emdad/shared/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorProductsScreen extends StatelessWidget {
  VendorProductsScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultSearchField(searchController: searchController),
              ),
              GridView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 2,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => const ProductCardBuildItem(
                  name: 'لحم بقرى',
                  image:
                  'https://images.unsplash.com/photo-1613454320437-0c228c8b1723?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=eiliv-sonas-aceron-AQ_BdsvLgqA-unsplash.jpg&w=640',
                  hasCart: false,
                  isVendor: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
