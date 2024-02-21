from importlib.resources import files

from fastapi.templating import Jinja2Templates

from .settings import settings

__all__ = ['templates']

# FIXME: this is a type error, because
#        it only works when the library is unzipped!
if False:
    templates = Jinja2Templates(directory=files('FuckMariaDB') / 'templates')
# FIXME: this breaks "flit build" because the directory MUST exist at IMPORT time!!
elif False:
    templates = Jinja2Templates(directory=(
        '/usr/lib/python3/dist-packages/FuckMariaDB/templates'
        if settings.in_production else
        'FuckMariaDB/templates'))
else:
    templates = Jinja2Templates(directory='FuckMariaDB/templates')
