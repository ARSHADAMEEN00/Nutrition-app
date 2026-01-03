import mongoose, { Schema, Document } from 'mongoose';

export interface IDietPlan extends Document {
    userId: mongoose.Types.ObjectId;
    createdAt: Date;
    status: 'Active' | 'Completed' | 'Archived';

    // Input Snapshot
    inputs: {
        age: number;
        weight: number;
        height: number;
        sleepHours: number;
        waterGoal: number;
        activityLevel: string;
        dietaryPreferences: string[];
        pantryItems: string[];
    };

    // AI Generated Plan
    analysis: {
        missingNutrients: string[];
        healthScore: number; // 0-100
        summary: string;
    };

    weeklyPlan: {
        day: string;
        meals: {
            type: 'Breakfast' | 'Lunch' | 'Dinner' | 'Snack';
            name: string;
            calories: number;
            protein: number; // g
            carbs: number; // g
            fats: number; // g
            ingredientsUsed: string[]; // From pantry
            recipeCitations: string;
        }[];
    }[];
}

const DietPlanSchema: Schema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    status: { type: String, enum: ['Active', 'Completed', 'Archived'], default: 'Active' },

    inputs: {
        age: Number,
        weight: Number,
        height: Number,
        sleepHours: Number,
        waterGoal: Number,
        activityLevel: String,
        dietaryPreferences: [String],
        pantryItems: [String]
    },

    analysis: {
        missingNutrients: [String],
        healthScore: Number,
        summary: String
    },

    weeklyPlan: [{
        day: String,
        meals: [{
            type: { type: String, enum: ['Breakfast', 'Lunch', 'Dinner', 'Snack'] },
            name: String,
            calories: Number,
            protein: Number,
            carbs: Number,
            fats: Number,
            ingredientsUsed: [String],
            recipeCitations: String
        }]
    }]
}, {
    timestamps: true
});

export default mongoose.model<IDietPlan>('DietPlan', DietPlanSchema);
