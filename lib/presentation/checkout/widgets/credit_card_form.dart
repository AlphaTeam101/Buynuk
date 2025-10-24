
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String _cardBrand = '';

  void _detectCardBrand(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      setState(() {
        _cardBrand = 'visa';
      });
    } else if (cardNumber.startsWith(RegExp(r'(5[1-5])'))) {
      setState(() {
        _cardBrand = 'mastercard';
      });
    } else {
      setState(() {
        _cardBrand = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          labelText: 'Card Number',
          prefixIcon: const Icon(Icons.credit_card),
          onChanged: _detectCardBrand,
          suffixIcon: _cardBrand.isNotEmpty
              ? SvgPicture.asset(
                  'assets/icons/$_cardBrand.svg',
                  width: 32,
                  height: 32,
                )
              : null,
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: AppTextField(
                labelText: 'MM/YY',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                labelText: 'CVV',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const AppTextField(
          labelText: 'Cardholder Name',
          prefixIcon: Icon(Icons.person),
        ),
      ],
    );
  }
}
