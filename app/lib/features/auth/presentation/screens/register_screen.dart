import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // We only pass name, email, password as requested
        // Passing dummy/default values for the health data since they are now optional in backend
        await ref
            .read(authServiceProvider)
            .register(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              age: 0,
              gender: 'Other',
              height: 0,
              weight: 0,
            );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration Successful! Please login.'),
            ),
          );
          // Navigate to Login or Home (Currently just popping back to login)
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Back Button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 20),

                // Header
                Text(
                  'Join NutriAI',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your personalized nutrition journey today.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 40),

                // Name Input
                CustomTextField(
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),

                // Email Input
                CustomTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter email' : null,
                ),
                const SizedBox(height: 16),

                // Password Input
                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (val) =>
                      (val!.length < 6) ? 'Password must be 6+ chars' : null,
                ),

                const SizedBox(height: 32),

                // Register Button
                PrimaryButton(
                  text: 'Create Account',
                  isLoading: _isLoading,
                  onPressed: _handleRegister,
                ),

                const SizedBox(height: 24),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
