import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/modules/user_module/offers_module/offers_cubit/offers_cubit.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/icons/my_icons_icons.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:flutter/material.dart';

class TitleWithFilterBuildItem extends StatelessWidget {
  const TitleWithFilterBuildItem(
      {Key? key,
      required this.title,
      required this.changeSortType,
      required this.hasSort})
      : super(key: key);

  final String title;
  final void Function(SortBy) changeSortType;
  final bool hasSort;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(title, style: thirdTextStyle()),
            const Spacer(),
            IconButton(
              onPressed: () {
                showAppFilter(
                  context: context,
                  onSearch: () {},
                  onDelete: () {},
                  filterItem: Column(
                    children: [
                      ListTile(
                        title: const Text('الموقع'),
                        trailing: DropdownButton<Object>(
                          onChanged: (val) {},
                          items: const [
                            DropdownMenuItem(
                              child: Text('الموقع'),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text('تمت المشاهدة'),
                        trailing: DropdownButton<Object>(
                            onChanged: (val) {}, items: const []),
                      ),
                      ListTile(
                        title: const Text("التاريخ"),
                        trailing: DropdownButton<Object>(
                            onChanged: (val) {}, items: const []),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(MyIcons.funnel),
            ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                PopupMenuButton(
                  icon: const Icon(Icons.sort),
                  tooltip: 'ترتيب',
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: Text('ترتيب حسب'),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      child: const Text(
                        'الكل',
                      ),
                      onTap: () {
                        changeSortType(SortBy.none);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        'الاسم',
                      ),
                      onTap: () {
                        changeSortType(SortBy.name);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        'التاريخ',
                      ),
                      onTap: () {
                        changeSortType(SortBy.date);
                      },
                    ),
                  ],
                ),
                if (!hasSort) _hasFilterDot()
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPopupMenuChild(String title,) {
  //   return Row(
  //     children: [Text(title)],
  //   );
  // }

  Widget _hasFilterDot() {
    return const CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      radius: 4,
    );
  }
}
