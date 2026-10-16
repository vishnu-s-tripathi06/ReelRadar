from fastapi import FastAPI

from backend.app.database import Base, engine
from backend.app.models import User
from backend.app.routers.auth import router as auth_router

Base.metadata.create_all(bind=engine)

app = FastAPI(title="ReelRadar API")

app.include_router(auth_router)


@app.get("/")
def root():
    return {"message": "ReelRadar API is running"}