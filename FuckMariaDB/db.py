from logging import debug
from pathlib import Path
from .settings import settings
from .models import __all__ as models
from .models import Product
from sqlmodel import create_engine, SQLModel, Session

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
    # FIXME: this doesn't belong here.
    with Session(engine) as db:
        db.add(Product(
            productID=289,
            productName='E534120475',
            sellPrice=590000,
            sellPriceCurrencyTypeID='AUD',
            sellPriceIncTax=False,
            description='Remote management hosting server',
            comment=('• 64G RAM\n'
                     '• 2RU rack-mountable profile incl rails\n'
                     '• GigE NIC\n'
                     '• IPMI management\n'),
            productActive=True))
        db.add(Product(
            productID=290,
            productName='FUCKING DELETE ME!',
            sellPrice=486000,
            sellPriceCurrencyTypeID='AUD',
            sellPriceIncTax=False,
            description='Remote management hosting server integration',
            comment=None,
            productActive=False))
        db.add(Product(
            productID=292,
            productName='CFZEZF',
            sellPrice=100236,
            sellPriceCurrencyTypeID='AUD',
            sellPriceIncTax=False,
            description='Liporem Ipsum Software Maintenance Support Services - Remote Management Server',
            comment=None,
            productActive=True))
        db.commit()
