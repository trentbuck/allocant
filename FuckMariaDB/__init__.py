from fastapi import FastAPI
from .api import api_router

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
