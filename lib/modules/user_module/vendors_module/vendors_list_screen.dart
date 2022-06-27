import 'dart:developer';

import 'package:emdad/shared/widgets/custom_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:emdad/models/general_models/settings_model.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_states.dart';
import 'package:emdad/modules/user_module/vendors_module/filter_vendor_cubit/filter_vendor_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/filter_vendor_cubit/filter_vendor_states.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/vendor_view_screen.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/cubit/app_cubit.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/default_search_field.dart';
import 'package:emdad/shared/widgets/empty_data.dart';
import 'package:emdad/shared/widgets/load_more_data.dart';
import 'package:emdad/shared/widgets/ui_componants/default_drop_down.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';

import 'vendor_build_item.dart';

class VendorsListScreen extends StatelessWidget {
  VendorsListScreen(
      {Key? key, required this.title, this.favoriteVendors = false})
      : super(key: key);

  final String title;
  final bool favoriteVendors;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilterVendorCubit(favoriteVendors)..getVendors(),
        ),
        BlocProvider(
          create: (context) {
            return ChangeFiltersCubit()..initFilters(context);
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: const [ChangeLangWidget()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _SearchField(
                  controller: searchController,
                ),
              ),
              FilterVendorBlocBuilder(builder: (context, state) {
                final filterVendorCubit = FilterVendorCubit.instance(context);
                return Builder(
                  builder: (context) {
                    if (state is GetVendorsLoadingState) {
                      return const Center(child: DefaultLoader());
                    }
                    if (state is GetVendorsErrorState) {
                      return NoDataWidget(
                          onPressed: () {
                            filterVendorCubit.getVendors();
                          },
                          text: state.error);
                    }
                    if (filterVendorCubit.errorVendors) {
                      return NoDataWidget(onPressed: () {
                        filterVendorCubit.getVendors();
                      });
                    }
                    final vendors = filterVendorCubit.vendors;
                    if (vendors.isEmpty) {
                      return const EmptyData(
                        emptyText: 'No Vendors available',
                      );
                    }

                    return ListView.builder(
                      itemCount: vendors.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => VendorBuildItem(
                        user: vendors[index],
                      ),
                    );
                  },
                );
              }),
              FilterVendorBlocBuilder(
                builder: (context, state) {
                  final filterVendorCubit = FilterVendorCubit.instance(context);
                  return LoadMoreData(
                    visible: !filterVendorCubit.isLastVendorPgae,
                    isLoading: state is GetMoreVendorsLoadingState,
                    onLoadingMore: () {
                      filterVendorCubit.getMoreVendors();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  void saveFiltersAndSearch(BuildContext context) {
    final changeFiltersCubit = ChangeFiltersCubit.instance(context);
    FilterVendorCubit.instance(context).setFilters(
      query: widget.controller.text,
      city: changeFiltersCubit.selectedCity,
      vendorType: changeFiltersCubit.selectedVendorType?.toList(),
    );
    FilterVendorCubit.instance(context).getVendors();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeFiltersBlocBuilder(
      builder: (context, state) {
        final changeFiltersCubit = ChangeFiltersCubit.instance(context);

        return Column(
          children: [
            DefaultSearchField(
              onChanged: (val) => {saveFiltersAndSearch(context)},
              searchController: widget.controller,
              onFilterTapped: () async {
                await showAppFilter(
                  context: context,
                  onSearch: () {
                    saveFiltersAndSearch(context);
                    Navigator.pop(context);
                  },
                  onDelete: () {
                    changeFiltersCubit.removeAllFilters();
                  },
                  filterItem: BlocProvider.value(
                    value: ChangeFiltersCubit.instance(context),
                    child: Builder(builder: (context) {
                      return ChangeFiltersBlocBuilder(
                        builder: (context, state) {
                          return SingleChildScrollView(
                              child: Column(
                            children: [
                              _FilterWidgetItem(
                                title: 'Country',
                                child: DefaultDropDown(
                                  items: changeFiltersCubit.countries,
                                  selectedValue:
                                      changeFiltersCubit.selectedCountry,
                                  onChanged: (val) => changeFiltersCubit
                                      .changeSelectedCountry(context, val),
                                  validator: (val) {
                                    return null;
                                  },
                                ),
                              ),
                              _FilterWidgetItem(
                                title: 'City',
                                child: DefaultDropDown(
                                  items: changeFiltersCubit.cities,
                                  selectedValue:
                                      changeFiltersCubit.selectedCity,
                                  onChanged:
                                      changeFiltersCubit.changeSelectedCity,
                                  validator: (val) {
                                    return null;
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  _FilterWidgetItem(
                                    title: 'Vendor Type',
                                    child: DefaultDropDown(
                                      items: changeFiltersCubit.vendorTypes,
                                      // selectedValue:
                                      //     changeFiltersCubit.selectedVendorType,
                                      onChanged:
                                          changeFiltersCubit.addVendorType,
                                      validator: (val) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  const _VendorTypeChipList(),
                                ],
                              ),
                            ],
                          ));
                        },
                      );
                    }),
                  ),
                );
              },
            ),
            _VendorTypeChipList(onDelete: (item) {
              FilterVendorCubit.instance(context)
                  .removeVendorTypeFromFilters(item);
              FilterVendorCubit.instance(context).getVendors();
            }),
          ],
        );
      },
    );
  }
}

class _VendorTypeChipList extends StatelessWidget {
  const _VendorTypeChipList({Key? key, this.onDelete}) : super(key: key);
  final void Function(String)? onDelete;

  @override
  Widget build(BuildContext context) {
    return ChangeFiltersBlocBuilder(
      builder: (context, state) {
        final changeFiltersCubit = ChangeFiltersCubit.instance(context);
        return Container(
          constraints: BoxConstraints(maxHeight: 0.2.sh),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 5,
                alignment: WrapAlignment.start,
                children: changeFiltersCubit.selectedVendorType
                        ?.map(
                          (item) => CustomChip(
                            item: item,
                            onDeleted: () {
                              changeFiltersCubit.removeVendorType(item);
                              if (onDelete != null) onDelete!(item);
                            },
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FilterWidgetItem extends StatelessWidget {
  const _FilterWidgetItem({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: thirdTextStyle(),
              ),
            ),
            Expanded(flex: 2, child: child)
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
