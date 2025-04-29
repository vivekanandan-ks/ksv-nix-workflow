from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def hello_world():
    return """
    <html>
        <head>
            <title>Hello</title>
        </head>
        <body>
            <h1>Hello, World!</h1>
            <p>This is an HTML response from FastAPI.</p>
            <p>haha hehe haha hehe</p>
	    <p>one more line haha feature1</p>
        </body>
    </html>
    """

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
