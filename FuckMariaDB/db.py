from .settings import settings

from sqlmodel import create_engine

__all__ = ['engine']

if settings.in_production:
    engine = create_engine('mysql+mysqldb:///alloc')
else:
    engine = create_engine('sqlite:///', echo=True)
