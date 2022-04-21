import 'package:emdad/models/products_and_categories/product_model.dart';
import 'package:emdad/models/supply_request/request_item.dart';
import 'package:emdad/shared/network/services/user/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './cart_states.dart';

//Bloc builder and bloc consumer methods
typedef CartBlocBuilder = BlocBuilder<CartCubit, CartStates>;
typedef CartBlocConsumer = BlocConsumer<CartCubit, CartStates>;

//
class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(IntitalCartState());
  static CartCubit instance(BuildContext context) =>
      BlocProvider.of<CartCubit>(context);
  final _services = UserServices.instance;
  //Cart list
  List<RequestItem> _cartList = [];
  List<RequestItem> get cart => _cartList;
  //check if product found in list or not
  bool productInCart(String productId) {
    final index = cart.indexWhere((product) => product.id == productId);
    return index != -1;
  }

  //void remove from list
  void _removeFromCart(String productId) {
    _cartList.removeWhere((product) => product.id == productId);
  }

  //add or remove product from cart
  void addOrRemoveToCart(RequestItem requestItem) {
    final bool foundInList = productInCart(requestItem.id!);
    if (foundInList) {
      _removeFromCart(requestItem.id!);
    } else {
      _cartList.add(requestItem);
    }
    emit(ToggleAddingToCartState());
  }
}
