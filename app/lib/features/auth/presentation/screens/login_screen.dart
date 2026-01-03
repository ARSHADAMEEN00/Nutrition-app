import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_providers.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref
            .read(authServiceProvider)
            .login(_emailController.text, _passwordController.text);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
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
                const SizedBox(height: 60),
                // Header
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue your nutrition journey.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),

                // Inputs
                CustomTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter email' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter password' : null,
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Button
                PrimaryButton(
                  text: 'Login',
                  isLoading: _isLoading,
                  onPressed: _handleLogin,
                ),

                const SizedBox(height: 24),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
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
