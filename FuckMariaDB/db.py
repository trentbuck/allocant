from logging import debug
from pathlib import Path
from .settings import settings
from .models import __all__ as models

from sqlmodel import create_engine, SQLModel

__all__ = ['engine']

if settings.in_production:
    engine = create_engine('mysql+mysqldb:///alloc')
else:
    # FIXME: With sqlite:/// (in-memory), I get this:
    #        https://github.com/tiangolo/fastapi/discussions/10512
    #        For now, use a regular file (ugh).
    for path in Path.cwd().glob('delete-me.db*'):
        path.unlink()
    engine = create_engine(
        'sqlite:///delete-me.db',
        echo=True,
        # https://fastapi.tiangolo.com/tutorial/sql-databases/#create-the-sqlalchemy-engine
        connect_args={'check_same_thread': False})
    # FIXME: this doesn't belong here.
    debug('We must to import %s, as that populates global singleton'
          ' sqlmodel.SQLModel.metadata as a side-effect!',
          models)
    SQLModel.metadata.create_all(engine)
