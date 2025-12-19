#!/bin/bash

# Test script for Task API
# Usage: ./test-api.sh [base-url]
# Example: ./test-api.sh https://nour-tasks.Nourddine200.replit.app
# Example with -k flag: ./test-api.sh -k https://workspace.Nourddine200.replit.app

BASE_URL="${2:-http://localhost:8080}"
USE_INSECURE="${1:-}"

# If first argument is -k, use insecure flag
if [ "$1" == "-k" ]; then
    CURL_FLAGS="-k"
    BASE_URL="$2"
else
    CURL_FLAGS=""
    BASE_URL="${1:-http://localhost:8080}"
fi

echo "=========================================="
echo "🧪 Testing Task API"
echo "=========================================="
echo "Base URL: $BASE_URL"
echo "Curl flags: $CURL_FLAGS"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1: GET / (Welcome message)
echo -e "${YELLOW}Test 1: GET / (Welcome message)${NC}"
response=$(curl -s $CURL_FLAGS "$BASE_URL/")
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Success${NC}"
    echo "$response" | head -5
else
    echo -e "${RED}❌ Failed${NC}"
fi
echo ""

# Test 2: GET /tasks (Get all tasks)
echo -e "${YELLOW}Test 2: GET /tasks (Get all tasks)${NC}"
response=$(curl -s $CURL_FLAGS "$BASE_URL/tasks")
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Success${NC}"
    echo "$response"
else
    echo -e "${RED}❌ Failed${NC}"
fi
echo ""

# Test 3: POST /tasks (Create task)
echo -e "${YELLOW}Test 3: POST /tasks (Create new task)${NC}"
response=$(curl -s $CURL_FLAGS -X POST "$BASE_URL/tasks" \
    -H "Content-Type: application/json" \
    -d '{"title": "مهمة تجريبية للعرض"}')
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Success${NC}"
    echo "$response"
    TASK_ID=$(echo "$response" | grep -o '"id":[0-9]*' | grep -o '[0-9]*' | head -1)
else
    echo -e "${RED}❌ Failed${NC}"
    TASK_ID=""
fi
echo ""

# Test 4: PUT /tasks/:id (Update task)
if [ ! -z "$TASK_ID" ]; then
    echo -e "${YELLOW}Test 4: PUT /tasks/$TASK_ID (Update task)${NC}"
    response=$(curl -s $CURL_FLAGS -X PUT "$BASE_URL/tasks/$TASK_ID" \
        -H "Content-Type: application/json" \
        -d '{"title": "مهمة محدثة", "completed": true}')
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Success${NC}"
        echo "$response"
    else
        echo -e "${RED}❌ Failed${NC}"
    fi
    echo ""
    
    # Test 5: DELETE /tasks/:id (Delete task)
    echo -e "${YELLOW}Test 5: DELETE /tasks/$TASK_ID (Delete task)${NC}"
    response=$(curl -s $CURL_FLAGS -X DELETE "$BASE_URL/tasks/$TASK_ID")
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Success${NC}"
        echo "$response"
    else
        echo -e "${RED}❌ Failed${NC}"
    fi
    echo ""
else
    echo -e "${RED}⚠️  Skipping PUT and DELETE tests (no task ID available)${NC}"
    echo ""
fi

echo "=========================================="
echo "✅ Testing complete!"
echo "=========================================="
