import 'dart:developer';

import 'package:emdad/models/enums/enums.dart';
import 'package:emdad/models/request_models/user/create_transportation_request_model.dart';
import 'package:emdad/models/request_models/vendor/add_offer_request_model.dart';
import 'package:emdad/models/supply_request/supply_request.dart';
import 'package:emdad/models/users/user/supply_requests/order_request_model.dart';
import 'package:emdad/shared/network/services/vendor/vendor_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './vendor_order_states.dart';

//Bloc builder and bloc consumer methods
typedef VendorOrderBlocBuilder
    = BlocBuilder<VendorOrderCubit, VendorOrderStates>;
typedef VendorOrderBlocConsumer
    = BlocConsumer<VendorOrderCubit, VendorOrderStates>;

//
class VendorOrderCubit extends Cubit<VendorOrderStates> {
  VendorOrderCubit(this.orderId) : super(IntitalVendorOrderState());
  static VendorOrderCubit instance(BuildContext context) =>
      BlocProvider.of<VendorOrderCubit>(context);
  final _services = VendorServices.instance;
  final String orderId;
  OrderRequestModel? _orderModel;
  final TextEditingController estimationTime = TextEditingController();

  bool _hasVendorManageTransport =
      false; //For know if the vendor has his own transportation
  bool get vendorManageTransport => _hasVendorManageTransport;

  bool get hasErrorOnOrder =>
      _orderModel == null; //To know if i don't load this order yet

  SupplyRequest get order {
    if (hasErrorOnOrder) {
      throw 'Must get order first';
    } else {
      return _orderModel!.supplyRequest;
    }
  }

  bool get addPriceToAllItemsAndShipping {
    log(order.transportationHandlerEnum.toString());

    return priceAllRequestItems &&
        priceAllAdditionalItems &&
        priceTransportation;
  }

  bool get priceAllRequestItems {
    final notPricedItems = order.requestItems
        .where(
            (element) => element.totalPrice == null || element.totalPrice == 0)
        .toList();
    if (notPricedItems.isNotEmpty) {
      throw 'Item ${notPricedItems.first.name} Not priced yet';
    }

    return order.requestItems.isEmpty || notPricedItems.isEmpty;
  }

  bool get priceAllAdditionalItems {
    final notPricedAdditional =
        order.additionalItems.where((element) => element.price == 0);
    if (notPricedAdditional.isNotEmpty) {
      throw 'Additional item ${notPricedAdditional.first.description} Not priced yet';
    }

    return (order.additionalItems.isEmpty || notPricedAdditional.isEmpty);
  }

  bool get priceTransportation {
    if (order.transportationHandlerEnum == FacilityType.vendor &&
        order.transportationPrice == 0) {
      throw 'You not provide shipping price yet';
    }
    return (order.transportationHandlerEnum == FacilityType.user ||
        order.transportationPrice != 0);
  }

  void changeVendorManageTransport() {
    _hasVendorManageTransport = !_hasVendorManageTransport;
    emit(ChangeVendorManageTransportationState());
  }

//APIS
  Future<void> getOrder() async {
    try {
      emit(GetVendorOrderLoadingState());
      final map = await _services.supplyRequestServices.getOrder(orderId);
      _orderModel = OrderRequestModel.fromMap(map);
      log(map.toString());
      emit(GetVendorOrderSuccessState());
    } catch (e) {
      emit(GetVendorOrderErrorState(error: e.toString()));
    }
  }

  Future<void> quoteOrder() async {
    try {
      emit(QuoteOrderLoadingState());
      final map = await _services.supplyRequestServices.quoteOrder(
        orderId: orderId,
        offerRequestModel: AddOfferRequestModel(
          estimationInSeconds: 1000,
          transportationPrice: order.transportationPrice,
          requestItems: order.requestItems
              .map(
                (e) => RequestItemRequestModel(
                    itemId: e.id!, totalPrice: e.totalPrice!),
              )
              .toList(),
          additionalItems: order.additionalItems
              .map((e) =>
                  AdditionalItemRequestModel(itemId: e.id, price: e.price))
              .toList(),
        ),
      );
      log(map.toString());
      emit(QuoteOrderSuccessState());
    } catch (e) {
      emit(QuoteOrderErrorState(error: e.toString()));
    }
  }

  Future<void> createVendorTransportationRequest(
      {required String city, required String transportationMethod}) async {
    try {
      emit(CreateVendorTransportationRequestLoadingState());
      final map = await _services.transportationServices.createTransportRequest(
          CreateTransportationRequestModel(
              supplyRequestId: orderId,
              transportationMethod: transportationMethod,
              city: city));
      getOrder();
      emit(CreateVendorTransportationRequestSuccessState());
    } catch (e) {
      emit(CreateVendorTransportationRequestErrorState(error: e.toString()));
    }
  }

//End apis

  void editItemPrice({required String requestId, required double price}) {
    final requestIndex =
        order.requestItems.indexWhere((element) => element.id == requestId);
    if (requestIndex != -1) {
      _orderModel!.supplyRequest.requestItems[requestIndex].totalPrice = price;
      emit(EditItemPriceState());
    }
  }

  void editAdditionalItemPrice(
      {required String additionalItemId, required double price}) {
    final itemIndex = order.additionalItems
        .indexWhere((element) => element.id == additionalItemId);
    if (itemIndex != -1) {
      _orderModel!.supplyRequest.additionalItems[itemIndex].price = price;
      emit(EditAdditionalItemPriceState());
    }
  }

  void editShippingPrice({required double price}) {
    _orderModel!.supplyRequest.transportationPrice = price;
    emit(EditShippingPriceState());
  }
}
