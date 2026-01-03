import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'habits_screen.dart';

class PersonalStatsScreen extends StatefulWidget {
  const PersonalStatsScreen({super.key});

  @override
  State<PersonalStatsScreen> createState() => _PersonalStatsScreenState();
}

class _PersonalStatsScreenState extends State<PersonalStatsScreen> {
  int _currentStep = 0;

  // Data holders
  double _age = 25;
  double _weight = 60;
  double _height = 165;

  final int _totalSteps = 3;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    } else {
      // Finish Flow
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HabitsScreen()),
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation with Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _prevStep,
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_currentStep + 1) / _totalSteps,
                        backgroundColor: AppColors.inputBackground,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance spacing
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.2, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                  child: _buildStepContent(),
                ),
              ),
            ),

            // Bottom Action
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _currentStep == _totalSteps - 1 ? "Next" : "Continue",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStatSelector(
          key: const ValueKey(0),
          title: "How old are you?",
          value: _age,
          unit: "Years",
          min: 10,
          max: 90,
          onChanged: (val) => setState(() => _age = val),
        );
      case 1:
        return _buildStatSelector(
          key: const ValueKey(1),
          title: "What is your weight?",
          value: _weight,
          unit: "kg",
          min: 30,
          max: 150,
          onChanged: (val) => setState(() => _weight = val),
        );
      case 2:
        return _buildStatSelector(
          key: const ValueKey(2),
          title: "What is your height?",
          value: _height,
          unit: "cm",
          min: 100,
          max: 220,
          onChanged: (val) => setState(() => _height = val),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStatSelector({
    required Key key,
    required String title,
    required double value,
    required String unit,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      key: key,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 60),

        // Circular or Big Display
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: AppColors.inputBackground),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),

        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.inputBackground,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withOpacity(0.2),
            trackHeight: 8,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
