# ✅ Nutrition Score Algorithm - Implementation Complete

**Date**: January 4, 2026  
**Status**: Fully Implemented (Frontend + Backend)

---

## 📦 What Was Implemented

### 1. **Flutter Utility Class** ✅
**Location**: `app/lib/core/utils/nutrition_score_calculator.dart`

A comprehensive Dart class with:
- ✅ Daily nutrition score calculation (0-100)
- ✅ Component-wise scoring (calories, protein, carbs, fats)
- ✅ Color coding based on score
- ✅ Category labels (Excellent, Great, Good, Fair, Poor)
- ✅ Emoji representations
- ✅ Detailed feedback generation
- ✅ Balance checking
- ✅ Weekly average calculations

### 2. **TypeScript Backend Class** ✅
**Location**: `server/src/utils/nutritionScoreCalculator.ts`

A parallel implementation for Node.js with:
- ✅ Same scoring algorithm as frontend
- ✅ TypeScript interfaces for type safety
- ✅ Nutrition goals calculator (BMR-based)
- ✅ Meal totals calculator
- ✅ Feedback system
- ✅ Balance validation

### 3. **API Integration Examples** ✅
**Location**: `server/src/examples/nutritionScoreExamples.ts`

Real-world usage examples including:
- ✅ Adding scores to existing diet plans
- ✅ Weekly average score calculation
- ✅ Daily feedback endpoints
- ✅ Diet plan generation with automatic scoring

### 4. **Meal Calendar Integration** ✅
**Updated**: `app/lib/features/diet_setup/presentation/screens/meal_calendar_screen.dart`

- ✅ Replaced manual calculation with utility class
- ✅ Consistent scoring across the app
- ✅ Cleaner, more maintainable code

---

## 🧮 The Algorithm

### Core Formula

For each nutrition component (calories, protein, carbs, fats):

```
Component Score = (1 - |actual - goal| / goal) × 25
Total Score = Sum of all component scores (max: 100)
```

### Example Calculation

**User Goals**:
- Calories: 2000 kcal
- Protein: 100g
- Carbs: 200g
- Fats: 65g

**Actual Intake**:
- Calories: 1850 kcal
- Protein: 95g
- Carbs: 185g
- Fats: 62g

**Calculation**:
```
Calorie Score = (1 - |1850 - 2000| / 2000) × 25
              = (1 - 150 / 2000) × 25
              = (1 - 0.075) × 25
              = 0.925 × 25
              = 23.125 → 23 points

Protein Score = (1 - |95 - 100| / 100) × 25
              = (1 - 5 / 100) × 25
              = 0.95 × 25
              = 23.75 → 24 points

Carbs Score = (1 - |185 - 200| / 200) × 25
            = (1 - 15 / 200) × 25
            = 0.925 × 25
            = 23.125 → 23 points

Fats Score = (1 - |62 - 65| / 65) × 25
           = (1 - 3 / 65) × 25
           = 0.954 × 25
           = 23.85 → 24 points

Total Score = 23 + 24 + 23 + 24 = 94/100 ⭐
Category: "Excellent"
Color: Green (#4CAF50)
```

---

## 🎨 Score Categories & Colors

| Score Range | Category | Color | Emoji | Meaning |
|-------------|----------|-------|-------|---------|
| 90-100 | Excellent | 🟢 Green | 🌟 | Perfect nutrition balance |
| 80-89 | Great | 🟢 Green | ⭐ | Very good, minor tweaks |
| 70-79 | Good | 🟡 Orange | 👍 | Solid, room for improvement |
| 60-69 | Fair | 🟡 Orange | 😊 | Decent, needs attention |
| 50-59 | Needs Work | 🔴 Red | 😐 | Requires adjustment |
| 0-49 | Poor | 🔴 Red | 😟 | Needs significant changes |

---

## 💡 Usage Examples

### Frontend (Flutter)

#### Basic Score Calculation
```dart
import 'package:app/core/utils/nutrition_score_calculator.dart';

// Calculate score
final score = NutritionScoreCalculator.calculateDailyScore(
  actualCalories: 1850,
  actualProtein: 95,
  actualCarbs: 185,
  actualFats: 62,
  goalCalories: 2000,
  goalProtein: 100,
  goalCarbs: 200,
  goalFats: 65,
);

print('Score: $score/100'); // Score: 94/100
```

