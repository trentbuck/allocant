from secrets import compare_digest
from typing import Annotated, Generator, Callable

from sqlmodel import Session
from fastapi import Depends, HTTPException, status, Request
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from ..settings import settings
from ..db import engine
from ..models import HTTPBasicUser

from prisonpc.rfc2307 import groups_containing_user  # FIXME: this is not cached...


__all__ = [
    # FIXME: in Debian 13, remove get_x and only expose XDep.
    'get_db',
    'get_current_user',
    'make_group_validator',
]


def get_db() -> Generator:
    with Session(engine) as session:
        yield session


# FIXME: Can't use these until Debian 13.
DbDep = Annotated[Session, Depends(get_db)]

http_basic = HTTPBasic(realm='PrisonPC')


def get_current_user(
        request: Request,       # we also verify the source IP
        credentials: HTTPBasicCredentials = Depends(http_basic),
) -> HTTPBasicUser:
    """Chuck a wobbly unless unless it looks like we came from apache2.
    Based on
    https://git.cyber.com.au/prisonpc/blob/23.10.1/ppcadm/ppcadm#L-114
    https://git.cyber.com.au/prisonpc/blob/23.10.1/ppcadm/ppcadm_auth.py
    """
    fail = HTTPException(status.HTTP_403_FORBIDDEN)
    # FIXME: Can't do this, because
    #        HTTPBasicCredentials discards the realm.
    #        Has the HTTPBasic(realm=X) already verified this?
    #        Or is it just ignored?
    # if credentials.realm != 'PrisonPC':
    #     raise fail
    if credentials.username != credentials.username.lower():
        raise fail
    if not compare_digest(
            credentials.password.encode('UTF-8'),
            settings.HTTP_Basic_Auth_PSK.encode('UTF-8')):
        raise fail
    if not request.client:
        raise fail
    if request.client.host not in {'127.0.0.1', '::1'}:
        raise fail
    return HTTPBasicUser(
        username=credentials.username,
        groups=groups_containing_user(credentials.username))


def make_group_validator(group_name: str) -> Callable:
    def validator(user: HTTPBasicUser = Depends(get_current_user)) -> None:
        f"""Chuck a wobbly unless user is a member of {group_name} or 'administrator'"""
        if {'administrator', group_name} & set(user.groups):
            return
        # NOTE: we deliberately "leak" the required group here, because
        #       the attacker must ALREADY HAVE a valid staff account, and
        #       letting them know which group to add themselves to is benign.
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f'Not a member of {group_name}')
    return validator
