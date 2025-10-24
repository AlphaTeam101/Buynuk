
import 'package:e_commerce/presentation/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentSelector extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodSelected;

  const CheckoutPaymentSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<PaymentMethod>(
          title: const Text('PayPal'),
          value: PaymentMethod.paypal,
          groupValue: selectedMethod,
          onChanged: (value) => onMethodSelected(value!),
        ),
        RadioListTile<PaymentMethod>(
          title: const Text('Credit/Debit Card'),
          value: PaymentMethod.card,
          groupValue: selectedMethod,
          onChanged: (value) => onMethodSelected(value!),
        ),
      ],
    );
  }
}
