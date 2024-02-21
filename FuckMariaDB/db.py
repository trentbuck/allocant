from logging import debug
from .settings import settings
from .models import __all__ as models

from sqlmodel import create_engine, SQLModel

__all__ = ['engine']

if settings.in_production:
    engine = create_engine('mysql+mysqldb:///alloc')
else:
    engine = create_engine('sqlite:///', echo=True)
    # FIXME: this doesn't belong here.
    debug('We must to import %s, as that populates global singleton'
          ' sqlmodel.SQLModel.metadata as a side-effect!',
          models)
    SQLModel.metadata.create_all(engine)
