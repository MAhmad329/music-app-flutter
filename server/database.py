from sqlalchemy import Column, TEXT, VARCHAR, LargeBinary, create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = 'postgresql://postgres:123456@localhost:5432/musicapp'

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit = False, autoflush= False, bind = engine)

def get_db():
    db = SessionLocal()    
    try:
        yield db
    finally:
        db.close()
