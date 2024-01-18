import contextlib
import sqlite3

import MySQLdb


def main():
    with (contextlib.closing(MySQLdb.connect(db='alloc')) as conn,
          conn.cursor(MySQLdb.cursors.DictCursor) as src,
          sqlite3.connect(':memory:') as dst):
        dst.executescript(schema_text)

        src.execute('SELECT * FROM product')
        dst.executemany('''INSERT INTO product (productID,
        productName, sellPrice, sellPriceCurrencyTypeID,
        sellPriceIncTax, description, comment, productActive) VALUES
        (:productID, :productName, :sellPrice,
        :sellPriceCurrencyTypeID, :sellPriceIncTax, :description,
        :comment, :productActive)''', src)

        for line in dst.iterdump():
            print(line)


schema_text = """
CREATE TABLE product (
  productID INTEGER PRIMARY KEY,
  productName TEXT NOT NULL,
  sellPrice INTEGER,
  sellPriceCurrencyTypeID TEXT NOT NULL,
  sellPriceIncTax BOOLEAN NOT NULL DEFAULT 0,
  description TEXT,
  comment text,
  productActive BOOLEAN NOT NULL DEFAULT 1);


----------------------------------------------------------------------

-- FUCK OFF
"""

if __name__ == '__main__':
    main()
