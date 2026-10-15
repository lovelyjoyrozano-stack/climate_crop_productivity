import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login verified! Redirecting to Decision Portal...')),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Farmer Authentication'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: AppColors.cardShadow, blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Portal Sign In',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    label: 'Email / Phone',
                    hint: 'Enter registered account',
                    controller: _emailController,
                    validator: (val) => (val == null || val.isEmpty) ? 'Please enter your account identity' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Password',
                    hint: 'Enter account password',
                    obscureText: true,
                    controller: _passwordController,
                    validator: (val) => (val == null || val.length < 6) ? 'Password must be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Login',
                      onPressed: _handleLogin,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Back to Main Shell',
                      isSecondary: true,
                      onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}