import 'package:emdad/models/supply_request/supply_request_cart.dart';
import 'package:emdad/modules/user_module/vendors_module/vendor_view/cart_cubit/cart_cubit.dart';
import 'package:emdad/shared/widgets/dialogs/add_to_price_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBuildItem extends StatelessWidget {
  const CartBuildItem({Key? key, required this.productInCart})
      : super(key: key);
  final ProductModelInCart productInCart;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              CartCubit.instance(context)
                  .removeFromCart(productInCart.product.id);
            },
            icon: const Icon(Icons.delete_outline),
          ),
          const SizedBox(width: 3),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.29,
            child: productInCart.product.images.isNotEmpty
                ? DefaultCachedNetworkImage(
                    imageUrl: productInCart.product.images.first,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    productInCart.product.name,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 7),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: CartCubit.instance(context),
                        child: AddToPriceRequestDialog(
                            product: productInCart.product),
                      ),
                    );
                  },
                  child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: (Colors.grey[300])!,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          priceUnit,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String get priceUnit {
    return productInCart.selectedProductUnit.quantity.toString() +
        ' ' +
        productInCart.selectedProductUnit.productUnit;
  }
}
