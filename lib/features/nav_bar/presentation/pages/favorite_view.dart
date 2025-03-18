import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  static const String routeName = '/favorite_view';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Favorite View',
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
