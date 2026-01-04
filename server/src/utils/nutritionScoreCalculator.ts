/**
 * Nutrition Score Calculator
 * 
 * Calculates nutrition scores (0-100) based on how well daily intake
 * meets recommended goals. Used for gamification and progress tracking.
 */

export interface NutritionGoals {
    calories: number;
    protein: number;  // grams
    carbs: number;    // grams
    fats: number;     // grams
}

export interface NutritionActual {
    calories: number;
    protein: number;  // grams
    carbs: number;    // grams
    fats: number;     // grams
}

export interface NutritionScore {
    totalScore: number;
    calorieScore: number;
    proteinScore: number;
    carbsScore: number;
    fatsScore: number;
    category: string;
    color: string;
    emoji: string;
}

export interface NutritionFeedback {
    issues: string[];
    strengths: string[];
    message: string;
    isOptimal: boolean;
    deviations: {
        calories: number;
        protein: number;
        carbs: number;
        fats: number;
    };
}

export class NutritionScoreCalculator {
    /**
     * Calculate overall nutrition score for a day
     * 
     * @param actual - Actual nutrition intake
     * @param goals - Target nutrition goals
     * @returns Nutrition score object with breakdown
     */
    static calculateDailyScore(
        actual: NutritionActual,
        goals: NutritionGoals
    ): NutritionScore {
        const calorieScore = this.calculateComponentScore(
            actual.calories,
            goals.calories,
            25
        );

        const proteinScore = this.calculateComponentScore(
            actual.protein,
            goals.protein,
            25
        );

        const carbsScore = this.calculateComponentScore(
            actual.carbs,
            goals.carbs,
            25
        );

        const fatsScore = this.calculateComponentScore(
            actual.fats,
            goals.fats,
            25
        );

        const totalScore = Math.round(
            Math.max(0, Math.min(100, calorieScore + proteinScore + carbsScore + fatsScore))
        );

        return {
            totalScore,
            calorieScore: Math.round(calorieScore),
            proteinScore: Math.round(proteinScore),
            carbsScore: Math.round(carbsScore),
            fatsScore: Math.round(fatsScore),
            category: this.getScoreCategory(totalScore),
            color: this.getScoreColor(totalScore),
            emoji: this.getScoreEmoji(totalScore)
        };
    }

    /**
     * Calculate score for a single nutrition component
     * 
     * Uses deviation from goal to determine points.
     * 0% deviation = full points, 100% deviation = 0 points
     * 
     * @param actual - Actual value
     * @param goal - Target goal
     * @param maxPoints - Maximum points for this component
     * @returns Score for this component
     */
    private static calculateComponentScore(
        actual: number,
        goal: number,
        maxPoints: number
    ): number {
        if (goal <= 0) return 0;

        // Calculate percentage deviation from goal
        const deviation = Math.abs(actual - goal) / goal;

        // Convert to score (inverse relationship)
        // 0% deviation = maxPoints, 100% deviation = 0
        const score = (1 - deviation) * maxPoints;

        return Math.max(0, Math.min(maxPoints, score));
    }

    /**
     * Get color code based on nutrition score
     * 
     * @param score - Nutrition score (0-100)
     * @returns Hex color code
     */
    static getScoreColor(score: number): string {
        if (score >= 80) return '#4CAF50';  // Green - Excellent
        if (score >= 60) return '#FFBE76';  // Orange - Good
        return '#FF6B6B';                    // Red - Needs Work
    }

    /**
     * Get score category label
     * 
     * @param score - Nutrition score (0-100)
     * @returns Category label
     */
    static getScoreCategory(score: number): string {
        if (score >= 90) return 'Excellent';
        if (score >= 80) return 'Great';
        if (score >= 70) return 'Good';
        if (score >= 60) return 'Fair';
        if (score >= 50) return 'Needs Work';
        return 'Poor';
    }

    /**
     * Get score emoji
     * 
     * @param score - Nutrition score (0-100)
     * @returns Emoji representation
     */
    static getScoreEmoji(score: number): string {
        if (score >= 90) return '🌟';
        if (score >= 80) return '⭐';
        if (score >= 70) return '👍';
        if (score >= 60) return '😊';
        if (score >= 50) return '😐';
        return '😟';
    }

