# Beginner Installation Manual

This guide will help you set up and run the Agent Assistance Bot project, even if you are new to programming. Follow each step carefully.

---

## 1. Prerequisites

Before you start, make sure you have:

- **Python 3.11 or newer** installed. [Download Python here](https://www.python.org/downloads/). When installing, check the box that says "Add Python to PATH".
- **Git** installed. [Download Git here](https://git-scm.com/downloads).

---

## 2. Download the Project

1. Open the Command Prompt (Windows) or Terminal (Mac/Linux).
2. Choose a folder where you want to keep the project.
3. Run these commands (replace `<your-repo-url>` with your GitHub link):

```sh
git clone <your-repo-url>
cd Agent-Assistance-Bot
```

---

## 3. Set Up a Python Virtual Environment

A virtual environment keeps your project’s Python packages separate from other projects.

**On Windows:**
```sh
python -m venv .venv
.\.venv\Scripts\activate
```

**On Mac/Linux:**
```sh
python3 -m venv .venv
source .venv/bin/activate
```

If you see your prompt change to something like `(.venv)`, it worked!

---

## 4. Install Python Packages

With the virtual environment activated, install the required packages:

```sh
pip install -r requirements.txt
```

If you see errors, make sure you activated the virtual environment and are in the project folder.

---

## 5. Set Up Environment Variables

Some features need API keys or special settings. These are stored in a file called `.env` in the main folder.

1. If you have a `.env.example` file, copy it to `.env`:
	```sh
	copy .env.example .env   # Windows
	cp .env.example .env     # Mac/Linux
	```
2. Open `.env` in a text editor and fill in your API keys:
	- `GOOGLE_API_KEY` (required)
	- `FRESHDESK_DOMAIN`, `FRESHDESK_API_KEY` (optional, for Freshdesk integration)

If you don’t have these keys, ask your project admin or see the README for how to get them.

---

## 6. Run the Backend (Server)

1. Make sure your virtual environment is activated.
2. Start the backend server:

```sh
python -m uvicorn server.app.main:app --reload
```

If it starts successfully, you’ll see messages like “Uvicorn running on http://127.0.0.1:8000”.

---

## 7. Run the Frontend (Website)

You have two options:

**Option 1: Open Directly**
- Open `client/index.html` by double-clicking it. (Some features may not work due to browser security.)

**Option 2: Use a Simple Web Server (Recommended)**
1. Open a new terminal window.
2. Go to the client folder:
	```sh
	cd client
	```
3. Start a simple server:
	```sh
	python -m http.server 3000
	```
4. Open your browser and go to: [http://localhost:3000](http://localhost:3000)

---

## 8. Test the Project

- **Backend API Docs:** Open [http://localhost:8000/docs](http://localhost:8000/docs) in your browser to see and test the backend API.
- **Frontend:** Use the website at [http://localhost:3000](http://localhost:3000).

---

## 9. Troubleshooting Tips

- If you see “command not found” or “python is not recognized”, make sure Python is installed and added to your PATH.
- If you see “ModuleNotFoundError”, make sure you installed all requirements and activated your virtual environment.
- If ports 8000 or 3000 are busy, close other apps or use a different port (e.g., `python -m http.server 8080`).

---

## 10. Next Steps

For more advanced usage (like Docker, deployment, or API keys), see the main README.md or ask your project admin.
