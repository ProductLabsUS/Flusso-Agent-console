# Render Deployment Guide

## 🚀 Deploy Agent Assist Console to Render (Free Tier)

This guide walks you through deploying the application to Render without Docker.

---

## Prerequisites

1. **GitHub Repository**: Push your code to GitHub
2. **Render Account**: Sign up at [render.com](https://render.com)
3. **Environment Variables**: Have your API keys ready

---

## Deployment Steps

### Step 1: Push to GitHub

```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### Step 2: Connect to Render

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repository
4. Select the repository containing your app
5. Render will automatically detect `render.yaml`

### Step 3: Configure Environment Variables

In the Render dashboard, add these environment variables for the **backend service**:

#### Required:
- `GOOGLE_API_KEY`: Your Google GenAI API key
- `ALLOWED_ORIGINS`: Add your frontend URL (e.g., `https://agent-assist-frontend.onrender.com`)

#### Optional:
- `FILE_SEARCH_CORPUS_ID`: Your Google File Search corpus ID
- `FRESHDESK_DOMAIN`: Your Freshdesk domain (if using Freshdesk)
- `FRESHDESK_API_KEY`: Your Freshdesk API key (if using Freshdesk)

### Step 4: Deploy

1. Click **"Apply"** to create the services
2. Render will:
   - Install dependencies from `server/requirements.txt`
   - Start the backend on the assigned port
   - Deploy the frontend as a static site

3. Wait for deployment to complete (~5-10 minutes on free tier)

### Step 5: Update CORS

After deployment, update the `ALLOWED_ORIGINS` environment variable:

1. Go to your backend service in Render
2. Navigate to **Environment** tab
3. Update `ALLOWED_ORIGINS` to include your frontend URL:
   ```
   https://agent-assist-frontend.onrender.com
   ```
4. Save and redeploy

---

## Important Notes

### Free Tier Limitations

- **Spin-down**: Services sleep after 15 minutes of inactivity
- **First request**: May take 30-60 seconds to wake up
- **Build time**: Limited to 20 minutes
- **Memory**: 512 MB RAM

### Data Directory

The `server/data/` directory should be committed to your repository since Render free tier doesn't support persistent disks.

Ensure `.gitignore` doesn't exclude:
- `server/data/metadata_manifest.json`

### Frontend Configuration

Update `client/app.js` to use the correct backend URL:

```javascript
const CONFIG = {
    apiBaseUrl: window.location.origin.includes('localhost') 
        ? 'http://localhost:8000' 
        : 'https://agent-assist-backend.onrender.com', // Your backend URL
    // ...
};
```

---

## Troubleshooting

### Build Fails

Check build logs in Render dashboard:
- Ensure `server/requirements.txt` has all dependencies
- Python version should be 3.12 or compatible

### Backend Won't Start

1. Check environment variables are set correctly
2. Verify `GOOGLE_API_KEY` is valid
3. Check startup logs for errors

### CORS Errors

1. Verify `ALLOWED_ORIGINS` includes your frontend URL
2. Format: `https://your-frontend.onrender.com` (no trailing slash)
3. Multiple origins: separate with commas

### Frontend Can't Connect to Backend

1. Update `client/app.js` with correct backend URL
2. Ensure backend is running (check Render dashboard)
3. Check browser console for errors

---

## Alternative: Single Web Service Deployment

If you prefer a simpler setup with one service:

1. Use only the backend service from `render.yaml`
2. Backend serves static files from `client/` directory
3. Access everything at: `https://agent-assist-backend.onrender.com`

To do this, update `render.yaml`:

```yaml
services:
  - type: web
    name: agent-assist-console
    env: python
    region: oregon
    plan: free
    branch: main
    buildCommand: pip install -r server/requirements.txt
    startCommand: cd server && uvicorn app.main:app --host 0.0.0.0 --port $PORT
    envVars:
      - key: PYTHON_VERSION
        value: 3.12.0
      - key: GOOGLE_API_KEY
        sync: false
      - key: ALLOWED_ORIGINS
        value: https://agent-assist-console.onrender.com
      # ... other env vars
```

---

## Monitoring

- **Health Check**: `https://your-backend.onrender.com/health`
- **API Docs**: `https://your-backend.onrender.com/docs`
- **Logs**: Available in Render dashboard under "Logs" tab

---

## Production Checklist

- [ ] All environment variables set
- [ ] CORS origins updated with production URLs
- [ ] Data files committed to repository
- [ ] Frontend configured with correct backend URL
- [ ] Health check endpoint responds successfully
- [ ] Test chat functionality end-to-end
- [ ] Verify Freshdesk integration (if enabled)

---

## Cost Optimization

Free tier is sufficient for testing, but for production:

- Upgrade to **Starter plan** ($7/month) to avoid spin-down
- Use environment-specific configs
- Consider CDN for static assets

---

## Support

- [Render Documentation](https://render.com/docs)
- [FastAPI Deployment Guide](https://fastapi.tiangolo.com/deployment/)
- Check application logs in Render dashboard
