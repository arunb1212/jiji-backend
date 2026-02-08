# Learn with Jiji – Backend Assignment

This project is a backend service for **Learn with Jiji**, an AI learning companion by VeidaLabs.

The backend accepts user questions, securely logs them, fetches relevant learning resources from Supabase, and returns a structured response consumable by a frontend application.

> Note: No real AI is used. Responses are mocked as per the assignment scope.

---

## Tech Stack

- Node.js
- Express.js
- Supabase
  - Database
  - Authentication
  - Storage
  - Row Level Security (RLS)

---
```
## Project Structure
learn-with-jiji-backend/
│
├── index.js
├── supabaseClient.js
├── routes/
│ └── askJiji.js
├── package.json
├── .env.example
├── supabase-schema.sql
├── README.md



---
```
## How to Run Locally

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd learn-with-jiji-backend


SUPABASE_URL=https://<your-project-id>.supabase.co
SUPABASE_ANON_KEY=<your-anon-public-key>
PORT=3000

Start the server
npm run dev

Server will start at:

http://localhost:3000
```

Request Body
``` bash
{
  "query": "Explain RAG"
}

```
Response
```
{
  "answer": "Retrieval-Augmented Generation (RAG) combines information retrieval with language models to provide more accurate answers.",
  "resources": [
    {
      "title": "Introduction to RAG",
      "type": "ppt",
      "file_url": "https://..."
    },
    {
      "title": "RAG Explained Video",
      "type": "video",
      "file_url": "https://..."
    }
  ]
}
```
