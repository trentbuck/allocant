from sqlmodel import SQLModel, Field

class Person(SQLModel, table=True):
    """ Test table with deliberately stupid columns """
    person_id: int | None = Field(default=None, primary_key=True)
    common_name: str            # Was family_name + given_name
