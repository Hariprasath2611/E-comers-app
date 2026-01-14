import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    setState(() => _isLoading = true);
    // Simulate Admin Login
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/admin/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((255 * 0.1).toInt()),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.admin_panel_settings,
                  size: 60, color: Color(0xFF6750A4)),
              const SizedBox(height: 24),
              const Text(
                'Admin Portal',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: _passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Login',
                onPressed: _login,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
