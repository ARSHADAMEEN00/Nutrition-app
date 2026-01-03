import { Request, Response } from 'express';
import DietPlan from '../models/DietPlan';

// Mock Data Analysis
const analyzeNutrition = (inputs: any) => {
    return {
        missingNutrients: ['Vitamin D', 'Iron', 'Omega-3'],
        healthScore: 78,
        summary: `Based on your stats (${inputs.height}cm, ${inputs.weight}kg), you need more protein to support your ${inputs.activityLevel} lifestyle. Your sleep of ${inputs.sleepHours}h is decent but could be improved.`
    };
};

// Mock Weekly Plan Generator
const generateMockWeek = (pantry: string[]) => {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const pantryStr = pantry.join(', ');

    return days.map(day => ({
        day,
        meals: [
            {
                type: 'Breakfast',
                name: pantry.includes('Eggs') ? 'Spinach & Egg Omelet' : 'Oatmeal with Berries',
                calories: 350,
                protein: 20,
                carbs: 30,
                fats: 15,
                ingredientsUsed: pantry.filter(i => ['Eggs', 'Spinach', 'Oats'].includes(i)),
                recipeCitations: "Whisk eggs, add spinach, cook for 5 mins."
            },
            {
                type: 'Lunch',
                name: 'Grilled Chicken Salad',
                calories: 500,
                protein: 45,
                carbs: 10,
                fats: 20,
                ingredientsUsed: ['Chicken', 'Lettuce'],
                recipeCitations: "Grill chicken, toss with fresh veggies."
            },
            {
                type: 'Dinner',
                name: 'Quinoa Bowl',
                calories: 450,
                protein: 15,
                carbs: 60,
                fats: 10,
                ingredientsUsed: ['Quinoa'],
                recipeCitations: "Boil quinoa, add beans and spices."
            }
        ]
    }));
};

export const generateDietPlan = async (req: any, res: Response) => {
    try {
        const {
            age, weight, height, sleepHours, waterGoal, activityLevel, dietaryPreferences, pantryItems
        } = req.body;

        // 1. "AI" Analysis (Mock)
        const analysis = analyzeNutrition(req.body);
        const weeklyPlan = generateMockWeek(pantryItems || []);

        // 2. Save to DB
        const newPlan = new DietPlan({
            userId: req.user.userId,
            inputs: req.body,
            analysis,
            weeklyPlan
        });

        await newPlan.save();

        // 3. Return Result
        res.status(201).json(newPlan);

    } catch (error) {
        console.error('Generate Plan Error:', error);
        res.status(500).json({ message: 'Server error generating plan' });
    }
};

export const getMyPlans = async (req: any, res: Response) => {
    try {
        const plans = await DietPlan.find({ userId: req.user.userId }).sort({ createdAt: -1 });
        res.json(plans);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching plans' });
    }
};
