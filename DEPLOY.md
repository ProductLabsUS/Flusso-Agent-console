# 🚀 Quick Deploy to Render

## Prerequisites
- GitHub account with your code pushed
- Render account (free)
- Google GenAI API key

## Steps

### 1. Push to GitHub
```bash
git add .
git commit -m "Ready for Render deployment"
git push origin main
```

### 2. Deploy on Render

**Option A: Blueprint (Automatic)**
1. Go to https://dashboard.render.com
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repo
4. Render detects `render.yaml` and creates the service
5. Add environment variables (see below)
6. Click **"Apply"**

**Option B: Manual**
1. Go to https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repo
4. Configure:
   - **Name**: `agent-assist-console`
   - **Environment**: Python
   - **Build Command**: `pip install -r server/requirements.txt`
   - **Start Command**: `cd server && uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Python Version**: 3.12
5. Add environment variables (see below)
6. Click **"Create Web Service"**

### 3. Environment Variables

Add in Render dashboard → Environment tab:

**Required:**
```
GOOGLE_API_KEY=your_google_api_key_here
```

**Optional:**
```
FILE_SEARCH_CORPUS_ID=your_corpus_id
FRESHDESK_DOMAIN=your-domain.freshdesk.com
FRESHDESK_API_KEY=your_freshdesk_key
DATA_DIR=data
```

**CORS (Auto-configured):**
```
ALLOWED_ORIGINS=https://agent-assist-console.onrender.com
```
Update this with your actual Render URL after deployment.

### 4. Wait for Deployment
- First deploy takes ~5-10 minutes
- Watch build logs in Render dashboard
- Service URL will be: `https://agent-assist-console.onrender.com`

### 5. Test
1. Visit your service URL
2. Check `/health` endpoint: `https://your-app.onrender.com/health`
3. Try the chat interface
4. Check API docs: `https://your-app.onrender.com/docs`

## Important Notes

### Free Tier
- Service **sleeps after 15 min** of inactivity
- First request after sleep: **30-60 sec** to wake up
- 512 MB RAM limit
- 750 hours/month free

### Data Files
- `server/data/` must be in your repo (it is!)
- No persistent disk on free tier
- Data loaded at startup into memory

### Frontend Config
The app is configured to work as a single service:
- Backend serves frontend from `/`
- API endpoints at `/api/*`
- No additional config needed

### Troubleshooting

**Build fails:**
```bash
# Check Python version
PYTHON_VERSION=3.12.0

# Verify requirements.txt path
pip install -r server/requirements.txt
```

**CORS errors:**
Update `ALLOWED_ORIGINS` to match your Render URL:
```
ALLOWED_ORIGINS=https://your-actual-url.onrender.com
```

**Service won't start:**
- Check environment variables
- Verify GOOGLE_API_KEY is set
- Check logs in Render dashboard

**Frontend can't load:**
- Make sure static files are in `client/` directory
- Backend automatically serves them from `/`

## Next Steps

1. Test your deployment thoroughly
2. Monitor logs for errors
3. Consider upgrading to paid plan to avoid spin-down
4. Set up custom domain (optional)

## Support
- Render Docs: https://render.com/docs
- GitHub Issues: [Your repo]
- Logs: Render Dashboard → Your Service → Logs
