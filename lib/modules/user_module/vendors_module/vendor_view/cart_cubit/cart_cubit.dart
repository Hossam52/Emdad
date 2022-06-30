import 'dart:developer';

import 'package:emdad/models/request_models/user/add_additional_request_item_model.dart';
import 'package:emdad/models/request_models/user/create_supply_request_model.dart';
import 'package:emdad/models/request_models/user/resend_supply_request_model.dart';
import 'package:emdad/models/supply_request/supply_request_cart.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../models/request_models/user/resend_supply_request_model.dart';
import './cart_states.dart';

//Bloc builder and bloc consumer methods
typedef CartBlocBuilder = BlocBuilder<CartCubit, CartStates>;
typedef CartBlocConsumer = BlocConsumer<CartCubit, CartStates>;

//
class CartCubit extends Cubit<CartStates> {
  CartCubit(
      {List<String>? initialAdditioalItems,
      List<ProductModelInCart>? intialCartItems})
      : super(IntitalCartState()) {
    _additionalItems = initialAdditioalItems ?? [];
    _cartList = intialCartItems ?? [];
  }
  static CartCubit instance(BuildContext context) =>
      BlocProvider.of<CartCubit>(context);
  final _services = UserServices.instance;
  //transportation handler
  bool _hasTransportation = false;
  bool get hasTransportation => _hasTransportation;
  void toggleHasTransportation() {
    _hasTransportation = !_hasTransportation;
    emit(ToggleHasTransportationState());
  }

//Additional items handler
  List<String> _additionalItems = [];
  List<String> get additionalItems => _additionalItems;
  void addAdditionalItem(String item) {
    int index = additionalItems.indexOf(item);
    if (index == -1) {
      _additionalItems.add(item);
      emit(SuccessAddAdditionalItem());
    } else {
      emit(ErrorAddAdditionalItem('Element $item already found'));
    }
  }

  void removeAdditionalItem(String item) {
    int index = additionalItems.indexOf(item);
    if (index == -1) {
      return;
    } else {
      _additionalItems.removeAt(index);
      emit(RemoveAdditionalItem());
    }
  }

  //Cart list
  List<ProductModelInCart> _cartList = [];
  List<ProductModelInCart> get cart => _cartList;
  //check if product found in list or not
  bool productInCart(String productId) {
    final index = cart.indexWhere((product) => product.product.id == productId);
    return index != -1;
  }

  //void remove from list
  void removeFromCart(String productId) {
    _cartList.removeWhere((product) => product.product.id == productId);
    emit(EditAndAddToCartState());
  }

  //add or remove product from cart
  void addOrEditCartItem(ProductModelInCart requestItem) {
    final bool foundInList = productInCart(requestItem.product.id);
    if (foundInList) {
      editCartItem(requestItem);
    } else {
      _cartList.add(requestItem);
    }
    emit(EditAndAddToCartState());
  }

  void editCartItem(ProductModelInCart productItem) {
    final index = _cartList.indexWhere(
        (cartItem) => cartItem.product.id == productItem.product.id);
    if (index == -1) return;
    _cartList[index] = productItem;
  }

  double get totalCartPrice {
    double totalPrice = 0;
    for (var element in _cartList) {
      totalPrice += element.selectedProductUnit.quantity *
          element.selectedProductUnit.unitPrice;
    }
    return totalPrice;
  }

  ProductModelInCart? getCartItem(String productId) {
    if (productInCart(productId)) {
      return _cartList.firstWhere((element) => element.product.id == productId);
    } else {
      return null;
    }
  }

  //can press order button
  bool get canOrderRequest => additionalItems.isNotEmpty || cart.isNotEmpty;
  //For create request on the server
  Future<void> createRequest() async {
    try {
      emit(CreateRequestLoadingState());
      await _services.requestServices.createSupplyRequest(
        CreateSupplyRequestModel(
          vendorId: cart.first.product.vendorId,
          isTransportationNeeded: _hasTransportation,
          requestItems:
              cart.map((product) => product.selectedProductUnit).toList(),
          additionalItems: additionalItems
              .map(
                (item) => AddAdditionalItemRequestModel(description: item),
              )
              .toList(),
        ),
      );
      emit(CreateRequestSuccessState());
    } catch (e) {
      log(e.toString());
      emit(CreateRequestErrorState(error: e.toString()));
    }
  }

  Future<void> resendOrderRequest({required String supplyRequestId}) async {
    try {
      emit(ResendOrderRequestLoadingState());
      final map = await _services.requestServices.resendSupplyRequestData(
        supplyRequestId,
        ResendSupplyRequestModel(
          requestItems:
              cart.map((product) => product.selectedProductUnit).toList(),
          additionalItems: additionalItems
              .map(
                (item) => AddAdditionalItemRequestModel(description: item),
              )
              .toList(),
        ),
      );
      log(map.toString());
      emit(ResendOrderRequestSuccessState());
    } catch (e) {
      emit(ResendOrderRequestErrorState(error: e.toString()));
    }
  }
}
