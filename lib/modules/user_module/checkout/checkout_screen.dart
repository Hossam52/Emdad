import 'package:emdad/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key, required this.onConfirmPressed})
      : super(key: key);
  final VoidCallback onConfirmPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PAYMENT"),
      ),
      body: Center(
        child: Column(
          children: [
            const Expanded(child: Center(child: Text('PAYMENT Screen'))),
            const Spacer(
              flex: 5,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pop(context, true);
                onConfirmPressed();
              },
              text: 'Pay',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
