import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DietPlanSummaryScreen extends StatelessWidget {
  const DietPlanSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image/Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      onPressed: () => Navigator.of(
                        context,
                      ).popUntil((route) => route.isFirst),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Your Smart Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "AI Analysis Complete",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Analysis Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Insights",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Based on your stats, you need more protein to support your active lifestyle. Your sleep is decent but try to aim for 8 hours.",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: const [
                          Chip(
                            label: Text("Low Iron"),
                            backgroundColor: Color(0xFFFFF3E0),
                          ),
                          Chip(
                            label: Text("Needs Fiber"),
                            backgroundColor: Color(0xFFE8F5E9),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Weekly Plan List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: const Text(
                  "This Week's Menu",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildDayCard(
                "Monday",
                "Spinach & Egg Omelet",
                "Grilled Chicken Salad",
                "Quinoa Bowl",
              ),
              _buildDayCard(
                "Tuesday",
                "Oatmeal with Berries",
                "Turkey Wrap",
                "Salmon & Veggies",
              ),
              _buildDayCard(
                "Wednesday",
                "Greek Yogurt",
                "Lentil Soup",
                "Stir Fry Tofu",
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCard(
    String day,
    String breakfast,
    String lunch,
    String dinner,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Divider(),
          _buildMealRow("Breakfast", breakfast),
          _buildMealRow("Lunch", lunch),
          _buildMealRow("Dinner", dinner),
        ],
      ),
    );
  }

  Widget _buildMealRow(String type, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
