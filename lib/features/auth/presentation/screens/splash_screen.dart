import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate check auth or initialization
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Go to onboarding or home based on auth (TODO)
        // context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_rounded,
              size: 100,
              color: Color(0xFF6750A4),
            ).animate()
             .fade(duration: 600.ms)
             .scale(delay: 200.ms),
            const SizedBox(height: 20),
            Text(
              'Shop',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ).animate()
             .fadeIn(delay: 400.ms)
             .moveY(begin: 20, end: 0),
          ],
        ),
      ),
    );
  }
}
