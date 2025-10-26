
import 'package:e_commerce/presentation/checkout/widgets/checkout_payment_selector.dart';
import 'package:e_commerce/presentation/checkout/widgets/checkout_section.dart';
import 'package:e_commerce/presentation/checkout/widgets/credit_card_form.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PaymentMethod { none, paypal, card }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.none;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckoutSection(
              title: 'Shipping Details',
              child: const _ShippingInfo(),
            ),
            const SizedBox(height: 24),
            CheckoutSection(
              title: 'Payment Method',
              child: CheckoutPaymentSelector(
                selectedMethod: _selectedMethod,
                onMethodSelected: (method) {
                  setState(() {
                    _selectedMethod = method;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _buildPaymentForm(),
            ),
            const SizedBox(height: 24),
            CheckoutSection(
              title: 'Order Summary',
              child: Column(
                children: [
                  const _SummaryRow(label: 'Subtotal', amount: 85.00),
                  const SizedBox(height: 8),
                  const _SummaryRow(label: 'Shipping', amount: 7.50),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: textTheme.titleLarge),
                      Text('92.50 SAR', style: textTheme.headlineSmall),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Confirm Purchase',
              onPressed: () {},
              isFullWidth: true,
            ),
          ].animate(interval: 80.ms).fade(duration: 500.ms).slideX(begin: 0.2, curve: Curves.easeOutCubic),
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    switch (_selectedMethod) {
      case PaymentMethod.card:
        return const CreditCardForm().animate().fade(duration: 400.ms).slideY(begin: 0.1, curve: Curves.easeOut);
      case PaymentMethod.paypal:
        return const _PayPalButton();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ShippingInfo extends StatelessWidget {
  const _ShippingInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _InfoRow(icon: Icons.location_on, text: 'Baghdad, Karrada'),
        SizedBox(height: 16),
        _InfoRow(icon: Icons.phone, text: '+20 100 123 4567'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Text(text),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double amount;

  const _SummaryRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text('${amount.toStringAsFixed(2)} SAR'),
      ],
    );
  }
}

class _PayPalButton extends StatelessWidget {
  const _PayPalButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00457C), // PayPal blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/paypal.svg',
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          const Text(
            'Continue with PayPal',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
