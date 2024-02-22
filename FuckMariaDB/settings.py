from pydantic import BaseSettings
from secrets import token_urlsafe


__all__ = ['settings']


class Settings(BaseSettings):
    in_production: bool = True

    # FIXME: this is a symmetric key (pre-shared key).
    #        I want an asymmetric keypair.
    #        I want a "login" app that has the private key (for signing JWTs), and
    #        I want all the other apps to have only the public key (for verifying JWTs).
    #
    # FIXME: if the deployer ever does "SECRET_KEY=deadbeef python3 -m myapp",
    #        then EVERYONE on the system can read it out of /proc!
    #        How do we stop this happening?
    #        (See also DBURI=mysql://user:password@localhost/myapp.)
    jwt_secret_key: str = token_urlsafe(32)
    jwt_algorithm: str = 'HS256'  # ???


settings = Settings()
