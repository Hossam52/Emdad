import 'package:emdad/modules/user_module/order_view/order_cubit/order_cubit.dart';
import 'package:emdad/modules/user_module/order_view/order_cubit/order_states.dart';
import 'package:emdad/shared/translation_service.dart';
import 'package:emdad/shared/widgets/default_loader.dart';
import 'package:emdad/shared/widgets/ui_componants/no_data_widget.dart';
import 'package:flutter/material.dart';

class OrderWidgetWrapper extends StatelessWidget {
  const OrderWidgetWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return OrderBlocBuilder(
      builder: (context, state) {
        final orderCubit = OrderCubit.instance(context);
        if (state is GetOrderLoadingState) return const DefaultLoader();
        if (state is GetOrderErrorState) {
          return NoDataWidget(onPressed: () {}, text: state.error);
        }
        if (orderCubit.emtpyOrder) {
          return NoDataWidget(
            onPressed: () {},
            text: context.tr.no_order_,
          );
        }
        return child;
      },
    );
  }
}
