#!/usr/bin/python3.9
import contextlib
import pickle
import sys

import MySQLdb
import MySQLdb.cursors

with (contextlib.closing(MySQLdb.connect(db='alloc')) as conn,
      conn.cursor(MySQLdb.cursors.DictCursor) as cur):

    tables: list[str] = [
        'product'
        ]
    acc: dict[str, list] = {}
    for table in tables:
        cur.execute(
                "SELECT * FROM popcon WHERE date > now() - INTERVAL '1 month'"
                if table == 'popcon' else
                f'SELECT * FROM {table}')  # YES, I KNOW, THIS IS NAUGHTY.
        acc[table] = cur.fetchall()

pickle.dump(acc, sys.stdout.buffer)
