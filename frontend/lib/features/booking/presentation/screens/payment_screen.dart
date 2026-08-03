import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "UPI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Card(
              child: ListTile(
                leading: Icon(Icons.receipt_long),
                title: Text("Total Amount"),
                trailing: Text(
                  "₹1760",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            RadioListTile(
              value: "UPI",
              groupValue: selectedMethod,
              title: const Text("UPI"),
              secondary: const Icon(Icons.qr_code),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),

            RadioListTile(
              value: "Card",
              groupValue: selectedMethod,
              title: const Text("Credit / Debit Card"),
              secondary: const Icon(Icons.credit_card),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),

            RadioListTile(
              value: "Wallet",
              groupValue: selectedMethod,
              title: const Text("Wallet"),
              secondary: const Icon(Icons.account_balance_wallet),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),

            RadioListTile(
              value: "Net Banking",
              groupValue: selectedMethod,
              title: const Text("Net Banking"),
              secondary: const Icon(Icons.account_balance),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/booking-success');
                },
                child: const Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}