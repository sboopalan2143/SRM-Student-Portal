import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage1 extends ConsumerStatefulWidget {
  const ProfilePage1({super.key});

  @override
  ConsumerState createState() => _ProfilePage1State();
}

class _ProfilePage1State extends ConsumerState<ProfilePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Pop out'),
        ),
      ),
    );
  }
}
