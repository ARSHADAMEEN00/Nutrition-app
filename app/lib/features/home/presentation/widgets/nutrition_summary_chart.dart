import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NutritionSummaryChart extends StatelessWidget {
  const NutritionSummaryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.inputBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Nutrition",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutrientRing("Carbs", 0.4, AppColors.secondary),
              _buildNutrientRing("Protein", 0.65, AppColors.primary),
              _buildNutrientRing("Fats", 0.3, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRing(String label, double percent, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 6,
                    backgroundColor: color.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${(percent * 100).toInt()}%",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
