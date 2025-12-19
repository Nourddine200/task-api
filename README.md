# Task API – Node.js & Express

Simple REST API for managing tasks (CRUD) built with Node.js and Express.

## Tech Stack
- Node.js
- Express.js
- CORS middleware
- Replit Cloud
- GitHub

## Features
- ✅ RESTful API with CRUD operations
- ✅ CORS enabled for cross-origin requests
- ✅ In-memory storage (ready for database integration)
- ✅ Input validation and error handling
- ✅ Replit-ready deployment

## Endpoints
- `GET /` - Welcome message with API documentation
- `GET /tasks` - Get all tasks
- `POST /tasks` - Create a new task (requires `{"title": "Task title"}`)
- `PUT /tasks/:id` - Update a task (requires `{"title": "Updated title", "completed": true/false}`)
- `DELETE /tasks/:id` - Delete a task

## Setup

### Install Dependencies
```bash
npm install
```

### Run Server
```bash
npm start
```

The server will start on port 8080 (or the port specified in `process.env.PORT`).

## Testing with curl

### Manual Testing

```bash
# GET welcome message
curl http://localhost:8080/

# GET all tasks
curl http://localhost:8080/tasks

# CREATE task
curl -X POST http://localhost:8080/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My first task"}'

# UPDATE task
curl -X PUT http://localhost:8080/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated task", "completed": true}'

# DELETE task
curl -X DELETE http://localhost:8080/tasks/1
```

### Testing Replit URL (with SSL issues)

If you're testing a Replit URL with SSL certificate issues, use the `-k` flag:

```bash
# Test with insecure flag (ignores SSL certificate)
curl -k https://workspace.Nourddine200.replit.app/tasks

# Create task
curl -k -X POST https://workspace.Nourddine200.replit.app/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Test task"}'
```

### Automated Testing Scripts

We provide test scripts for easy API testing:

**Linux/macOS:**
```bash
# Test local server
./test-api.sh http://localhost:8080

# Test Replit URL (with -k flag for SSL issues)
./test-api.sh -k https://workspace.Nourddine200.replit.app

# Test Replit URL (after changing name, no -k needed)
./test-api.sh https://nour-tasks.Nourddine200.replit.app
```

**Windows:**
```cmd
REM Test local server
test-api.bat http://localhost:8080

REM Test Replit URL (with -k flag for SSL issues)
test-api.bat -k https://workspace.Nourddine200.replit.app

REM Test Replit URL (after changing name, no -k needed)
test-api.bat https://nour-tasks.Nourddine200.replit.app
```

## Deployment

### Replit
1. Upload `index.js` and `package.json` to your Replit project
2. Run `npm install` in the Shell to install dependencies
3. Click "Run" button - the server will start automatically
4. Replit will provide a public URL automatically

**⚠️ Troubleshooting SSL/HSTS Issues**

If you see SSL certificate errors (`ERR_CERT_COMMON_NAME_INVALID` or HSTS blocking):

### 🔧 الحل الجذري (موصى به بشدة):

1. **Change Repl Name** (Best Solution):
   - Click on the Repl name (e.g., `workspace`) at the top
   - Change to a simple, single-word name like `nour-tasks` or `tasks-api`
   - **Avoid names with multiple dots** (e.g., don't use `workspace`)
   - Click "Stop" then "Run" again
   - Wait 10-15 seconds for the new URL to be ready
   - The new URL will work without any SSL warnings

2. **Why This Works:**
   - Replit SSL certificates work best with simple names like `nour-tasks.replit.app`
   - Complex names like `workspace.Nourddine200.replit.app` trigger browser security warnings
   - Simple names = green lock ✅, complex names = red warnings ❌

### 🔄 حلول بديلة:

3. **Test with curl using `-k` flag** (for Shell testing only):
   ```bash
   curl -k https://workspace.Nourddine200.replit.app/tasks
   ```

4. **Chrome "Magic" Workaround** (not recommended for presentations):
   - Click anywhere on the error page
   - Type: `thisisunsafe` (no text box needed)
   - Site will open automatically

5. **Use Replit Webview**:
   - Click "Open in Browser" button in Replit
   - Webview works without SSL issues (but only in Replit environment)

**📖 For detailed troubleshooting guide, see [SSL_TROUBLESHOOTING.md](./SSL_TROUBLESHOOTING.md)**

### Other Issues:

6. **Check Server is Running**: 
   - Look for `✅ Server running on port 8080` in the console
   - Test locally: `curl http://localhost:8080/` in Shell

7. **Get Correct URL**:
   - Use the "Open in Browser" button in Replit's Webview panel
   - Replit sometimes adds random numbers (e.g., `workspace-00.replit.app`)

**💡 Tip for Presentations**: 
- Always click "Run" in Replit before showing the API
- Wait 10-15 seconds after clicking Run
- Use a unique Repl name (not `workspace`) to avoid SSL issues
- Test the URL in the Shell first: `curl http://localhost:8080/tasks`

### Environment Variables
- `PORT` - Server port (default: 8080, Replit's most stable port)
- `REPL_SLUG` - Replit slug (automatically set by Replit)
- `REPL_OWNER` - Replit owner (automatically set by Replit)

## Project Structure
```
.
├── index.js                    # Main server file
├── package.json                # Dependencies and scripts
├── .gitignore                  # Git ignore rules
├── README.md                   # This file
├── SSL_TROUBLESHOOTING.md      # SSL/HSTS troubleshooting guide
├── test-api.sh                 # Automated test script (Linux/macOS)
└── test-api.bat                # Automated test script (Windows)
```

## Future Enhancements
- Database integration (PostgreSQL, MySQL, MongoDB, etc.)
- Authentication and authorization
- Rate limiting
- Request logging
- API documentation (Swagger/OpenAPI)

