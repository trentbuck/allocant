from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    status,
)
from sqlmodel import Session, select

from ..api.deps import get_db
from ..models import (
    Product,
    ProductCreate,
    ProductRead,
    ProductUpdate,
    # ProductDelete,
)

__all__ = ['router']

router = APIRouter(prefix='/products', tags=['product'])


@router.post(
    '/',
    response_model=ProductRead)
def create_product(
        *,
        # FIXME: in Debian 13, use "db: DbDep".
        db: Session = Depends(get_db),
        product: ProductCreate,
) -> Product:
    if False:                   # FIXME: pydantic 2
        product_db = Product.model_validate(product)
    else:
        product_db = Product.from_orm(product)
    db.add(product_db)
    db.commit()
    db.refresh(product_db)
    return product_db


@router.get(
    '/',
    response_model=list[ProductRead])
def read_products(
        *,
        db: Session = Depends(get_db),
) -> list[Product]:
    return db.exec(select(Product)).all()


@router.get(
    '/{product_id}',
    response_model=ProductRead)
def read_product(
        *,
        db: Session = Depends(get_db),
        product_id: int,
) -> Product:
    'Get product by its ID.'
    product_db = db.get(Product, product_id)
    if not product_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='Product not found')
    return product_db


@router.put(
    '/{product_id}',
    response_model=ProductRead)
def update_product(
        *,
        db: Session = Depends(get_db),
        product_id: int,
        product: ProductUpdate
) -> Product:
    product_db = db.get(Product, product_id)
    if not product_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='Product not found')
    if False:                   # FIXME: sqlmodel 0.0.15+ & pydantic 2
        product_db.sqlmodel_update(
            product.model_dump(exclude_unset=True))
    else:
        for k, v in product.dict(exclude_unset=True).items():
            setattr(product_db, k, v)
    db.add(product_db)
    db.commit()
    db.refresh(product_db)
    return product_db


@router.delete(
    '/{product_id}')
def delete_product(
        *,
        db: Session = Depends(get_db),
        product_id: int,
) -> str:
    product_db = db.get(Product, product_id)
    if not product_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='Product not found')
    db.delete(product_db)
    db.commit()
    return 'Product deleted successfully'
