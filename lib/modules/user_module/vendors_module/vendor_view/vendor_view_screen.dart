import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_reviews_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_screen.dart';
import 'vendor_view_componants/cart_bar_build_item.dart';
import 'vendor_view_componants/product_card_build_item.dart';
import 'vendor_view_componants/review_build_item.dart';
import 'vendor_view_componants/vendor_buttons_build.dart';
import 'vendor_view_componants/vendor_info_build_item.dart';

class VendorViewScreen extends StatelessWidget {
  const VendorViewScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const VendorInfoBuildItem(
                  isCart: false,
                  tailing: VendorButtonsBuild(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DefaultHomeTitleBuildItem(
                    title: 'التعليقات',
                    hasButton: true,
                    onPressed: () {
                      navigateTo(context, const VendorReviewsScreen());
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Row(
                    children:
                        List.generate(4, (index) => const ReviewBuildItem()),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('اللحوم'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.black),
                  onTap: () {
                    navigateTo(context, const CategoryScreen(title: 'اللحوم'));
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: List.generate(4,
                      (index) => const ProductCardBuildItem(
                        name: 'لحم بقرى',
                        hasCart: false,
                        isList: true,
                        image:
                            'https://images.unsplash.com/photo-1613454320437-0c228c8b1723?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=eiliv-sonas-aceron-AQ_BdsvLgqA-unsplash.jpg&w=640',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('خضروات و فاكة'),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.black),
                  onTap: () {
                    navigateTo(
                        context, const CategoryScreen(title: 'خضروات و فاكة'));
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: List.generate(4,
                          (index) => const ProductCardBuildItem(
                            name: 'برتقال',
                            hasCart: false,
                            isList: true,
                            image:
                            'https://unsplash.com/photos/A4BBdJQu2co/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MTl8fG9yYW5nZXx8MHx8fHwxNjM4NjMxMjUx&force=true&w=640',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
          const CartBarBuildItem(),
        ],
      ),
    );
  }
}
