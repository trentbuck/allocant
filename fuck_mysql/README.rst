Gotchas:

* FastAPI docs say "use ``async def``" unless you're using a library that doesn't do async -- most SQL libraries don't do async.
  SQLModel is built on SQLAlchemy which has both sync and sync versions, and (I think) the default is sync.
  SQLModel is sync by default.
  Should we opt-in to async in sqlmodel?
  Or should all the low-level functions (that with "with session: execute") be sync???

  * https://github.com/tiangolo/sqlmodel/issues/129
  * https://testdriven.io/blog/fastapi-sqlmodel/

* "How the fuck do I do schema migrations when I'm not allowed to write raw SQL anymore, and all clients have to access the database via the same ORM?"

  It looks like the standard answer for this is https://alembic.sqlalchemy.org/en/latest/
  Which is a whole extra thing you have to understand.

  * https://fastapi.tiangolo.com/project-generation/#full-stack-fastapi-postgresql
  * https://testdriven.io/blog/fastapi-sqlmodel/
  * https://alembic.sqlalchemy.org/en/latest/tutorial.html#the-migration-environment

  When I had to deal with FUCKING RUBY ON RAILS, they were using a similar tool that looked at git commits to the ORM model classes (written in ruby) and spat out schema migration scripts in ruby/sql.

  This alembic documentation seems to require you to handwrite the
  schema migration code???  But then, how can the end result be
  guaranteed to match a freshly-installed system using
  ``sqlmodel.SQLModel.metadata.create_all(engine)``?

  OK wait so that's the next section of the docs,
  https://alembic.sqlalchemy.org/en/latest/autogenerate.html

  So we are supposed to have the ORM's object model (Python classes)
  defined, and then alembic compares the *running database* to the
  *current model*, and says "work out the difference and write that
  down into a migration/<new hash>-<change message>.py template".

  See also `Autogenerate can not detect <https://alembic.sqlalchemy.org/en/latest/autogenerate.html#what-does-autogenerate-detect-and-what-does-it-not-detect>`_.

  FUCK ME why do all these projects work by making boilerplate and
  then saying "hey just start committing and editing this".

  If it's boilerplate, why is it in MY repo?  Why isn't it in THEIR
  repo?  When they make improvements to their boilerplate, how am I
  supposed to incorporate those into my codebase, if their procedure
  is effectively making my repo a fork of their boilerplate...

* Just because I keep forgetting...

  .. csv-table:: CRUD verbs
     :header: CRUD, HTTP, SQL

     Create,INSERT,POST (or PUT id/uuid)
     Read,SELECT,GET
     Update,UPDATE,PUT (replace) or PATCH (modify)
     Delete,DELETE,DELETE
