import re
import pathlib

from pydantic import BaseSettings


__all__ = ['settings']


# FIXME: why is this file world-readable if it contains a cleartext password???
# FIXME: put this pre-shared secret in some other file and then
#        work out how to make Apache include it from there...
def _shitty_apache_config_parser() -> str:
    if m := re.search(r'AuthBasicFake\s+".*"\s+"(.*)"',
                      pathlib.Path('/etc/apache2/sites-enabled/000-prisonpc.conf').read_text()):
        return m.group(1)
    raise RuntimeError()


class Settings(BaseSettings):
    in_production: bool = True

    # This is intended to be shared between apache and web apps.
    # The conversation is approximately this:
    #
    #   Apache -> Chrome:  401 www-authenticate: basic PrisonPC
    #   Chrome -> Apache:  authenticate: basic {{base64(f"PrisonPC:alice:sw0rdf1sh")}}
    #   Apache -> LDAP:    <check username/password, group membership>
    #   Apache -> FastAPI: authenticate: basic {{base64(f"PrisonPC:alice:<this PSK>")}}
    #   FastAPI:           <check PSK, use user, re-query group membership>
    #
    # This is kinda crap, but NO WORSE than we had in 2010-2025.
    HTTP_Basic_Auth_PSK: str = _shitty_apache_config_parser()


settings = Settings()
