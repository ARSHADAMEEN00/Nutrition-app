# NutriAI - Kerala Smart Nutrition Platform

🧠 **AI-Enhanced Personalized Nutrition App** for Kerala adults and Gen-Z users.

## 🚀 Features

- **Personalized Meal Plans**: AI-powered weekly/monthly meal recommendations
- **Food Recognition**: Photo-based nutrition estimation using Google Vision/Calorie Mama API
- **Educational Content**: Videos from certified dietitians
- **Smart Recommendations**: ChatGPT-powered adaptive meal planning
- **Secure Authentication**: Phone OTP with public access for educational content

## 🛠️ Tech Stack

### Frontend

- React 18 + TypeScript
- Material UI v6 (MUI)
- Redux Toolkit
- React Router DOM
- Axios
- Vite

### Backend

- Node.js 20 + TypeScript
- Express.js
- MongoDB + Mongoose
- JWT/Firebase Auth
- Axios for AI API calls

## 📁 Project Structure

```
nutri-ai/
├── client/          # React frontend
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── store/
│   │   ├── utils/
│   │   ├── types/
│   │   └── services/
│   ├── package.json
│   └── vite.config.ts
├── server/          # Node.js backend
│   ├── src/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── middleware/
│   │   ├── utils/
│   │   └── types/
│   ├── package.json
│   └── tsconfig.json
├── package.json     # Root package.json
├── README.md
└── env.example
```

## 🚀 Quick Start

### Prerequisites

- Node.js 20+
- MongoDB
- npm or yarn

### Installation

1. **Clone and install dependencies:**

   ```bash
   git clone <repository-url>
   cd nutri-ai
   npm run install:all
   ```

2. **Environment Setup:**

   ```bash
   cp env.example .env
   # Edit .env with your API keys and configuration
   ```

3. **Start Development Servers:**
   ```bash
   npm run dev
   ```

This will start both frontend (http://localhost:3000) and backend (http://localhost:5000) concurrently.

### Individual Commands

- **Frontend only:** `npm run dev --prefix client`
- **Backend only:** `npm run dev --prefix server`
- **Build all:** `npm run build`
- **Clean all:** `npm run clean`

## 🔧 Development

### Available Scripts

- `npm run dev` - Start both frontend and backend in development mode
- `npm run build` - Build both frontend and backend for production
- `npm run install:all` - Install dependencies for root, client, and server
- `npm run clean` - Remove all node_modules and build artifacts

### Linting & Formatting

Both client and server are configured with ESLint and Prettier:

- `npm run lint --prefix client` - Lint frontend code
- `npm run lint:fix --prefix client` - Fix frontend linting issues
- `npm run lint --prefix server` - Lint backend code
- `npm run lint:fix --prefix server` - Fix backend linting issues

## 🌟 Project Seasons

This project is structured in 8 seasons:

- **Season 1** ✅ - Project Scaffold & Folder Setup (Current)
- **Season 2** - Authentication & User Management
- **Season 3** - Database Models & API Endpoints
- **Season 4** - AI Integration & Food Recognition
- **Season 5** - Meal Planning & Recommendations
- **Season 6** - Educational Content & Videos
- **Season 7** - Frontend UI/UX Implementation
- **Season 8** - Testing, Deployment & Optimization

## 📝 Environment Variables

Copy `env.example` to `.env` and configure:

- `PORT` - Server port (default: 5000)
- `MONGO_URI` - MongoDB connection string
- `JWT_SECRET` - JWT signing secret
- `FIREBASE_API_KEY` - Firebase authentication key
- `OPENAI_API_KEY` - OpenAI API key for ChatGPT integration
- `VISION_API_KEY` - Google Vision API key for food recognition
- `CALORIE_MAMA_API_KEY` - Calorie Mama API key for nutrition data

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run linting and tests
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

---

**Season 1 Complete** ✅ - Project scaffold and folder structure ready for development!
