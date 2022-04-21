import 'package:emdad/modules/transporter_module/screens/transporter_offers_view/transporter_offer_details_screen.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_componants/vendor_info_build_item.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/default_home_title_build_item.dart';
import 'package:emdad/shared/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cart_build_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('قائمة الطلبات', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VendorInfoBuildItem(
              name: 'Test name',
              isCart: true,
              tailing: CustomButton(
                onPressed: () {},
                text: 'إضافه منتج',
              ),
            ),
            const SizedBox(height: 16),
            DefaultHomeTitleBuildItem(
              title: 'طلب خدمة إضافية',
              onPressed: () {},
              hasButton: false,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultFormField(
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      controller: controller,
                      hintText:
                          'يمكنك طلب خدمه إضافية غير موجوده داخل منتجات المورد',
                      haveBackground: true,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              value: true,
              onChanged: (value) {},
              title: const Text('هل تريد خدمه النقل ؟'),
              secondary: const Icon(Icons.directions_car, color: Colors.black),
              activeColor: AppColors.successColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            const ListTile(
              title: Text('السله'),
              leading: Icon(Icons.shopping_cart, color: Colors.black),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            ListView.separated(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              itemBuilder: (context, index) => const CartBuildItem(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (_) =>
                              SuccessSendingOffer(onPressed: () {}));
                      Navigator.pop(context);
                    },
                    text: 'تأكيد طلب عرض سعر',
                    backgroundColor: AppColors.primaryColor,
                  )),
                  const SizedBox(width: 19),
                  Expanded(
                      child: CustomButton(
                    onPressed: () => Navigator.pop(context),
                    text: 'إلغاء',
                    backgroundColor: AppColors.errorColor,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