#### Get Color & Category
```dart
final score = 85;
final color = NutritionScoreCalculator.getScoreColor(score);
final category = NutritionScoreCalculator.getScoreCategory(score);
final emoji = NutritionScoreCalculator.getScoreEmoji(score);

print('$emoji $category'); // ⭐ Great
```

#### Get Detailed Feedback
```dart
final feedback = NutritionScoreCalculator.getFeedback(
  actualCalories: 1850,
  actualProtein: 95,
  actualCarbs: 185,
  actualFats: 62,
  goalCalories: 2000,
  goalProtein: 100,
  goalCarbs: 200,
  goalFats: 65,
);

print(feedback.message);
// "Great job! Calorie intake is perfect, Protein intake is on target."

print(feedback.issues);    // []
print(feedback.strengths); // ["Calorie intake is perfect", ...]
print(feedback.isOptimal); // true
```

#### Check if Balanced
```dart
final isBalanced = NutritionScoreCalculator.isBalanced(
  actualProtein: 95,
  actualCarbs: 185,
  actualFats: 62,
  goalProtein: 100,
  goalCarbs: 200,
  goalFats: 65,
  threshold: 0.15, // 15% deviation allowed
);

print('Balanced: $isBalanced'); // true
```

#### Weekly Average
```dart
final dailyScores = [94, 87, 91, 88, 85, 79, 82];
final weeklyAvg = NutritionScoreCalculator.calculateWeeklyAverageScore(dailyScores);

print('Weekly Average: $weeklyAvg'); // 86
```

---

### Backend (TypeScript)

#### Basic Score Calculation
```typescript
import NutritionScoreCalculator from './utils/nutritionScoreCalculator';

const actual = {
  calories: 1850,
  protein: 95,
  carbs: 185,
  fats: 62
};

const goals = {
  calories: 2000,
  protein: 100,
  carbs: 200,
  fats: 65
};

const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);

console.log(scoreData);
/*
{
  totalScore: 94,
  calorieScore: 23,
  proteinScore: 24,
  carbsScore: 23,
  fatsScore: 24,
  category: 'Excellent',
  color: '#4CAF50',
  emoji: '🌟'
}
*/
```

#### Calculate from Meals
```typescript
const meals = [
  { calories: 350, protein: 28, carbs: 12, fats: 22 },  // Breakfast
  { calories: 450, protein: 42, carbs: 35, fats: 18 },  // Lunch
  { calories: 520, protein: 20, carbs: 68, fats: 18 },  // Dinner
  { calories: 180, protein: 15, carbs: 22, fats: 4 }   // Snack
];

const totals = NutritionScoreCalculator.calculateTotalsFromMeals(meals);
// { calories: 1500, protein: 105, carbs: 137, fats: 62 }
```

#### Get Recommended Goals
```typescript
const goals = NutritionScoreCalculator.getRecommendedGoals(
  25,          // age
  70,          // weight in kg
  175,         // height in cm
  'moderate',  // activity level
  'maintain'   // goal
);

console.log(goals);
// { calories: 2325, protein: 174, carbs: 232, fats: 77 }
```

#### Get Feedback
```typescript
const feedback = NutritionScoreCalculator.getFeedback(actual, goals);

console.log(feedback.message);
console.log(feedback.issues);     // Array of problems
console.log(feedback.strengths);  // Array of positives
console.log(feedback.isOptimal);  // boolean
```

---

## 📊 Integration Points

### 1. **Meal Calendar Screen**
The meal calendar now uses the calculator to:
- Display daily nutrition scores
- Show color-coded indicators
- Provide score-based visual feedback

### 2. **Diet Plan Summary**
Can add score display to show:
- Overall plan quality
- Daily breakdown
- Weekly trends

### 3. **Home Dashboard**
Potential uses:
- Today's nutrition score widget
- Weekly progress chart
- Streak tracking (consecutive high scores)

