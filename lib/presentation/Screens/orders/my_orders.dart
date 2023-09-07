import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("My Orders"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,70),
        child: FloatingActionButton(
          onPressed: () {},
          tooltip: "Add new Address",
          child: const Icon(
            Icons.add_home_work_outlined,
          ),
        ),
      ),
    );
  }
}
