from logging import debug
from pathlib import Path
from .settings import settings
from .models import __all__ as models
from .models import SquidRule
from sqlmodel import create_engine, SQLModel, Session

__all__ = ['engine']

if settings.in_production:
    engine = create_engine('postgresql:///prisonpc')
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
    # FIXME: this doesn't belong here.
    with Session(engine) as db:
        db.add(SquidRule(url="https://fls.org.au/",
                         group_restriction="",
                         title="Fitzroy Legal Service",
                         policy="allow_ro"))
        db.add(SquidRule(url="https://en.wikipedia.org/wiki/Distillation",
                         group_restriction="",
                         title=None,
                         policy="deny"))
        db.add(SquidRule(url="https://auth.uq.edu.au/",
                         group_restriction="students-uq",
                         title="University of Queensland",
                         policy="allow_rw"))
        db.commit()
