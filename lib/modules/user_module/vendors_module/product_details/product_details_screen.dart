import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/modules/vendor_module/screens/vender_add_product_view/vendor_edit_product_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/responsive/responsive_widget.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'product_custom_tile.dart';
import 'size_build_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    Key? key,
    required this.isVendor,
    required this.product,
  }) : super(key: key);
  final ProductModel? product;
  final bool isVendor;

  final PageController pageController = PageController();

  final List images = [
    'https://images.unsplash.com/photo-1613454320437-0c228c8b1723?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=eiliv-sonas-aceron-AQ_BdsvLgqA-unsplash.jpg&w=640',
    'https://unsplash.com/photos/utTJUcvNXXo/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8NXx8YmVlZnx8MHx8fHwxNjM4Njk0NDMx&force=true&w=640',
    'https://unsplash.com/photos/ak2UGvCPDk8/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8MTJ8fGJlZWZ8fDB8fHx8MTYzODY5NDQzMQ&force=true&w=640',
  ];

  @override
  Widget build(BuildContext context) {
    return responsiveWidget(
      responsive: (_, deviceInfo) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isVendor ? null : const _AddToPriceOffer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: _ProductImages(
                    pageController: pageController, product: product),
              ),
              pinned: true,
              expandedHeight: 250.h,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundColor: AppColors.thirdColor,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(isVendor ? Icons.edit : Icons.favorite_border,
                          size: 20),
                      onPressed: () {
                        if (isVendor) {
                          navigateTo(context, const VendorEditProductScreen());
                        }
                      },
                    ),
                  ),
                ),
                const ChangeLangWidget(
                  color: Colors.white,
                ),
              ],
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(product!.name, style: headersTextStyle()),
                    const SizedBox(height: 5),
                    Text(product!.productType, // 'الرحمه للمواد الغذائية',
                        style: thirdTextStyle()
                            .copyWith(color: AppColors.thirdColor)),
                    const SizedBox(height: 20),
                    ProductCustomTile(
                      title: 'تفاصيل المنتج',
                      children: [
                        Text(
                          product!.description,
                          style: thirdTextStyle()
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ProductCustomTile(
                      title: 'وحدات القياس',
                      children: [
                        const SizeBuildItem(
                          title: 'وحدة القياس',
                          value: 'الحد الادني',
                          price: 'سعر الوحدة',
                        ),
                        ...product!.units
                            .map(
                              (unit) => SizeBuildItem(
                                  title: unit.productUnit,
                                  value: unit.minimumAmountPerOrder.toString(),
                                  price: product!.isPriceShown
                                      ? unit.pricePerUnit.toString()
                                      : 'السعر مخفي'),
                            )
                            .toList()
                      ],
                    ),
                    const SizedBox(height: 210),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImages extends StatelessWidget {
  const _ProductImages({
    Key? key,
    required this.pageController,
    required this.product,
  }) : super(key: key);

  final PageController pageController;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: product!.images.length,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemBuilder: (context, index) => DefaultCachedNetworkImage(
            imageUrl: product!.images[index],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: SmoothPageIndicator(
            controller: pageController,
            count: product!.images.length,
            effect: const ScrollingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: AppColors.thirdColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddToPriceOffer extends StatefulWidget {
  const _AddToPriceOffer({Key? key}) : super(key: key);

  @override
  State<_AddToPriceOffer> createState() => _AddToPriceOfferState();
}

class _AddToPriceOfferState extends State<_AddToPriceOffer> {
  final TextEditingController quantityController =
      TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          enableDrag: true,
          builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('الكمية'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.thirdColor,
                              foregroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Container(
                              width: 72.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: CustomTextFormField(
                                controller: quantityController,
                                type: TextInputType.number,
                                hint: '',
                                validation: (value) {},
                                // hasBorder: false,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            CircleAvatar(
                              backgroundColor: AppColors.thirdColor,
                              foregroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text('الوحدة'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 140.w,
                              height: 40.h,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<Object>(
                                onChanged: (val) {},
                                items: const [
                                  DropdownMenuItem(child: Text('KG')),
                                ],
                                underline: Container(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('ملاحظاتك'),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                    ),
                    child: const TextField(
                      maxLines: 6,
                      minLines: 3,
                      decoration: InputDecoration(
                        hintText: 'اكتب ملاحظاتك',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      label: const Text('إضافة إلى طلب عرض السعر'),
      icon: const Icon(Icons.add_shopping_cart),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.secondaryColor,
      extendedIconLabelSpacing: 20,
    );
  }
}
