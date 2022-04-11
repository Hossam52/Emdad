import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'vendor_view_componants/product_card_build_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultSearchField(
                searchController: searchController,
                // hasFilter: false,
              ),
            ),
            GridView.builder(
              itemCount: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) => const ProductCardBuildItem(
                name: 'لحم بقرى',
                image:
                'https://images.unsplash.com/photo-1613454320437-0c228c8b1723?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=eiliv-sonas-aceron-AQ_BdsvLgqA-unsplash.jpg&w=640',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
