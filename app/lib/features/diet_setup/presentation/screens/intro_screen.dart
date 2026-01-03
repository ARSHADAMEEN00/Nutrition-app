import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'personal_stats_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Illustration
              Image.asset(
                'assets/images/intro_illustration.png',
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),

              // Encouraging Text
              const Text(
                "Nourish Your Body,\nFeed Your Soul",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Small steps every day lead to big changes. Let's build a plan that truly understands you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(),

              // Get Started Button
              PrimaryButton(
                text: "Get Started",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalStatsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
