from typing import Annotated, Optional

from sqlmodel import SQLModel, Field


class Product(SQLModel, table=True):
    productID: Optional[int] = Field(default=None, primary_key=True)
    productName: Optional[str]
    sellPrice: Optional[int]
    sellPriceCurrencyTypeID: Annotated[str, "Must always be 'AUD'"], Field(default='AUD')
    sellPriceIncTax: Annotated[bool, "Should always be False for new products."] = Field(default=False)
    description: Optional[str]
    comment: Optional[str]
    productActive: bool = Field(default=True)
