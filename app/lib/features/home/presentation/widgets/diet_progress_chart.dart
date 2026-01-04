import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DietProgressChart extends StatelessWidget {
  const DietProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - current week
    const int currentWeek = 2;
    const int totalWeeks = 6;
    const double currentWeight = 75.0;
    const double targetWeight = 68.0;
    const double startWeight = 78.0;

    final progressPercentage = (currentWeek / totalWeeks * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryDark.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Progress Journey",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Week $currentWeek of $totalWeeks",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$progressPercentage%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Timeline visualization
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Background line
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.inputBackground,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Progress line
                      Positioned(
                        top: 30,
                        left: 0,
                        right:
                            MediaQuery.of(context).size.width *
                            (1 - (currentWeek / totalWeeks)),
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Milestone markers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMilestone(
                            "Start",
                            "${startWeight}kg",
                            true,
                            currentWeek >= 0,
                          ),
                          _buildMilestone(
                            "Week 2",
                            "${(startWeight - 1.5).toStringAsFixed(1)}kg",
                            false,
                            currentWeek >= 2,
                          ),
                          _buildMilestone(
                            "Week 4",
                            "${(startWeight - 4).toStringAsFixed(1)}kg",
                            false,
                            currentWeek >= 4,
                          ),
                          _buildMilestone(
                            "Goal",
                            "${targetWeight}kg",
                            false,
                            currentWeek >= totalWeeks,
                            isGoal: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Current",
                  "${currentWeight}kg",
                  Icons.monitor_weight_outlined,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  "Lost",
                  "${(startWeight - currentWeight).toStringAsFixed(1)}kg",
                  Icons.trending_down,
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  "To Go",
                  "${(currentWeight - targetWeight).toStringAsFixed(1)}kg",
                  Icons.flag_outlined,
                  const Color(0xFFFF9800),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Expected outcomes
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.inputBackground),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Expected by Week 6",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildExpectationRow(
                  Icons.fitness_center,
                  "Reach target weight",
                  "${targetWeight}kg",
                ),
                const SizedBox(height: 8),
                _buildExpectationRow(
                  Icons.energy_savings_leaf,
                  "Energy levels",
                  "+35%",
                ),
                const SizedBox(height: 8),
                _buildExpectationRow(
                  Icons.favorite_outline,
                  "Overall health",
                  "Improved",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestone(
    String label,
    String value,
    bool isStart,
    bool isCompleted, {
    bool isGoal = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isCompleted ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        // Marker
        Container(
          width: isGoal ? 32 : 24,
          height: isGoal ? 32 : 24,
          decoration: BoxDecoration(
            color: isCompleted
                ? (isGoal ? const Color(0xFF4CAF50) : AppColors.primary)
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted
                  ? (isGoal ? const Color(0xFF4CAF50) : AppColors.primary)
                  : AppColors.inputBackground,
              width: 2,
            ),
            boxShadow: isCompleted
                ? [
                    BoxShadow(
                      color:
                          (isGoal ? const Color(0xFF4CAF50) : AppColors.primary)
                              .withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: isCompleted
              ? Icon(
                  isGoal ? Icons.flag : Icons.check,
                  color: Colors.white,
                  size: isGoal ? 18 : 14,
                )
              : null,
        ),
        const SizedBox(height: 6),
        // Value
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isCompleted
                ? AppColors.textPrimary
                : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBackground),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildExpectationRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
