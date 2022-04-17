import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'vendor_build_item.dart';

class VendorsListScreen extends StatelessWidget {
  VendorsListScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [ChangeLangWidget()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DefaultSearchField(
                searchController: searchController,
                hasFilter: true,
              ),
            ),
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => VendorBuildItem(
                onTap: () {
                  navigateTo(context,
                      const VendorViewScreen(title: 'الرحمه للمواد الغذائية'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
