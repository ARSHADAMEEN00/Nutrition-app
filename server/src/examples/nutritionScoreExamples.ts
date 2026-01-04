import { Request, Response } from 'express';
import DietPlan from '../models/DietPlan';
import NutritionScoreCalculator from '../utils/nutritionScoreCalculator';

/**
 * Example: Calculate nutrition score for a diet plan
 * 
 * This demonstrates how to use the NutritionScoreCalculator
 * in your diet plan endpoints
 */
export class DietPlanScoreExamples {
    /**
     * Add nutrition scores to weekly plan
     * 
     * Calculates and adds score for each day in the plan
     */
    static async addNutritionScoresToPlan(dietPlanId: string) {
        const dietPlan = await DietPlan.findById(dietPlanId);
        if (!dietPlan) throw new Error('Diet plan not found');

        // Get user's nutrition goals (from user profile or calculated)
        const goals = {
            calories: 2000,
            protein: 100,
            carbs: 200,
            fats: 65
        };

        // Calculate score for each day
        dietPlan.weeklyPlan = dietPlan.weeklyPlan.map((day) => {
            // Calculate totals from meals
            const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);

            // Calculate nutrition score
            const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);

            // Get feedback
            const feedback = NutritionScoreCalculator.getFeedback(actual, goals);

            return {
                ...day.toObject(),
                totalCalories: actual.calories,
                totalProtein: actual.protein,
                totalCarbs: actual.carbs,
                totalFats: actual.fats,
                nutritionScore: scoreData.totalScore,
                scoreCategory: scoreData.category,
                scoreColor: scoreData.color,
                scoreEmoji: scoreData.emoji,
                feedback: feedback.message,
                issues: feedback.issues,
                strengths: feedback.strengths
            };
        });

        await dietPlan.save();
        return dietPlan;
    }

    /**
     * Get weekly average score
     */
    static async getWeeklyAverageScore(dietPlanId: string) {
        const dietPlan = await DietPlan.findById(dietPlanId);
        if (!dietPlan) throw new Error('Diet plan not found');

        const dailyScores = dietPlan.weeklyPlan.map((day: any) => {
            const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);
            const goals = { calories: 2000, protein: 100, carbs: 200, fats: 65 };
            const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);
            return scoreData.totalScore;
        });

        return NutritionScoreCalculator.calculateWeeklyAverageScore(dailyScores);
    }

    /**
     * Check if a day's nutrition is balanced
     */
    static async checkDayBalance(dietPlanId: string, dayIndex: number) {
        const dietPlan = await DietPlan.findById(dietPlanId);
        if (!dietPlan) throw new Error('Diet plan not found');

        const day = dietPlan.weeklyPlan[dayIndex];
        const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);
        const goals = { calories: 2000, protein: 100, carbs: 200, fats: 65 };

        return NutritionScoreCalculator.isBalanced(actual, goals);
    }

    /**
     * Get recommended goals for a user
     */
    static getGoalsForUser(userId: any, user: any) {
        // User profile should have: age, weight, height, activityLevel, goal
        return NutritionScoreCalculator.getRecommendedGoals(
            user.personal_data.age,
            user.personal_data.weight,
            user.personal_data.height,
            user.health_data.activity_level,
            user.health_data.goals[0] || 'maintain'
        );
    }
}

/**
 * API Endpoint Example: Get diet plan with scores
 */
