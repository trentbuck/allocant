from importlib.resources import files
from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from .api import api_router
from .login import login_router
from .settings import settings

__version__ = '0'
__all__ = ['app']
__doc__ = """ Proof-of-concept codebase using FastAPI, SQLModel, HTMx, and Handlebars or Jinja2

The point of this is to experiment providing a modern stack accessing an existing old database.
The old app used MySQL and PHP5, using an in-house app-specific ORM.
The ORM broke slightly when I upgraded MariaDB 1:10.5.23-0+deb11u1 to 1:10.11.6-0+deb12u1.
It's too hard to fix, and too hard to downgrade, so
make new app which provides JUST the interactions that broke (and Ron still needs to do). """


app = FastAPI()
app.include_router(api_router)
app.include_router(login_router)  # FIXME: this should become a separate "app".

# FIXME: this is a type error, because
#        it only works when the library is unzipped!
if False:
    app.mount('/static', name='static', app=StaticFiles(
        directory=files('fuck_mysql') / 'static'))
# FIXME: this breaks "flit build" because the directory MUST exist at IMPORT time!!
elif False:
    app.mount('/static', name='static', app=StaticFiles(
        directory=('/usr/lib/python3/dist-packages/FuckMariaDB/static'
                   if settings.in_production else
                   'FuckMariaDB/static')))
else:
    app.mount('/static', name='static', app=StaticFiles(
        directory='FuckMariaDB/static'))


@app.get('/')
async def landing_page() -> RedirectResponse:
    return RedirectResponse('static/index.html')
