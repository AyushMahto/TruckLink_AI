import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundColor: Color(0xff2563EB),
          child: Icon(Icons.local_shipping, color: Colors.white),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hi Ayush 👋",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Let's move your goods today.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),

        const CircleAvatar(
          backgroundColor: Colors.black12,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