    /**
     * Get detailed feedback based on nutrition intake
     * 
     * @param actual - Actual nutrition intake
     * @param goals - Target nutrition goals
     * @returns Detailed feedback object
     */
    static getFeedback(
        actual: NutritionActual,
        goals: NutritionGoals
    ): NutritionFeedback {
        const calorieDeviation = this.getDeviationPercentage(actual.calories, goals.calories);
        const proteinDeviation = this.getDeviationPercentage(actual.protein, goals.protein);
        const carbsDeviation = this.getDeviationPercentage(actual.carbs, goals.carbs);
        const fatsDeviation = this.getDeviationPercentage(actual.fats, goals.fats);

        const issues: string[] = [];
        const strengths: string[] = [];

        // Check calories
        if (Math.abs(calorieDeviation) < 0.1) {
            strengths.push('Calorie intake is perfect');
        } else if (calorieDeviation > 0.2) {
            issues.push('Consuming too many calories');
        } else if (calorieDeviation < -0.2) {
            issues.push('Not eating enough calories');
        }

        // Check protein
        if (Math.abs(proteinDeviation) < 0.1) {
            strengths.push('Protein intake is on target');
        } else if (proteinDeviation < -0.15) {
            issues.push('Need more protein');
        } else if (proteinDeviation > 0.2) {
            issues.push('Too much protein');
        }

        // Check carbs
        if (Math.abs(carbsDeviation) < 0.1) {
            strengths.push('Carb intake is balanced');
        } else if (carbsDeviation > 0.2) {
            issues.push('Too many carbs');
        } else if (carbsDeviation < -0.15) {
            issues.push('Need more carbs for energy');
        }

        // Check fats
        if (Math.abs(fatsDeviation) < 0.1) {
            strengths.push('Healthy fat intake');
        } else if (fatsDeviation < -0.15) {
            issues.push('Need more healthy fats');
        } else if (fatsDeviation > 0.2) {
            issues.push('Too many fats');
        }

        // Generate message
        let message = '';
        if (issues.length === 0 && strengths.length > 0) {
            message = `Great job! ${strengths.join(', ')}.`;
        } else if (issues.length > 0) {
            message = `${issues.join(', ')}. ${strengths.length > 0 ? strengths[0] : ''}`;
        } else {
            message = 'Keep up the good work!';
        }

        return {
            issues,
            strengths,
            message,
            isOptimal: issues.length === 0,
            deviations: {
                calories: calorieDeviation,
                protein: proteinDeviation,
                carbs: carbsDeviation,
                fats: fatsDeviation
            }
        };
    }

    /**
     * Calculate deviation percentage
     * 
     * @param actual - Actual value
     * @param goal - Target goal
     * @returns Deviation as decimal (-1 to 1, where 0 is perfect)
     */
    private static getDeviationPercentage(actual: number, goal: number): number {
        if (goal <= 0) return 0;
        return (actual - goal) / goal;
    }

    /**
     * Calculate weekly average score
     * 
     * @param dailyScores - Array of daily scores
     * @returns Average score
     */
    static calculateWeeklyAverageScore(dailyScores: number[]): number {
        if (dailyScores.length === 0) return 0;
        const sum = dailyScores.reduce((a, b) => a + b, 0);
        return Math.round(sum / dailyScores.length);
    }

    /**
     * Check if nutrition is balanced (all macros close to target)
     * 
     * @param actual - Actual nutrition intake
     * @param goals - Target nutrition goals
     * @param threshold - Allowed deviation (default: 0.15 = 15%)
     * @returns True if balanced
     */
    static isBalanced(
        actual: NutritionActual,
        goals: NutritionGoals,
        threshold: number = 0.15
    ): boolean {
        const proteinDeviation = Math.abs(this.getDeviationPercentage(actual.protein, goals.protein));
        const carbsDeviation = Math.abs(this.getDeviationPercentage(actual.carbs, goals.carbs));
        const fatsDeviation = Math.abs(this.getDeviationPercentage(actual.fats, goals.fats));

        return proteinDeviation < threshold &&
            carbsDeviation < threshold &&
            fatsDeviation < threshold;
    }

    /**
     * Calculate nutrition totals from meals
     * 
     * @param meals - Array of meals with nutrition data
     * @returns Total nutrition
     */
    static calculateTotalsFromMeals(meals: Array<{
        calories: number;
        protein: number;
        carbs: number;
        fats: number;
    }>): NutritionActual {
        return meals.reduce(
            (totals, meal) => ({
                calories: totals.calories + meal.calories,
                protein: totals.protein + meal.protein,
                carbs: totals.carbs + meal.carbs,
                fats: totals.fats + meal.fats
            }),
            { calories: 0, protein: 0, carbs: 0, fats: 0 }
        );
    }

    /**
     * Get recommended goals based on user profile
     * 
     * @param age - User age
     * @param weight - User weight in kg
     * @param height - User height in cm
     * @param activityLevel - Activity level ('sedentary' | 'light' | 'moderate' | 'active' | 'very_active')
     * @param goal - User goal ('maintain' | 'lose' | 'gain')
     * @returns Recommended nutrition goals
     */
    static getRecommendedGoals(
        age: number,
        weight: number,
        height: number,
        activityLevel: string,
        goal: string
    ): NutritionGoals {
        // Simplified BMR calculation (Mifflin-St Jeor)
        // For more accuracy, consider gender
        const bmr = 10 * weight + 6.25 * height - 5 * age + 5;

        // Activity multipliers
        const activityMultipliers: { [key: string]: number } = {
            sedentary: 1.2,
            light: 1.375,
            moderate: 1.55,
            active: 1.725,
            very_active: 1.9
        };

        const multiplier = activityMultipliers[activityLevel] || 1.55;
        let tdee = bmr * multiplier;

        // Adjust for goal
        if (goal === 'lose') tdee -= 500;  // 500 cal deficit
        if (goal === 'gain') tdee += 300;  // 300 cal surplus

        // Macro ratios (protein: 30%, carbs: 40%, fats: 30%)
        const protein = (tdee * 0.30) / 4;  // 4 cal per gram
        const carbs = (tdee * 0.40) / 4;    // 4 cal per gram
        const fats = (tdee * 0.30) / 9;     // 9 cal per gram

        return {
            calories: Math.round(tdee),
            protein: Math.round(protein),
            carbs: Math.round(carbs),
            fats: Math.round(fats)
        };
    }
}

export default NutritionScoreCalculator;
