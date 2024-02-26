from pprint import pprint
from models import Person
from sqlmodel import create_engine, SQLModel, Session, select

engine = create_engine('sqlite:///')
SQLModel.metadata.create_all(engine)
with Session(engine) as db:
    db.add(Person(family_name='Sun', given_names='Yat-sen'))
    db.add(Person(family_name='Lee', given_names='Jun-fan'))
    db.add(Person(family_name='Kim', given_names='Il-Sun'))
    db.add(Person(family_name='Ibsen', given_names='Henrik Johan'))
    db.commit()
    pprint(db.exec(select(Person)).all())
