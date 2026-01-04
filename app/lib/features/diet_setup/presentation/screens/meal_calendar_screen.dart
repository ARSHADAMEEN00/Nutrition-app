import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/nutrition_score_calculator.dart';

// Model for a day's meal plan
class DayMealPlan {
  final String day;
  final DateTime date;
  final List<Meal> meals;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFats;

  DayMealPlan({
    required this.day,
    required this.date,
    required this.meals,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
  });
}

class Meal {
  final String type; // Breakfast, Lunch, Dinner, Snack
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final List<String> ingredients;

  Meal({
    required this.type,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    this.ingredients = const [],
  });
}

class MealCalendarScreen extends StatefulWidget {
  const MealCalendarScreen({super.key});

  @override
  State<MealCalendarScreen> createState() => _MealCalendarScreenState();
}

class _MealCalendarScreenState extends State<MealCalendarScreen> {
  int _selectedDayIndex = 0;
  final PageController _pageController = PageController();

  // Sample data - Replace with actual data from API
  final List<DayMealPlan> _weekPlan = [
    DayMealPlan(
      day: 'Monday',
      date: DateTime.now(),
      totalCalories: 1850,
      totalProtein: 95,
      totalCarbs: 185,
      totalFats: 62,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Spinach & Egg Omelet',
          calories: 350,
          protein: 28,
          carbs: 12,
          fats: 22,
          ingredients: ['Eggs', 'Spinach', 'Cheese'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Grilled Chicken Salad',
          calories: 450,
          protein: 42,
          carbs: 35,
          fats: 18,
          ingredients: ['Chicken', 'Lettuce', 'Tomatoes', 'Olive Oil'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Quinoa Bowl with Vegetables',
          calories: 520,
          protein: 20,
          carbs: 68,
          fats: 18,
          ingredients: ['Quinoa', 'Broccoli', 'Bell Peppers', 'Tofu'],
        ),
        Meal(
          type: 'Snack',
          name: 'Greek Yogurt with Berries',
          calories: 180,
          protein: 15,
          carbs: 22,
          fats: 4,
          ingredients: ['Greek Yogurt', 'Blueberries', 'Honey'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Tuesday',
      date: DateTime.now().add(const Duration(days: 1)),
      totalCalories: 1920,
      totalProtein: 88,
      totalCarbs: 205,
      totalFats: 58,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Oatmeal with Berries',
          calories: 320,
          protein: 12,
          carbs: 52,
          fats: 8,
          ingredients: ['Oats', 'Strawberries', 'Almonds'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Turkey Wrap',
          calories: 480,
          protein: 35,
          carbs: 48,
          fats: 18,
          ingredients: ['Turkey', 'Whole Wheat Tortilla', 'Avocado'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Salmon & Vegetables',
          calories: 580,
          protein: 38,
          carbs: 42,
          fats: 28,
          ingredients: ['Salmon', 'Sweet Potato', 'Asparagus'],
        ),
        Meal(
          type: 'Snack',
          name: 'Protein Smoothie',
          calories: 240,
          protein: 25,
          carbs: 28,
          fats: 6,
          ingredients: ['Protein Powder', 'Banana', 'Almond Milk'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Wednesday',
      date: DateTime.now().add(const Duration(days: 2)),
      totalCalories: 1780,
      totalProtein: 92,
      totalCarbs: 175,
      totalFats: 55,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Greek Yogurt Parfait',
          calories: 300,
          protein: 22,
          carbs: 35,
          fats: 8,
          ingredients: ['Greek Yogurt', 'Granola', 'Berries'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Lentil Soup with Bread',
          calories: 420,
          protein: 18,
          carbs: 62,
          fats: 12,
          ingredients: ['Lentils', 'Carrots', 'Whole Grain Bread'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Stir Fry Tofu',
          calories: 510,
          protein: 28,
          carbs: 58,
          fats: 22,
          ingredients: ['Tofu', 'Brown Rice', 'Mixed Vegetables'],
        ),
        Meal(
          type: 'Snack',
          name: 'Apple with Peanut Butter',
          calories: 190,
          protein: 6,
          carbs: 24,
          fats: 8,
          ingredients: ['Apple', 'Peanut Butter'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Thursday',
      date: DateTime.now().add(const Duration(days: 3)),
      totalCalories: 1880,
      totalProtein: 98,
      totalCarbs: 188,
      totalFats: 60,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Avocado Toast with Eggs',
          calories: 380,
          protein: 18,
          carbs: 32,
          fats: 22,
          ingredients: ['Whole Grain Bread', 'Avocado', 'Eggs'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Chicken Quinoa Bowl',
          calories: 520,
          protein: 42,
          carbs: 55,
          fats: 18,
          ingredients: ['Chicken', 'Quinoa', 'Kale', 'Tahini'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Beef Stir Fry',
          calories: 550,
          protein: 35,
          carbs: 48,
          fats: 18,
          ingredients: ['Lean Beef', 'Rice Noodles', 'Vegetables'],
        ),
        Meal(
          type: 'Snack',
          name: 'Cottage Cheese with Fruit',
          calories: 180,
          protein: 15,
          carbs: 18,
          fats: 4,
          ingredients: ['Cottage Cheese', 'Peaches'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Friday',
      date: DateTime.now().add(const Duration(days: 4)),
      totalCalories: 1950,
      totalProtein: 102,
      totalCarbs: 195,
      totalFats: 65,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Protein Pancakes',
          calories: 420,
          protein: 28,
          carbs: 48,
          fats: 15,
          ingredients: ['Protein Powder', 'Oats', 'Banana', 'Eggs'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Tuna Salad Bowl',
          calories: 480,
          protein: 38,
          carbs: 42,
          fats: 18,
          ingredients: ['Tuna', 'Mixed Greens', 'Quinoa', 'Olive Oil'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Grilled Chicken with Sweet Potato',
          calories: 580,
          protein: 45,
          carbs: 62,
          fats: 18,
          ingredients: ['Chicken', 'Sweet Potato', 'Green Beans'],
        ),
        Meal(
          type: 'Snack',
          name: 'Trail Mix',
          calories: 220,
          protein: 8,
          carbs: 22,
          fats: 12,
          ingredients: ['Almonds', 'Cashews', 'Dried Fruit'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Saturday',
      date: DateTime.now().add(const Duration(days: 5)),
      totalCalories: 2050,
      totalProtein: 95,
      totalCarbs: 215,
      totalFats: 68,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'French Toast with Berries',
          calories: 450,
          protein: 18,
          carbs: 62,
          fats: 15,
          ingredients: ['Whole Grain Bread', 'Eggs', 'Berries', 'Honey'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Veggie Burger with Fries',
          calories: 620,
          protein: 22,
          carbs: 78,
          fats: 25,
          ingredients: ['Veggie Patty', 'Bun', 'Sweet Potato Fries'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Pasta with Meatballs',
          calories: 680,
          protein: 38,
          carbs: 72,
          fats: 25,
          ingredients: ['Whole Wheat Pasta', 'Turkey Meatballs', 'Marinara'],
        ),
        Meal(
          type: 'Snack',
          name: 'Dark Chocolate & Almonds',
          calories: 180,
          protein: 5,
          carbs: 18,
          fats: 12,
          ingredients: ['Dark Chocolate', 'Almonds'],
        ),
      ],
    ),
    DayMealPlan(
      day: 'Sunday',
      date: DateTime.now().add(const Duration(days: 6)),
      totalCalories: 1820,
      totalProtein: 88,
      totalCarbs: 178,
      totalFats: 58,
      meals: [
        Meal(
          type: 'Breakfast',
          name: 'Vegetable Omelet',
          calories: 320,
          protein: 24,
          carbs: 18,
          fats: 18,
          ingredients: ['Eggs', 'Bell Peppers', 'Mushrooms', 'Cheese'],
        ),
        Meal(
          type: 'Lunch',
          name: 'Mediterranean Bowl',
          calories: 520,
          protein: 28,
          carbs: 62,
          fats: 20,
          ingredients: ['Falafel', 'Hummus', 'Rice', 'Salad'],
        ),
        Meal(
          type: 'Dinner',
          name: 'Roasted Chicken with Vegetables',
          calories: 550,
          protein: 42,
          carbs: 48,
          fats: 18,
          ingredients: ['Chicken', 'Roasted Vegetables', 'Quinoa'],
        ),
        Meal(
          type: 'Snack',
          name: 'Fruit Salad',
          calories: 150,
          protein: 2,
          carbs: 35,
          fats: 1,
          ingredients: ['Mixed Fruits', 'Honey'],
        ),
      ],
    ),
  ];

  // Daily nutrition goals
  final double dailyCalorieGoal = 2000;
  final double dailyProteinGoal = 100;
  final double dailyCarbsGoal = 200;
  final double dailyFatsGoal = 65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Calendar Week View
            _buildCalendarWeek(),

            // Selected Day Summary
            _buildDaySummary(),

            const SizedBox(height: 16),

            // Meal Details PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedDayIndex = index;
                  });
                },
                itemCount: _weekPlan.length,
                itemBuilder: (context, index) {
                  return _buildMealList(_weekPlan[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "Meal Planning Calendar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {
                  // Show month calendar
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  "AI Generated Weekly Plan",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarWeek() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_weekPlan.length, (index) {
          final dayPlan = _weekPlan[index];
          final isSelected = index == _selectedDayIndex;
          final nutritionScore = _calculateNutritionScore(dayPlan);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: 45,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    dayPlan.day.substring(0, 3),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dayPlan.date.day.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _getScoreColor(nutritionScore),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDaySummary() {
    final dayPlan = _weekPlan[_selectedDayIndex];
    final nutritionScore = _calculateNutritionScore(dayPlan);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getScoreColor(nutritionScore).withOpacity(0.1),
            _getScoreColor(nutritionScore).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getScoreColor(nutritionScore).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayPlan.day,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    "${dayPlan.meals.length} meals planned",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getScoreColor(nutritionScore),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "$nutritionScore/100",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildNutritionProgress(
                  "Calories",
                  dayPlan.totalCalories,
                  dailyCalorieGoal,
                  "kcal",
                  Icons.local_fire_department,
                  const Color(0xFFFF6B6B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNutritionProgress(
                  "Protein",
                  dayPlan.totalProtein,
                  dailyProteinGoal,
                  "g",
                  Icons.fitness_center,
                  const Color(0xFF4ECDC4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildNutritionProgress(
                  "Carbs",
                  dayPlan.totalCarbs,
                  dailyCarbsGoal,
                  "g",
                  Icons.grass,
                  const Color(0xFFFFBE76),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNutritionProgress(
                  "Fats",
                  dayPlan.totalFats,
                  dailyFatsGoal,
                  "g",
                  Icons.water_drop,
                  const Color(0xFF95E1D3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionProgress(
    String label,
    double current,
    double goal,
    String unit,
    IconData icon,
    Color color,
  ) {
    final percentage = (current / goal * 100).clamp(0, 100).toInt();
    final progress = (current / goal).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${current.toInt()}/$goal$unit ($percentage%)",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMealList(DayMealPlan dayPlan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: dayPlan.meals.length,
        itemBuilder: (context, index) {
          return _buildMealCard(dayPlan.meals[index]);
        },
      ),
    );
  }

  Widget _buildMealCard(Meal meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getMealTypeColor(meal.type).withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getMealTypeColor(meal.type),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getMealTypeIcon(meal.type),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getMealTypeColor(meal.type),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          meal.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B6B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          size: 14,
                          color: Color(0xFFFF6B6B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${meal.calories.toInt()}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B6B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Macros
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildMacroChip(
                        "Protein",
                        meal.protein,
                        const Color(0xFF4ECDC4),
                        Icons.fitness_center,
                      ),
                      const SizedBox(width: 8),
                      _buildMacroChip(
                        "Carbs",
                        meal.carbs,
                        const Color(0xFFFFBE76),
                        Icons.grass,
                      ),
                      const SizedBox(width: 8),
                      _buildMacroChip(
                        "Fats",
                        meal.fats,
                        const Color(0xFF95E1D3),
                        Icons.water_drop,
                      ),
                    ],
                  ),
                  if (meal.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      "Ingredients:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: meal.ingredients.map((ingredient) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.inputBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            ingredient,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroChip(
    String label,
    double value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            "${value.toInt()}g",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  int _calculateNutritionScore(DayMealPlan dayPlan) {
    return NutritionScoreCalculator.calculateDailyScore(
      actualCalories: dayPlan.totalCalories,
      actualProtein: dayPlan.totalProtein,
      actualCarbs: dayPlan.totalCarbs,
      actualFats: dayPlan.totalFats,
      goalCalories: dailyCalorieGoal,
      goalProtein: dailyProteinGoal,
      goalCarbs: dailyCarbsGoal,
      goalFats: dailyFatsGoal,
    );
  }

  Color _getScoreColor(int score) {
    return NutritionScoreCalculator.getScoreColor(score);
  }

  Color _getMealTypeColor(String type) {
    switch (type) {
      case 'Breakfast':
        return const Color(0xFFFF6B6B);
      case 'Lunch':
        return const Color(0xFF4ECDC4);
      case 'Dinner':
        return const Color(0xFF95E1D3);
      case 'Snack':
        return const Color(0xFFFFBE76);
      default:
        return AppColors.primary;
    }
  }

  IconData _getMealTypeIcon(String type) {
    switch (type) {
      case 'Breakfast':
        return Icons.wb_sunny;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }
}