export const getDietPlanWithScores = async (req: Request, res: Response) => {
    try {
        const { planId } = req.params;
        const dietPlan = await DietPlan.findById(planId);

        if (!dietPlan) {
            return res.status(404).json({ error: 'Diet plan not found' });
        }

        // Get goals (in real app, get from user profile)
        const goals = {
            calories: 2000,
            protein: 100,
            carbs: 200,
            fats: 65
        };

        // Enhance each day with nutrition scores
        const enhancedWeeklyPlan = dietPlan.weeklyPlan.map((day: any) => {
            const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);
            const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);
            const feedback = NutritionScoreCalculator.getFeedback(actual, goals);

            return {
                day: day.day,
                date: day.date || new Date(), // Add date if not present
                meals: day.meals,
                totalCalories: actual.calories,
                totalProtein: actual.protein,
                totalCarbs: actual.carbs,
                totalFats: actual.fats,
                nutritionScore: scoreData.totalScore,
                calorieScore: scoreData.calorieScore,
                proteinScore: scoreData.proteinScore,
                carbsScore: scoreData.carbsScore,
                fatsScore: scoreData.fatsScore,
                category: scoreData.category,
                color: scoreData.color,
                emoji: scoreData.emoji,
                feedback: feedback.message,
                issues: feedback.issues,
                strengths: feedback.strengths,
                isOptimal: feedback.isOptimal
            };
        });

        // Calculate weekly average
        const dailyScores = enhancedWeeklyPlan.map((day: any) => day.nutritionScore);
        const weeklyAverage = NutritionScoreCalculator.calculateWeeklyAverageScore(dailyScores);

        res.json({
            success: true,
            data: {
                ...dietPlan.toObject(),
                weeklyPlan: enhancedWeeklyPlan,
                weeklyAverageScore: weeklyAverage,
                goals: goals
            }
        });
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * API Endpoint Example: Get daily nutrition feedback
 */
export const getDailyFeedback = async (req: Request, res: Response) => {
    try {
        const { planId, dayIndex } = req.params;
        const dietPlan = await DietPlan.findById(planId);

        if (!dietPlan) {
            return res.status(404).json({ error: 'Diet plan not found' });
        }

        const day = dietPlan.weeklyPlan[parseInt(dayIndex)];
        if (!day) {
            return res.status(404).json({ error: 'Day not found' });
        }

        const goals = {
            calories: 2000,
            protein: 100,
            carbs: 200,
            fats: 65
        };

        const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);
        const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);
        const feedback = NutritionScoreCalculator.getFeedback(actual, goals);

        res.json({
            success: true,
            data: {
                day: day.day,
                score: scoreData,
                feedback: feedback,
                actual: actual,
                goals: goals,
                isBalanced: NutritionScoreCalculator.isBalanced(actual, goals)
            }
        });
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
};

/**
 * Usage in diet plan generation:
 * 
 * When AI generates a meal plan, immediately calculate scores:
 */
export const generateDietPlanWithScores = async (req: Request, res: Response) => {
    try {
        const { userId, inputs } = req.body;

        // 1. Generate plan (using AI - simplified here)
        const generatedPlan = {
            weeklyPlan: [
                {
                    day: 'Monday',
                    date: new Date(),
                    meals: [
                        {
                            type: 'Breakfast',
                            name: 'Spinach & Egg Omelet',
                            calories: 350,
                            protein: 28,
                            carbs: 12,
                            fats: 22,
                            ingredientsUsed: ['Eggs', 'Spinach']
                        },
                        // ... more meals
                    ]
                },
                // ... more days
            ]
        };

        // 2. Get user's nutrition goals
        const goals = NutritionScoreCalculator.getRecommendedGoals(
            inputs.age,
            inputs.weight,
            inputs.height,
            inputs.activityLevel,
            inputs.goal || 'maintain'
        );

        // 3. Calculate scores for validation
        const enhancedPlan = generatedPlan.weeklyPlan.map((day: any) => {
            const actual = NutritionScoreCalculator.calculateTotalsFromMeals(day.meals);
            const scoreData = NutritionScoreCalculator.calculateDailyScore(actual, goals);
            const feedback = NutritionScoreCalculator.getFeedback(actual, goals);

            return {
                ...day,
                totalCalories: actual.calories,
                totalProtein: actual.protein,
                totalCarbs: actual.carbs,
                totalFats: actual.fats,
                score: scoreData.totalScore,
                feedback: feedback.message
            };
        });

        // 4. Save to database
        const dietPlan = new DietPlan({
            userId,
            inputs,
            weeklyPlan: enhancedPlan,
            analysis: {
                missingNutrients: [],
                healthScore: NutritionScoreCalculator.calculateWeeklyAverageScore(
                    enhancedPlan.map((d: any) => d.score)
                ),
                summary: 'AI generated personalized plan'
            }
        });

        await dietPlan.save();

        res.json({
            success: true,
            data: {
                dietPlan,
                goals
            }
        });
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
};

export default {
    getDietPlanWithScores,
    getDailyFeedback,
    generateDietPlanWithScores
};
