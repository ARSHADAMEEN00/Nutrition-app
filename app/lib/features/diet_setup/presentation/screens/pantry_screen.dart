import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'diet_plan_summary_screen.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final TextEditingController _dietController = TextEditingController();
  final TextEditingController _pantryController = TextEditingController();
  final List<String> _pantryItems = [];

  void _addItem() {
    final text = _pantryController.text.trim();
    if (text.isNotEmpty && !_pantryItems.contains(text)) {
      setState(() {
        _pantryItems.add(text);
        _pantryController.clear();
      });
    }
  }

  void _removeItem(String item) {
    setState(() {
      _pantryItems.remove(item);
    });
  }

  void _finishSetup() {
    // Navigate back home or show creating plan loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating your personalized plan...')),
    );
    // Simulate AI delay then go to summary
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DietPlanSummaryScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Food & Pantry",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What do you usually eat?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _dietController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            "E.g., I like spicy food, I skip breakfast...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      "What's in your kitchen?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Add ingredients you have available so we can suggest recipes.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Add Item Input
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pantryController,
                            onSubmitted: (_) => _addItem(),
                            decoration: InputDecoration(
                              hintText: "Add item (e.g. Eggs)",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: _addItem,
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.all(12),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Chips Grid
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _pantryItems.map((item) {
                        return Chip(
                          label: Text(item),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          labelStyle: const TextStyle(
                            color: AppColors.primaryDark,
                          ),
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.primaryDark,
                          ),
                          onDeleted: () => _removeItem(item),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _finishSetup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Generate My Plan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
