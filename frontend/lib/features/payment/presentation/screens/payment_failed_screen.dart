import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 120,
              ),

              const SizedBox(height: 30),

              const Text(
                "Payment Failed",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Something went wrong while processing your payment.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Try Again"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}