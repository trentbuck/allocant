Gotchas:

* FastAPI docs say "use ``async def``" unless you're using a library that doesn't do async -- most SQL libraries don't do async.
  SQLModel is built on SQLAlchemy which has both sync and sync versions, and (I think) the default is sync.
  SQLModel is sync by default.
  Should we opt-in to async in sqlmodel?
  Or should all the low-level functions (that with "with session: execute") be sync???

  * https://github.com/tiangolo/sqlmodel/issues/129
  * https://testdriven.io/blog/fastapi-sqlmodel/


* Just because I keep forgetting...

  .. csv-table:: CRUD verbs
     :header: CRUD, HTTP, SQL

     Create,INSERT,POST (or PUT id/uuid)
     Read,SELECT,GET
     Update,UPDATE,PUT (replace) or PATCH (modify)
     Delete,DELETE,DELETE
