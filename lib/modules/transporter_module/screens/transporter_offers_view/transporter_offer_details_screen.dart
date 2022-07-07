import 'package:emdad/layout/transporter_layout/transporter_layout.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/supply_request/user_preview.dart';
import 'package:emdad/modules/map_module/screens/map_screen.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_order_details_cubit/transporter_order_details_cubit.dart';
import 'package:emdad/modules/transporter_module/transporter_cubits/transporter_order_details_cubit/transporter_order_details_states.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_all_items.dart';
import 'package:emdad/modules/transporter_module/transporter_widgets/transporter_price_overview.dart';
import 'package:emdad/modules/user_module/order_view/order_item_build.dart';
import 'package:emdad/modules/user_module/order_view/order_statuses_views/orders_widgets/order_total_row_item.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_cubit.dart';
import 'package:emdad/modules/user_module/vendors_module/change_filters_cubit/change_filters_states.dart';
import 'package:emdad/shared/componants/components.dart';
import 'package:emdad/shared/componants/shared_methods.dart';
import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/change_language_widget.dart';
import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:emdad/shared/widgets/custom_text_form_field.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/dialogs/edit_price_dialogs.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TransporterOfferDetailsScreen extends StatelessWidget {
  const TransporterOfferDetailsScreen({Key? key, required this.transportId})
      : super(key: key);
  final String transportId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: CustomText(
          text: context.tr.order_details,
          textStyle: primaryTextStyle().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [ChangeLangWidget(color: Colors.white)],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TrnasporterOrderDetailsCubit(transportId: transportId)
                  ..getTransport(),
          ),
          BlocProvider(
            create: (_) => ChangeFiltersCubit()..initFilters(context),
            lazy: false,
          ),
        ],
        child: TrnasporterOrderDetailsBlocConsumer(
          listener: (context, state) {
            if (state is CreatePriceOfferSuccessState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => SuccessSendingOffer(onPressed: () {
                        navigateToAndFinish(context, const TransporterLayout());
                      }));
            }
            if (state is CreatePriceOfferErrorState) {
              SharedMethods.showToast(context, state.error,
                  color: AppColors.errorColor, textColor: Colors.white);
            }
          },
          builder: (context, state) {
            final orderCubit = TrnasporterOrderDetailsCubit.instance(context);
            if (state is GetTransportLoadingState) return const DefaultLoader();
            if (state is GetTransportErrorState) {
              return NoDataWidget(
                  onPressed: () {
                    orderCubit.getTransport();
                  },
                  text: state.error);
            }
            if (orderCubit.errorInOrder) {
              return NoDataWidget(
                  onPressed: () {
                    orderCubit.getTransport();
                  },
                  text: context.tr.order_error_try_again);
            }
            final order = orderCubit.order;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OrderRequesterAndRecieverLocations(
                    order: order.supplyRequest,
                  ),
                  SizedBox(height: 40.h),
                  TransporterAllItemsWidget(
                    items: order.supplyRequest.requestItems,
                    additionalItems: order.supplyRequest.additionalItems,
                  ),
                  SizedBox(height: 20.h),
                  _OrderNotes(
                    desiredTransportation: order.transportationMethod,
                  ),
                  SizedBox(height: 20.h),
                  const _TransportationMethod(),
                  SizedBox(height: 20.h),
                  TransporterPriceOverview(
                    price: orderCubit.transportationPrice,
                    onPriceTap: () async {
                      final price = await showModalBottomSheet<double?>(
                          context: context,
                          builder: (_) => const EditShippingPriceDialog());
                      if (price != null) {
                        orderCubit.setTransportationPrice = price;
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  _TransporterNoteTextField(
                      controller: orderCubit.myNotesController),
                  SizedBox(height: 20.h),
                  state is CreatePriceOfferLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          width: 308.w,
                          height: 57.h,
                          onPressed: () async {
                            final transportationMethod =
                                ChangeFiltersCubit.instance(context)
                                    .selectedTransportation;
                            if (transportationMethod == null) {
                              SharedMethods.showToast(context,
                                  context.tr.must_choose_transportation_method,
                                  color: AppColors.errorColor,
                                  textColor: Colors.white);
                              return;
                            }
                            if (!orderCubit.hasProvidePrice) {
                              SharedMethods.showToast(context,
                                  context.tr.must_speicify_delivery_price,
                                  color: AppColors.errorColor,
                                  textColor: Colors.white);
                              return;
                            }
                            await orderCubit.createPriceOffer(context);
                          },
                          text: context.tr.send_price_delivery,
                          textStyle: thirdTextStyle().copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrderRequesterAndRecieverLocations extends StatelessWidget {
  const _OrderRequesterAndRecieverLocations({
    Key? key,
    required this.order,
  }) : super(key: key);
  final SupplyRequest order;
  @override
  Widget build(BuildContext context) {
    final vendor = order.vendor;
    final user = order.user;
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset('assets/images/shipping_fast.svg'),
        Column(
          children: [
            CustomListTile(user: vendor),
            SizedBox(height: 30.h),
            CustomListTile(user: user),
          ],
        ),
      ],
    );
  }
}

class _OrderNotes extends StatelessWidget {
  const _OrderNotes({Key? key, required this.desiredTransportation})
      : super(key: key);
  final String desiredTransportation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: context.tr.notes,
          textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
        ),
        Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 91.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: CustomText(
              text: context.tr.prefer_transportation + desiredTransportation,
              textAlign: TextAlign.start,
              textStyle:
                  thirdTextStyle().copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransportationMethod extends StatelessWidget {
  const _TransportationMethod({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeFiltersBlocBuilder(
      builder: (context, state) {
        final changeFiltersCubit = ChangeFiltersCubit.instance(context);
        return Row(
          children: [
            CustomText(
              text: context.tr.transportation_method,
              textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 20.w),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(5.w),
                height: 40.h,
                child: DropdownButton(
                  underline: const Text(''),
                  style: subTextStyle().copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  value: changeFiltersCubit.selectedTransportation,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: changeFiltersCubit.transportationMethods
                      .map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    TrnasporterOrderDetailsCubit.instance(context)
                        .setTransportationMethod = newValue!;
                    changeFiltersCubit.changeSelectedTransportation(newValue);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TransporterNoteTextField extends StatelessWidget {
  const _TransporterNoteTextField({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: context.tr.your_notes,
          textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w700),
        ),
        CustomTextFormField(
          validation: (_) => null,
          controller: controller,
          hint: context.tr.add_your_notes_for_the_requester,
          contentPadding: const EdgeInsets.all(5),
          minLines: 2,
          maxLines: 3,
          borderRadius: 10,
        ),
      ],
    );
  }
}

class SuccessSendingOffer extends StatelessWidget {
  const SuccessSendingOffer({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: context.tr.done_sending_offer,
        textStyle: thirdTextStyle().copyWith(fontWeight: FontWeight.w500),
      ),
      content: CircleAvatar(
        radius: 40.r,
        backgroundColor: const Color(0xff39AA2D),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      actions: <Widget>[
        CustomButton(
          width: 215.w,
          text: context.tr.close,
          backgroundColor: Colors.red,
          textStyle: thirdTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          onPressed: () {
            Navigator.of(context).pop(true);
            onPressed();
          },
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserPreviewModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 53.w,
              height: 53.w,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: DefaultCachedNetworkImage(
                imageUrl: user.logoUrl, //order.vendor.logoUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: user.oraganizationName,
                  textStyle: thirdTextStyle()
                      .copyWith(color: AppColors.primaryColor, fontSize: 12.sp),
                ),
                CustomText(
                  text: user.detailAddress,
                  textStyle:
                      subTextStyle().copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 42.h,
          width: 42.w,
          margin: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.textButtonColor,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                navigateTo(
                    context,
                    MapScreen(
                      lat: user.locationObject.lat,
                      lng: user.locationObject.lng,
                      screenTitle: user.oraganizationName,
                    ));
              },
              icon: Icon(
                Icons.edit_location_outlined,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
