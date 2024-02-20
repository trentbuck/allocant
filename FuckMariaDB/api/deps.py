from typing import Annotated, Generator

from sqlmodel import Session
from fastapi import Depends
from ..db import engine

__all__ = [
    # FIXME: in Debian 13, remove get_db and only expose DBDep.
    'get_db'
]


def get_db() -> Generator:
    with Session(engine) as session:
        yield session


DbDep = Annotated[Session, Depends(get_db)]
