import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  static const String routeName = '/store_view';
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Store View',
          style: TextStyle(fontSize: 24),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
          child: const Text('Go to Details'),
        ),
      ],
    );
  }
}
