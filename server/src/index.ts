import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import dotenv from 'dotenv';
import mongoose from 'mongoose';

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Security middleware
app.use(helmet());
app.use(cors());

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
});
app.use(limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({
        status: 'OK',
        message: 'NutriAI Server is running',
        timestamp: new Date().toISOString()
    });
});

// Connect to MongoDB
const connectDB = async () => {
    try {
        const mongoURI = process.env.MONGO_URI || 'mongodb://localhost:27017/nutriai';
        await mongoose.connect(mongoURI);
        console.log('✅ MongoDB connected successfully');
    } catch (error) {
        console.error('❌ MongoDB connection error:', error);
        process.exit(1);
    }
};

// Routes
import authRoutes from './routes/auth.routes';
app.use('/api/auth', authRoutes);

import dietPlanRoutes from './routes/diet-plan.routes';
app.use('/api/diet', dietPlanRoutes);

// Start server
const startServer = async () => {
    await connectDB();

    app.listen(PORT, () => {
        console.log(`🚀 Server running on port ${PORT}`);
        console.log(`📊 Health check: http://localhost:${PORT}/api/health`);
        console.log(`🔐 Auth API: http://localhost:${PORT}/api/auth`);
        console.log(`🥗 Diet API: http://localhost:${PORT}/api/diet`);
    });
};

startServer().catch(console.error);

export default app;
