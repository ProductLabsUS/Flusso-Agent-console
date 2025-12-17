/**
 * Environment Configuration
 * 
 * For Render deployment:
 * 1. If using separate backend/frontend services:
 *    - Set BACKEND_URL to your backend URL
 * 2. If using single service (backend serves frontend):
 *    - Leave BACKEND_URL undefined or set to same origin
 */

// Set this to your Render backend URL when deploying with separate services
// Example: window.BACKEND_URL = 'https://agent-assist-backend.onrender.com';
window.BACKEND_URL = undefined;

// For local development, this will be ignored and localhost:8000 will be used
// For production with single service, same origin will be used
// For production with separate services, set the URL above
