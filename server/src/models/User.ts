import mongoose, { Schema, Document } from 'mongoose';

export interface IUser extends Document {
    email: string;
    passwordHash: string;
    name: string;
    age?: number;
    gender?: 'Male' | 'Female' | 'Other';
    height?: number; // in cm
    weight?: number; // in kg

    healthData: {
        dietaryPreferences: string[]; // e.g. ['Vegan', 'Gluten-Free']
        allergies: string[];
        activityLevel: 'Sedentary' | 'Light' | 'Moderate' | 'Active' | 'Very Active';
        medicalConditions: string[];
        goals: string[]; // e.g. ['Lose Weight', 'Build Muscle']
        sleepPattern: string; // e.g. "6-7 hours"
        waterIntakeGoal: number; // in liters
    };

    createdAt: Date;
    updatedAt: Date;
}

const UserSchema: Schema = new Schema({
    email: { type: String, required: true, unique: true, trim: true },
    passwordHash: { type: String, required: true },
    name: { type: String, required: true, trim: true },

    age: { type: Number, required: false },
    gender: { type: String, enum: ['Male', 'Female', 'Other'], required: false },
    height: { type: Number, required: false }, // cm
    weight: { type: Number, required: false }, // kg

    healthData: {
        dietaryPreferences: { type: [String], default: [] },
        allergies: { type: [String], default: [] },
        activityLevel: {
            type: String,
            enum: ['Sedentary', 'Light', 'Moderate', 'Active', 'Very Active'],
            default: 'Moderate'
        },
        medicalConditions: { type: [String], default: [] },
        goals: { type: [String], default: [] },
        sleepPattern: { type: String, default: "" },
        waterIntakeGoal: { type: Number, default: 2.5 }
    }
}, {
    timestamps: true
});

export default mongoose.model<IUser>('User', UserSchema);
