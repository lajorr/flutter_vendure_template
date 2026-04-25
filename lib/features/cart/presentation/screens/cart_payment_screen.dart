import 'package:flutter/material.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';

class CartPaymentScreen extends StatelessWidget {
  const CartPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Payment'),
      body: Center(
        child: Text('Payment Screen (Coming Soon)'),
      ),
    );
  }
}
