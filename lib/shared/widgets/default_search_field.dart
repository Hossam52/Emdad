import 'package:flutter/material.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';

class DefaultSearchField extends StatelessWidget {
  const DefaultSearchField(
      {Key? key, required this.searchController, this.hasFilter = false})
      : super(key: key);

  final TextEditingController searchController;
  final bool hasFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: CustomTextFormField(
              type: TextInputType.text,
              hint: 'بحث',
              validation: (value) {},
              prefix: const Icon(CupertinoIcons.search, color: Colors.grey),
              controller: searchController,
              hasBorder: false,
            ),
          ),
        ),
        if (hasFilter)
          TextButton.icon(
            onPressed: () {
              showAppFilter(
                context: context,
                onSearch: () {},
                onDelete: () {},
                filterItem: Column(),
              );
            },
            label: const Text('تصفية'),
            icon: const Icon(MyIcons.funnel),
            style: TextButton.styleFrom(
              primary: AppColors.primaryColor,
            ),
          ),
      ],
    );
  }
}
