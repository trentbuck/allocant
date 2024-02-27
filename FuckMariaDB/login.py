from datetime import datetime, timedelta

import ldap3
from jose import jwt
from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    status,
)
from fastapi.security import OAuth2PasswordRequestForm

from .models import Token
from .settings import settings
from .api.deps import get_current_user

__all__ = ['login_router']
__doc__ = """ Useful text here.

NOTE: Token expiry ('exp') is validated automatically:

          >>> token = jwt.encode({'sub': 'test', 'exp': datetime.utcnow() + timedelta(seconds=3)}, key='bar')
          >>> jwt.decode(token, key='bar')
          {'sub': 'test', 'exp': 1708590267}
          >>> time.sleep(4)
          >>> jwt.decode(token, key='bar')
          jose.exceptions.ExpiredSignatureError: Signature has expired.
"""

login_router = APIRouter(prefix='/login', tags=['login'])


@login_router.post('/')
def login_access_token(
        # db: sqlmodel.Session: fastapi.Depends(get_db),
        form_data: OAuth2PasswordRequestForm = Depends(),
) -> Token:
    'Get an opaque proof-I-authenticated token'
    # If we can LDAP bind as user/pw, and
    # then look up our own object, then
    # we have successfully authenticated.
    with ldap3.Connection(
            server='ldapi:///run/slapd/ldapi',
            authentication=ldap3.SIMPLE,
            user=f'uid={form_data.username},ou=staff,o=PrisonPC',
            password=form_data.password,
            auto_bind=ldap3.AUTO_BIND_NONE) as conn:
        if conn.bind():
            # LDAP is case-folding, other components are case-sensitive.
            # Enforce lowercase ("alice" not "Alice" nor "ALICE").
            if form_data.username == form_data.username.lower():
                return Token(access_token=jwt.encode(
                    {"exp": datetime.utcnow() + timedelta(minutes=60),
                     "sub": form_data.username},
                    settings.jwt_secret_key,
                    algorithm=settings.jwt_algorithm))
    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST,
        detail="Incorrect email or password")


@login_router.post('/test-token', response_model=str)
def test_token(current_user: str = Depends(get_current_user)) -> str:
    return current_user
