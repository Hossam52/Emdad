import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/product_card_build_item.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:flutter/material.dart';

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