### 4. **API Endpoints**
Backend can now:
- Calculate scores on plan generation
- Validate nutrition balance
- Provide real-time feedback
- Track user progress over time

---

## 🔧 Customization Options

### Adjusting Component Weights

Currently, each component is worth 25 points. You can customize:

```dart
// Give protein more weight (40%), reduce carbs (20%)
static int calculateCustomScore({
  required double actualProtein,
  required double actualCarbs,
  // ... other params
}) {
  final proteinScore = _calculateComponentScore(
    actual: actualProtein,
    goal: goalProtein,
    maxPoints: 40, // Increased from 25
  );
  
  final carbsScore = _calculateComponentScore(
    actual: actualCarbs,
    goal: goalCarbs,
    maxPoints: 20, // Decreased from 25
  );
  
  // ... calculate other scores
}
```

### Adjusting Score Ranges

```dart
static Color getScoreColor(int score) {
  if (score >= 85) return Colors.green;  // Stricter
  if (score >= 70) return Colors.orange;
  return Colors.red;
}
```

### Adding Micronutrients

```dart
static int calculateEnhancedScore({
  // ... existing macros
  required double actualFiber,
  required double goalFiber,
  required double actualVitaminC,
  required double goalVitaminC,
}) {
  // Each component worth 16.67 points (6 components)
  final macroScore = /* existing calculation */ * 0.75; // 75% weight
  final microScore = /* fiber + vitamins */ * 0.25;     // 25% weight
  
  return (macroScore + microScore).round();
}
```

---

## 📈 Future Enhancements

### Phase 1: Advanced Scoring
- [ ] Meal timing penalties/bonuses
- [ ] Hydration score component
- [ ] Sleep impact on nutrition needs
- [ ] Micronutrient tracking

### Phase 2: Personalization
- [ ] User-specific weight adjustments
- [ ] Goal-based scoring (weight loss vs muscle gain)
- [ ] Age/gender-specific scoring
- [ ] Medical condition adjustments

### Phase 3: Gamification
- [ ] Streak tracking (consecutive high scores)
- [ ] Achievements/badges
- [ ] Leaderboards
- [ ] Daily challenges

### Phase 4: AI Integration
- [ ] Predictive scoring
- [ ] Smart recommendations
- [ ] Pattern recognition
- [ ] Personalized feedback

---

## 🧪 Testing

### Test Cases to Verify

1. **Perfect Score (100)**
   ```dart
   score = calculateDailyScore(
     actualCalories: 2000, goalCalories: 2000,
     actualProtein: 100, goalProtein: 100,
     actualCarbs: 200, goalCarbs: 200,
     actualFats: 65, goalFats: 65,
   );
   // Expected: 100
   ```

2. **Zero Score (0)**
   ```dart
   score = calculateDailyScore(
     actualCalories: 4000, goalCalories: 2000,
     actualProtein: 200, goalProtein: 100,
     actualCarbs: 400, goalCarbs: 200,
     actualFats: 130, goalFats: 65,
   );
   // Expected: 0 or very low
   ```

3. **Partial Scores**
   - 50% deviation should give ~12-13 points per component

---

## 📝 Notes & Best Practices

1. **Consistency**: Always use the same goals throughout a day
2. **Validation**: Ensure goals are never 0 or negative
3. **Rounding**: Scores are always integers (0-100)
4. **Clamping**: Scores cannot go below 0 or above 100
5. **Deviation**: Algorithm handles both over and under consumption equally

---

## ✅ Checklist

- [x] Implement Flutter utility class
- [x] Implement TypeScript backend class
- [x] Update meal calendar to use utility
- [x] Create API integration examples
- [x] Add color coding system
- [x] Add feedback generation
- [x] Add balance checking
- [x] Add weekly averaging
- [x] Add BMR-based goal calculator
- [x] Document algorithm thoroughly
- [ ] Add unit tests (frontend)
- [ ] Add unit tests (backend)
- [ ] Add to API documentation
- [ ] Create user-facing documentation

---

**Implementation Status**: ✅ COMPLETE  
**Ready for Use**: YES  
**Documented**: YES  
**Tested**: Pending unit tests

🎉 The Nutrition Score Algorithm is now fully implemented and ready to use!
