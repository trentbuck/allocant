# FIXME: BROKEN: import ipaddress
# FIXME: BROKEN: import pathlib
import contextlib
import gettext
import importlib.resources
import logging
import pickle
import subprocess

import fastapi
import fastapi.staticfiles
import fastapi.templating
import sqlmodel
import sqlalchemy.types

from .model import Product      # UGH, FUCK ME



# MODEL ####################################################



############################################################

# NOTE: create_engine(⋯, echo=True) is like "set -x" in bash, it's for debugging.
engine = sqlmodel.create_engine("sqlite:///delete-me.db", echo=False)
app = fastapi.FastAPI()

app.mount("/static",
          fastapi.staticfiles.StaticFiles(
              directory=importlib.resources.files('fuck_mysql') / 'static'),
          name="static")

templates = fastapi.templating.Jinja2Templates(
    directory=importlib.resources.files('fuck_mysql') / "templates")
templates.env.add_extension('jinja2.ext.i18n')
templates.env.install_gettext_callables(gettext.gettext, gettext.ngettext, newstyle=True)


@app.on_event("startup")
async def on_startup() -> None:
    sqlmodel.SQLModel.metadata.create_all(engine)
    # If there's AT LEAST 1 row in 1 table,
    # skip import of legacy data.
    try:
        with session() as sess:
            sess.exec(sqlmodel.select(Product.productName).limit(1)).one()
            logging.warning('Probably full database, so NOT getting rows from tweak.')
            return
    except sqlalchemy.exc.NoResultFound:
        logging.warning('Probably empty database, so getting rows from tweak.')

    # Import all the existing rows from the old database,
    # doing some fuzzy massaging along the way.
    # FIXME: type declaration is broken.
    # legacy_table2class: list[tuple[str, sqlmodel.SQLModel]]
    klasses = [
        Product,
    ]
    proc = subprocess.run(
        ['ssh', 'root@heavy.cyber.com.au', 'runuser -u alloc -- python3'],
        check=True,
        text=False,
        stdout=subprocess.PIPE,
        input=importlib.resources.read_binary('fuck_mysql', 'sloppy_slurp.py'))
    legacy_data: dict[str, list] = pickle.loads(proc.stdout)
    with session() as sess:
        # NOTE: due to FK constraints, have add these tables in the correct order...
        for klass in klasses:
            sess.add_all(
                klass(**legacy_row)
                for legacy_row in legacy_data[klass.__tablename__])
            sess.commit()
            # FIXME: if I do
            #             add_all(soes)
            #             add_all(realms)
            #             add_all(hosts)
            #             commit
            #        if crashes with an FK problem????
            #        I think this is because the realms are failing to insert, but
            #        then it is not even telling me, because the hosts fail to insert later on.
            #        So FOR NOW do this instead:
            #             add_all(soes)
            #             commit()
            #             add_all(realms)
            #             commit()
            #             add_all(hosts)
            #             commit()
            #
            # https://stackoverflow.com/questions/19143345/about-refreshing-objects-in-sqlalchemy-session#19144652
            # https://docs.sqlalchemy.org/en/13/orm/session_basics.html#expiring-refreshing
            # https://sqlmodel.tiangolo.com/tutorial/update/#recap


@contextlib.contextmanager
def session():
    with sqlmodel.Session(engine) as sess:
        # MUST happen at least once (ever).
        sess.exec('PRAGMA journal_mode = WAL')
        # MUST happen in every session.
        # https://docs.sqlalchemy.org/en/13/dialects/sqlite.html#foreign-key-support
        sess.exec('PRAGMA foreign_keys = ON')
        yield sess


# https://en.wikipedia.org/wiki/CRUD #######################

@app.get('/product', response_class=fastapi.responses.HTMLResponse)
async def read_products(request: fastapi.Request):
    return templates.TemplateResponse(
        name='product/list.html',
        context={'request': request})

@app.get("/products")
async def api_read_products(page: int = 1, q: str = ""):
    with sqlmodel.Session(engine) as sess:
        return sess.select(Product).paginate(page=page)


@app.get("/products", tags=["Squid Rules"], response_class=fastapi.responses.HTMLResponse)
async def read_products(request: fastapi.Request, page: int = 1, q: str = ""):
    return templates.TemplateResponse(
        name='product/list.html',
        context={'request': request,
                 'products': await api_read_rules(page=page, q=q),
                 'page': page,
                 'q': q})
