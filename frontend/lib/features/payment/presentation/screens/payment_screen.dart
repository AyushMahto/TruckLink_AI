import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/payment_method_tile.dart';
import '../widgets/payment_summary_card.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;

  const PaymentScreen({
    super.key,
    required this.amount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "UPI";
  bool isLoading = false;

  Future<void> makePayment() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // Fake success for now
    context.go("/payment-success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PaymentSummaryCard(
              amount: widget.amount,
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose Payment Method",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            PaymentMethodTile(
              title: "UPI",
              icon: Icons.qr_code,
              selected: selectedMethod == "UPI",
              onTap: () {
                setState(() {
                  selectedMethod = "UPI";
                });
              },
            ),

            PaymentMethodTile(
              title: "Credit / Debit Card",
              icon: Icons.credit_card,
              selected: selectedMethod == "CARD",
              onTap: () {
                setState(() {
                  selectedMethod = "CARD";
                });
              },
            ),

            PaymentMethodTile(
              title: "Net Banking",
              icon: Icons.account_balance,
              selected: selectedMethod == "BANK",
              onTap: () {
                setState(() {
                  selectedMethod = "BANK";
                });
              },
            ),

            PaymentMethodTile(
              title: "Cash on Delivery",
              icon: Icons.payments,
              selected: selectedMethod == "COD",
              onTap: () {
                setState(() {
                  selectedMethod = "COD";
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : makePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        "Pay ₹${(widget.amount + 50).toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}