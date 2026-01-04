# 📅 Meal Planning Calendar Feature

## Overview
The Meal Planning Calendar is an interactive weekly meal planner that shows each day's complete meal plan with accurate nutrition values. Users can easily navigate through the week and see detailed breakdowns of every meal.

---

## ✨ Key Features

### 1. **Weekly Calendar View**
- **Interactive Day Selection**: Tap any day to view detailed meal information
- **Visual Indicators**: Each day shows a color-coded dot indicating nutrition score
  - 🟢 Green (80-100): Excellent nutrition balance
  - 🟡 Yellow (60-79): Good, room for improvement
  - 🔴 Red (0-59): Needs attention
- **Current Day Highlight**: Selected day is highlighted in primary color

### 2. **Daily Nutrition Summary**
Each day displays:
- **Nutrition Score**: 0-100 score based on how well meals meet daily goals
- **Total Calories**: Compared to daily goal (default: 2000 kcal)
- **Macronutrients**:
  - 💪 Protein (goal: 100g)
  - 🌾 Carbs (goal: 200g)
  - 💧 Fats (goal: 65g)
- **Progress Bars**: Visual representation of goal achievement
- **Percentage**: Shows % of daily goal achieved

### 3. **Detailed Meal Cards**
Each meal card shows:
- **Meal Type**: Breakfast, Lunch, Dinner, or Snack with unique colors
- **Meal Name**: Descriptive recipe name
- **Calorie Count**: Prominent calorie display with fire icon
- **Macro Breakdown**: Protein, Carbs, Fats in colored chips
- **Ingredients List**: All ingredients used in the meal

