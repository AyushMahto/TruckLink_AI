
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      context.pop();
    },
  ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Choose Your Role",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 20),

            _roleCard(
  context,
  icon: Icons.person,
  title: "Customer",
  subtitle: "Book trucks and track shipments",
  role: "customer",
),

            const SizedBox(height: 20),

            _roleCard(
  context,
  icon: Icons.local_shipping,
  title: "Driver",
  subtitle: "Accept delivery requests",
  role: "driver",
),

            const SizedBox(height: 20),

            _roleCard(
  context,
  icon: Icons.business,
  title: "Transport Company",
  subtitle: "Manage trucks and drivers",
  role: "fleet",
),
          ],
        ),
      ),
    );
  }

  Widget _roleCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required String role,
}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
  context.push('/signup?role=$role');
},
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              child: Icon(icon, color: Colors.blue, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
