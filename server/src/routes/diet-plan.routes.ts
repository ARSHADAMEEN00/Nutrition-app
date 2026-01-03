import express from 'express';
import { generateDietPlan, getMyPlans } from '../controllers/diet-plan.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = express.Router();

// All routes here should be protected
router.use(authMiddleware);

router.post('/generate', generateDietPlan);
router.get('/my-plans', getMyPlans);

export default router;
