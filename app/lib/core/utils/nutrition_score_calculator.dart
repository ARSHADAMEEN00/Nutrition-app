import 'package:flutter/material.dart';

/// Nutrition Score Calculator
///
/// Calculates a score (0-100) based on how well daily nutrition
/// meets recommended goals. Useful for gamification and progress tracking.
class NutritionScoreCalculator {
  /// Calculate overall nutrition score for a day
  ///
  /// Returns a score from 0-100 based on:
  /// - Calorie adherence (25 points)
  /// - Protein adherence (25 points)
  /// - Carbs adherence (25 points)
  /// - Fats adherence (25 points)
  static int calculateDailyScore({
    required double actualCalories,
    required double actualProtein,
    required double actualCarbs,
    required double actualFats,
    required double goalCalories,
    required double goalProtein,
    required double goalCarbs,
    required double goalFats,
  }) {
    final calorieScore = _calculateComponentScore(
      actual: actualCalories,
      goal: goalCalories,
      maxPoints: 25,
    );

    final proteinScore = _calculateComponentScore(
      actual: actualProtein,
      goal: goalProtein,
      maxPoints: 25,
    );

    final carbsScore = _calculateComponentScore(
      actual: actualCarbs,
      goal: goalCarbs,
      maxPoints: 25,
    );

    final fatsScore = _calculateComponentScore(
      actual: actualFats,
      goal: goalFats,
      maxPoints: 25,
    );

    final totalScore = calorieScore + proteinScore + carbsScore + fatsScore;
    return totalScore.round().clamp(0, 100);
  }

  /// Calculate score for a single nutrition component
  ///
  /// Uses deviation from goal to determine points:
  /// - 0% deviation = full points
  /// - 100% deviation = 0 points
  /// - Linear scaling in between
  static double _calculateComponentScore({
    required double actual,
    required double goal,
    required int maxPoints,
  }) {
    if (goal <= 0) return 0;

    // Calculate percentage deviation from goal
    final deviation = (actual - goal).abs() / goal;

    // Convert to score (inverse relationship)
    // 0% deviation = maxPoints, 100% deviation = 0
    final score = (1 - deviation) * maxPoints;

    return score.clamp(0, maxPoints.toDouble());
  }

  /// Get color based on nutrition score
  ///
  /// - 80-100: Excellent (Green)
  /// - 60-79: Good (Orange/Yellow)
  /// - 0-59: Needs Work (Red)
  static Color getScoreColor(int score) {
    if (score >= 80) {
      return const Color(0xFF4CAF50); // Green - Excellent
    } else if (score >= 60) {
      return const Color(0xFFFFBE76); // Orange - Good
    } else {
      return const Color(0xFFFF6B6B); // Red - Needs Work
    }
  }

  /// Get score category label
  static String getScoreCategory(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Great';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Fair';
    if (score >= 50) return 'Needs Work';
    return 'Poor';
  }

  /// Get score emoji
  static String getScoreEmoji(int score) {
    if (score >= 90) return '🌟';
    if (score >= 80) return '⭐';
    if (score >= 70) return '👍';
    if (score >= 60) return '😊';
    if (score >= 50) return '😐';
    return '😟';
  }

  /// Get detailed feedback based on scores
  static NutritionScoreFeedback getFeedback({
    required double actualCalories,
    required double actualProtein,
    required double actualCarbs,
    required double actualFats,
    required double goalCalories,
    required double goalProtein,
    required double goalCarbs,
    required double goalFats,
  }) {
    final calorieDeviation = _getDeviationPercentage(
      actualCalories,
      goalCalories,
    );
    final proteinDeviation = _getDeviationPercentage(
      actualProtein,
      goalProtein,
    );
    final carbsDeviation = _getDeviationPercentage(actualCarbs, goalCarbs);
    final fatsDeviation = _getDeviationPercentage(actualFats, goalFats);

    final issues = <String>[];
    final strengths = <String>[];

    // Check each component
    if (calorieDeviation.abs() < 0.1) {
      strengths.add('Calorie intake is perfect');
    } else if (calorieDeviation > 0.2) {
      issues.add('Consuming too many calories');
    } else if (calorieDeviation < -0.2) {
      issues.add('Not eating enough calories');
    }

    if (proteinDeviation.abs() < 0.1) {
      strengths.add('Protein intake is on target');
    } else if (proteinDeviation < -0.15) {
      issues.add('Need more protein');
    }

    if (carbsDeviation.abs() < 0.1) {
      strengths.add('Carb intake is balanced');
    } else if (carbsDeviation > 0.2) {
      issues.add('Too many carbs');
    }

    if (fatsDeviation.abs() < 0.1) {
      strengths.add('Healthy fat intake');
    } else if (fatsDeviation < -0.15) {
      issues.add('Need more healthy fats');
    }

    return NutritionScoreFeedback(
      issues: issues,
      strengths: strengths,
      calorieDeviation: calorieDeviation,
      proteinDeviation: proteinDeviation,
      carbsDeviation: carbsDeviation,
      fatsDeviation: fatsDeviation,
    );
  }

  /// Calculate deviation percentage (-1 to 1, where 0 is perfect)
  static double _getDeviationPercentage(double actual, double goal) {
    if (goal <= 0) return 0;
    return (actual - goal) / goal;
  }

  /// Calculate weekly average score
  static int calculateWeeklyAverageScore(List<int> dailyScores) {
    if (dailyScores.isEmpty) return 0;
    final sum = dailyScores.reduce((a, b) => a + b);
    return (sum / dailyScores.length).round();
  }

  /// Check if nutrition is balanced (all macros close to target)
  static bool isBalanced({
    required double actualProtein,
    required double actualCarbs,
    required double actualFats,
    required double goalProtein,
    required double goalCarbs,
    required double goalFats,
    double threshold = 0.15, // 15% deviation allowed
  }) {
    final proteinDeviation = _getDeviationPercentage(
      actualProtein,
      goalProtein,
    );
    final carbsDeviation = _getDeviationPercentage(actualCarbs, goalCarbs);
    final fatsDeviation = _getDeviationPercentage(actualFats, goalFats);

    return proteinDeviation.abs() < threshold &&
        carbsDeviation.abs() < threshold &&
        fatsDeviation.abs() < threshold;
  }
}

/// Feedback data class
class NutritionScoreFeedback {
  final List<String> issues;
  final List<String> strengths;
  final double calorieDeviation;
  final double proteinDeviation;
  final double carbsDeviation;
  final double fatsDeviation;

  NutritionScoreFeedback({
    required this.issues,
    required this.strengths,
    required this.calorieDeviation,
    required this.proteinDeviation,
    required this.carbsDeviation,
    required this.fatsDeviation,
  });

  /// Get overall message
  String get message {
    if (issues.isEmpty && strengths.isNotEmpty) {
      return 'Great job! ${strengths.join(', ')}.';
    } else if (issues.isNotEmpty) {
      return '${issues.join(', ')}. ${strengths.isNotEmpty ? strengths.first : ''}.';
    }
    return 'Keep up the good work!';
  }

  /// Check if nutrition is optimal (no issues)
  bool get isOptimal => issues.isEmpty;
}
