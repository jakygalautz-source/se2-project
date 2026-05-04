from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# -------------------------------------------
# PostgreSQL database connection
# -------------------------------------------

# Format:
# postgresql+psycopg2://USERNAME:PASSWORD@HOST:PORT/DATABASE_NAME

DATABASE_URL = "postgresql+psycopg2://postgres:123456@localhost:5432/pill_pilot"

# Creates connection to the database
engine = create_engine(DATABASE_URL)

# Creates database sessions for the endpoints
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)


# This function is used in the routers to access the database
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()