import { Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import User from '../models/User';

export const register = async (req: Request, res: Response) => {
    try {
        const {
            email,
            password,
            name,
            age,
            gender,
            height,
            weight,
            healthData
        } = req.body;

        // Check if user exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash password
        const salt = await bcrypt.genSalt(10);
        const passwordHash = await bcrypt.hash(password, salt);

        // Create user
        const newUser = new User({
            email,
            passwordHash,
            name,
            age,
            gender,
            height,
            weight,
            healthData: healthData || {} // Optional on registration
        });

        await newUser.save();

        // Create Token
        const payload = { userId: newUser._id };
        const token = jwt.sign(payload, process.env.JWT_SECRET || 'secret123', { expiresIn: '7d' });

        res.status(201).json({
            token,
            user: {
                id: newUser._id,
                name: newUser.name,
                email: newUser.email
            }
        });

    } catch (error) {
        console.error('Register Error:', error);
        res.status(500).json({ message: 'Server error' });
    }
};

export const login = async (req: Request, res: Response) => {
    try {
        const { email, password } = req.body;

        // Check user
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Check password
        const isMatch = await bcrypt.compare(password, user.passwordHash);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Create Token
        const payload = { userId: user._id };
        const token = jwt.sign(payload, process.env.JWT_SECRET || 'secret123', { expiresIn: '7d' });

        res.json({
            token,
            user: {
                id: user._id,
                name: user.name,
                email: user.email
            }
        });

    } catch (error) {
        console.error('Login Error:', error);
        res.status(500).json({ message: 'Server error' });
    }
};

export const getProfile = async (req: any, res: Response) => {
    try {
        const user = await User.findById(req.user.userId).select('-passwordHash');
        if (!user) return res.status(404).json({ message: 'User not found' });

        res.json(user);
    } catch (error) {
        console.error('Get Profile Error:', error);
        res.status(500).json({ message: 'Server error' });
    }
};
