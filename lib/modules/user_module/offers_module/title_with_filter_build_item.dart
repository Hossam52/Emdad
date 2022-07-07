import 'package:emdad/common_cubits/filter_supply_requests_cubit/filter_supply_requests_cubit.dart';
import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:flutter/material.dart';

class TitleWithFilterBuildItem extends StatelessWidget {
  const TitleWithFilterBuildItem(
      {Key? key,
      required this.title,
      required this.changeSortType,
      required this.hasSort,
      this.filterCubit})
      : super(key: key);

  final String title;
  final void Function(SortBy) changeSortType;
  final bool hasSort;
  final FilterSuuplyRequestsCubit? filterCubit;
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
            // IconButton(
            //   onPressed: () {
            //     showAppFilter(
            //       context: context,
            //       onSearch: () {},
            //       onDelete: () {},
            //       filterItem: Column(
            //         children: [
            //           ListTile(
            //             title: const Text('الموقع'),
            //             trailing: DropdownButton<Object>(
            //               onChanged: (val) {},
            //               items: const [
            //                 DropdownMenuItem(
            //                   child: Text('الموقع'),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           ListTile(
            //             title: const Text('تمت المشاهدة'),
            //             trailing: DropdownButton<Object>(
            //                 onChanged: (val) {}, items: const []),
            //           ),
            //           ListTile(
            //             title: const Text("التاريخ"),
            //             trailing: DropdownButton<Object>(
            //                 onChanged: (val) {}, items: const []),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            //   icon: const Icon(MyIcons.funnel),
            // ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                PopupMenuButton<SortBy>(
                  icon: const Icon(Icons.sort),
                  tooltip: context.tr.sort,
                  onSelected: (sortBy) {
                    filterCubit?.changeSortType(sortBy);
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Text(context.tr.sort_by),
                      enabled: false,
                    ),
                    PopupMenuItem(
                      value: SortBy.none,
                      child: _buildPopupMenuChild(
                          context.tr.remove_sort, filterCubit!.notSort),
                      onTap: () {
                        changeSortType(SortBy.none);
                      },
                    ),
                    PopupMenuItem(
                      value: SortBy.name,
                      child: _buildPopupMenuChild(
                          context.tr.name, filterCubit!.sortByName),
                      onTap: () {
                        changeSortType(SortBy.name);
                      },
                    ),
                    PopupMenuItem(
                      value: SortBy.date,
                      child: _buildPopupMenuChild(
                          context.tr.date, filterCubit!.sortByDate),
                      onTap: () {
                        changeSortType(SortBy.date);
                      },
                    ),
                  ],
                ),
                _hasFilterDot()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenuChild(String title, bool isSelected) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 2),
        if (isSelected) _selectedDot()
      ],
    );
  }

  Widget _hasFilterDot() {
    if (!filterCubit!.notSort) {
      return _selectedDot();
    }
    return Container();
  }

  Widget _selectedDot() {
    return const CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      radius: 4,
    );
  }
}
