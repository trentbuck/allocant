from ldap3 import Connection, SAFE_SYNC
from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    status,
)
from fastapi.security import OAuth2PasswordRequestForm
from .models import Token
from .settings import settings

router = APIRouter(prefix='/login', tags=['login'])


@router.post('/')
def login_access_token(
        # db: sqlmodel.Session: fastapi.Depends(get_db),
        form_data: OAuth2PasswordRequestForm = Depends(),
) -> Token:
    # NOTE: force lowercase to prevent logging in separately as "Alice" and "alice"?
    if form_data.username != form_data.username.lower():
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    # If we can LDAP bind as user/pw, and
    # then look up our own object, then
    # we have successfully authenticated.
    dn = f'uid={form_data.username},ou=staff,o=PrisonPC'
    with Connection(
            server='ldapi:///var/run/slapd/ldapi'
            user=dn,
            password=form_data.password,
            client_strategy=SAFE_SYNC,
            auto_bind=True) as conn:
        conn.search(search_base=dn,
                    search_scope='ONE',
                    attributes=['dn'])
        expected_uids = {form_data.username}
        response_uids = {
                uid
                for obj in conn.responses
                for uid in obj['attributes']['uid']}
        if response_uids == actual_uids:
            logging.debug('Authentication successful for %s', form_data.username)
            return Token(access_token=create_access_token(form_data.username))
        else:
            logging.debug('Authentication failed for %s', form_data.username)
    raise HTTPException(status_code=400, detail="Incorrect email or password")


def create_access_token(subject: str) -> str:
    return jwt.encode(
        {"exp": datetime.utcnow() + timedelta(minutes=60),
         "sub": str(subject)},
        settings.jwt_secret_key,
        algoritm=jwt_algorithm)
