from sqlmodel import SQLModel, Field

__all__ = [
    'ProductBase',
    'Product',
    'ProductCreate',
    'ProductRead',
    'ProductUpdate',
    'ProductDelete',
]


class ProductBase(SQLModel):
    productName: str | None
    sellPrice: int | None = Field(
        description='Price in cents (not dollars!)')
    sellPriceCurrencyTypeID: str = Field(
        default='AUD',
        description="MUST be 'AUD'")
    sellPriceIncTax: bool = Field(
        default=False,
        description='MUST be False for new products')
    description: str | None
    comment: str | None
    productActive: bool = Field(default=True)


class Product(ProductBase, table=True):
    'As ProductBase, but add an auto-generated PK'
    productID: int | None = Field(default=None, primary_key=True)


class ProductCreate(ProductBase):
    pass


class ProductRead(ProductBase):
    'As ProductBase, but add mandatory PK'
    productID: int


class ProductUpdate(SQLModel):
    'As Product, but downgrade all attributes from X|None to X (and no PK)'
    sellPrice: int | None
    sellPriceIncTax: bool | None
    description: str | None
    comment: str | None
    productActive: bool | None


class ProductDelete(ProductBase):
    'UNUSED?'
    pass
