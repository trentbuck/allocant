from typing import Annotated, Generator

from jose import jwt
from jose.exceptions import JWTError
from sqlmodel import Session
from pydantic import ValidationError
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from ..settings import settings
from ..db import engine


__all__ = [
    # FIXME: in Debian 13, remove get_x and only expose XDep.
    'get_db',
    'get_current_user',
    'reusable_oauth2',
]


def get_db() -> Generator:
    with Session(engine) as session:
        yield session


# FIXME: Can't use these until Debian 13.
DbDep = Annotated[Session, Depends(get_db)]


# NOTE: '/login' here matches the ultimate URL for
#        FuckMariaDB.login.login_access_token.
reusable_oauth2 = OAuth2PasswordBearer(tokenUrl='/login')
TokenDep = Annotated[str, Depends(reusable_oauth2)]


# FIXME: don't just use a bare 'str' for the username, make an actual object.
#        This would happen when I add SQLModel models for LDAP objects...
def get_current_user(token: str = Depends(reusable_oauth2)) -> str:
    try:
        payload = jwt.decode(
            token,
            settings.jwt_secret_key,
            algorithms=[settings.jwt_algorithm])
        return payload['sub']
    except (JWTError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail='Could not validate credentials')


CurrentUserDep = Annotated[str, Depends(get_current_user)]
