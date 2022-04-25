import 'package:flutter/material.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';

class DefaultSearchField extends StatefulWidget {
  const DefaultSearchField(
      {Key? key,
      required this.searchController,
      this.onFilterTapped,
      this.onChanged})
      : super(key: key);

  final TextEditingController searchController;
  final VoidCallback? onFilterTapped;
  final void Function(String)? onChanged;

  @override
  State<DefaultSearchField> createState() => _DefaultSearchFieldState();
}

class _DefaultSearchFieldState extends State<DefaultSearchField> {
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
              controller: widget.searchController,
              hasBorder: false,
              onChange: widget.onChanged,
            ),
          ),
        ),
        if (widget.onFilterTapped != null)
          TextButton.icon(
            onPressed: widget.onFilterTapped,
            label: const Text('تصفية'),
            icon: const Icon(MyIcons.funnel),
            style: TextButton.styleFrom(
              primary: AppColors.primaryColor,
            ),
          ),
        // if (searchController.text.isNotEmpty) Text('Hello')
      ],
    );
  }
}
