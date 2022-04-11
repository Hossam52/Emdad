import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PAYMENT"),
      ),
      body: const Center(
        child: Text('PAYMENT Screen'),
      ),
    );
  }
}
