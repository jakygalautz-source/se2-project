from sqlalchemy import text
from database import engine


def test_database_connection_can_be_established():
    with engine.connect() as connection:
        result = connection.execute(text("SELECT 1")).scalar()

    assert result == 1


def test_users_table_has_expected_columns():
    expected_columns = {
        "id",
        "username",
        "email",
        "password_hash",
        "created_at",
        "updated_at",
    }

    with engine.connect() as connection:
        result = connection.execute(text("""
            SELECT column_name
            FROM information_schema.columns
            WHERE table_name = 'users'
        """))

        actual_columns = {row[0] for row in result}

    assert expected_columns.issubset(actual_columns)