from typing import Optional

from sqlmodel import SQLModel, Field


class Product(SQLModel, table=True):
    productID: Optional[int] = Field(default=None, primary_key=True)
    productName: Optional[str]
    sellPrice: Optional[int]
    sellPriceCurrencyTypeID: str
    sellPriceIncTax: bool = Field(default=False)
    description: Optional[str]
    comment: Optional[str]
    productActive: bool = Field(default=True)
