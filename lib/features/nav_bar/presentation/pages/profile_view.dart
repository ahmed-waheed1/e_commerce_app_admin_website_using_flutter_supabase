import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile_view';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Profile View',
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