### 4. **Meal Type Color Coding**
- 🌅 **Breakfast**: Red (#FF6B6B) with sun icon
- 🍽️ **Lunch**: Teal (#4ECDC4) with lunch icon
- 🌙 **Dinner**: Mint (#95E1D3) with dinner icon
- 🍪 **Snack**: Orange (#FFBE76) with cookie icon

---

## 📱 User Flow

```
Home Screen
    ↓
Tap "Your Smart Diet Plan" Card
    ↓
Diet Plan Summary Screen
    ↓
Tap "📅 View Meal Calendar" Button
    ↓
Meal Planning Calendar
    ├→ Select Day from Calendar
    ├→ View Nutrition Summary
    └→ Scroll Through Meal Details
```

---

## 🎨 Design Highlights

### Header
- Clean purple gradient header
- Back button for navigation
- Calendar icon for future month view
- "AI Generated Weekly Plan" badge

### Calendar Strip
- Horizontal week view
- Each day shows:
  - 3-letter day name (Mon, Tue, Wed)
  - Date number
  - Nutrition score indicator dot
- Selected day has purple background

### Nutrition Summary Card
- Gradient background based on score color
- Score badge (star icon + score/100)
- 4 progress bars for macronutrients
- Icons for each nutrient type

### Meal Cards
- White cards with subtle shadows
- Colored header based on meal type
- Macro chips with icons
- Ingredient tags in gray background

---

## 📊 Data Structure

### DayMealPlan Model
```dart
class DayMealPlan {
  final String day;                // "Monday"
  final DateTime date;             // Actual date
  final List<Meal> meals;          // List of meals
  final double totalCalories;      // Sum of all meals
  final double totalProtein;       // Sum of protein (g)
  final double totalCarbs;         // Sum of carbs (g)
  final double totalFats;          // Sum of fats (g)
}
```

### Meal Model
```dart
class Meal {
  final String type;               // "Breakfast" | "Lunch" | "Dinner" | "Snack"
  final String name;               // "Spinach & Egg Omelet"
  final double calories;           // 350
  final double protein;            // 28g
  final double carbs;              // 12g
  final double fats;               // 22g
  final List<String> ingredients;  // ["Eggs", "Spinach", "Cheese"]
}
```

---

## 🔧 Integration with Backend

### Current Implementation
- Uses **hardcoded sample data** for demonstration
- 7 days of pre-filled meal plans

### To Connect with API:
Replace the `_weekPlan` list with data from your backend:

```dart
// Instead of hardcoded data
final List<DayMealPlan> _weekPlan = [];

// Use FutureBuilder or state management
Future<void> loadWeeklyPlan() async {
  final response = await http.get('/api/diet-plans/weekly');
  final data = jsonDecode(response.body);
  
  setState(() {
    _weekPlan = (data['weeklyPlan'] as List)
        .map((day) => DayMealPlan(
          day: day['day'],
          date: DateTime.parse(day['date']),
          meals: (day['meals'] as List)
              .map((meal) => Meal(
                type: meal['type'],
                name: meal['name'],
                calories: meal['calories'].toDouble(),
                protein: meal['protein'].toDouble(),
                carbs: meal['carbs'].toDouble(),
                fats: meal['fats'].toDouble(),
                ingredients: List<String>.from(meal['ingredientsUsed']),
              ))
              .toList(),
          totalCalories: day['totalCalories'],
          totalProtein: day['totalProtein'],
          totalCarbs: day['totalCarbs'],
          totalFats: day['totalFats'],
        ))
        .toList();
  });
}
```

### Backend Updates Needed

Add these fields to your DietPlan model:
```typescript
weeklyPlan: [{
  day: String,           // "Monday"
  date: Date,            // ISO date string
  totalCalories: Number,
  totalProtein: Number,
  totalCarbs: Number,
  totalFats: Number,
  meals: [{
    type: String,
    name: String,
    calories: Number,
    protein: Number,
    carbs: Number,
    fats: Number,
    ingredientsUsed: [String],
  }]
}]
```

---

## 🎯 Nutrition Score Algorithm

The score is calculated based on how close each day's nutrition is to daily goals:

```dart
Calorie Score = (1 - |actual - goal| / goal) * 25  (max: 25 points)
Protein Score = (1 - |actual - goal| / goal) * 25  (max: 25 points)
Carbs Score   = (1 - |actual - goal| / goal) * 25  (max: 25 points)
Fats Score    = (1 - |actual - goal| / goal) * 25  (max: 25 points)

Total Score = Sum of all scores (max: 100 points)
```

**Color Coding:**
- **80-100**: 🟢 Excellent - Green
- **60-79**: 🟡 Good - Yellow/Orange
- **0-59**: 🔴 Needs Work - Red

---

## 🚀 Future Enhancements

### Phase 1: Interactivity
- [ ] Mark meals as "Completed" with checkmarks
- [ ] Log actual food consumed vs planned
- [ ] Adjust portion sizes with +/- buttons

### Phase 2: Customization
- [ ] Drag-and-drop to rearrange meals
- [ ] Swap meals between days
- [ ] Replace individual meals with alternatives

### Phase 3: Smart Features
- [ ] AI meal suggestions based on missing nutrients
- [ ] "What can I make today?" based on pantry items
- [ ] Shopping list generation for the week
- [ ] Recipe details with cooking instructions

### Phase 4: Social
- [ ] Share weekly plan with friends
- [ ] Export as PDF
- [ ] Print-friendly view

### Phase 5: Analytics
- [ ] Week-over-week nutrition comparison
- [ ] Monthly pattern analysis
- [ ] "Best week" achievements

---

## 📸 Screenshot Walkthrough

### Screen 1: Calendar View
```
┌─────────────────────────────────────┐
│  ← Meal Planning Calendar      📅   │
│  [AI Generated Weekly Plan]         │
├─────────────────────────────────────┤
│  Mon Tue Wed Thu Fri Sat Sun        │
│   4   5   6   7   8   9  10         │
│   🟢  🟡  🟢  🟢  🔴  🟡  🟢         │
│  (Day selector - Mon selected)      │
└─────────────────────────────────────┘
```

### Screen 2: Daily Summary
```
┌─────────────────────────────────────┐
│  Monday               ⭐ 85/100      │
│  4 meals planned                    │
├─────────────────────────────────────┤
│  🔥 Calories  ▓▓▓▓▓▓▓▓░░ 1850/2000  │
│  💪 Protein   ▓▓▓▓▓▓▓▓▓░  95/100g   │
│  🌾 Carbs     ▓▓▓▓▓▓▓▓░░ 185/200g   │
│  💧 Fats      ▓▓▓▓▓▓▓▓░░  62/65g    │
└─────────────────────────────────────┘
```

### Screen 3: Meal Card
```
┌─────────────────────────────────────┐
│ 🌅 Breakfast                   350🔥│
│ Spinach & Egg Omelet               │
├─────────────────────────────────────┤
│ 💪28g  🌾12g  💧22g                 │
│                                     │
│ Ingredients:                        │
│ [Eggs] [Spinach] [Cheese]          │
└─────────────────────────────────────┘
```

---

## ✅ Testing Checklist

- [x] Calendar day selection works
- [x] PageView swipe navigation works
- [x] Nutrition calculations are accurate
- [x] Score color coding is correct
- [x] All meal types display correctly
- [ ] Data loads from API (pending)
- [ ] Empty states handled (pending)
- [ ] Error states handled (pending)
- [ ] Loading states implemented (pending)

---

## 🎉 Benefits for Users

1. **Clear Visualization**: See the whole week at a glance
2. **Goal Tracking**: Know exactly where you stand on nutrition
3. **Planning Ahead**: No more "what should I eat?" moments
4. **Motivation**: Daily scores gamify healthy eating
5. **Transparency**: Full ingredient and macro information
6. **Flexibility**: Easy to navigate and explore options

---

## 📝 Developer Notes

### File Location
```
app/lib/features/diet_setup/presentation/screens/meal_calendar_screen.dart
```

### Dependencies
- flutter/material.dart
- app_colors.dart (from theme)

### State Management
- Currently using StatefulWidget
- Consider migrating to Provider/Riverpod for API integration

### Performance
- PageView is lazy-loaded
- Only 7 days cached (one week)
- Consider pagination for monthly views

---

**Created**: January 4, 2026  
**Status**: ✅ Implemented (Sample Data)  
**Next Step**: Connect to backend API for real meal plan data
