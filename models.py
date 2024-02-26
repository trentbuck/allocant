from sqlmodel import SQLModel, Field

class Person(SQLModel, table=True):
    """ Test table with deliberately stupid columns """
    person_id: int | None = Field(default=None, primary_key=True)
    family_name: str
    # FIXME: can't do this with sqlite:/// without some extra fuckery...
    # given_names: list[str]
    given_names: str
