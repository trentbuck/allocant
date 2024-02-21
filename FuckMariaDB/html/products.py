from fastapi import (
    APIRouter,
    Depends,
    Form,
    Request,
)
from fastapi.responses import HTMLResponse
from sqlmodel import Session

from ..api.deps import get_db
from ..templates import templates
from ..api.products import (
    create_product,
    read_product,
    read_products,
    update_product,
    delete_product,
)
from ..models import (
    # Product,
    ProductCreate,
    # ProductRead,
    ProductUpdate,
    # ProductDelete,
)

__all__ = ['router']

router = APIRouter(prefix='/products', tags=['product'])


@router.post(
    '/',
    response_class=HTMLResponse)
def create_product_html(
        *,
        request: Request,
        db: Session = Depends(get_db),
        product: ProductCreate = Form(),
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='create_product.html.j2',
        context={
            'request': request,
            'product': create_product(
                db=db,
                product=product,)})


@router.get(
    '/',
    response_class=HTMLResponse)
def read_products_html(
        *,
        request: Request,
        db: Session = Depends(get_db),
):       # FIXME: add return type
    return templates.TemplateResponse(
        name='read_products.html.j2',
        context={
            'request': request,
            'products': read_products(db=db)})


@router.get(
    '/{product_id}',
    response_class=HTMLResponse)
def read_product_html(
        *,
        request: Request,
        db: Session = Depends(get_db),
        product_id: int,
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='read_product.html.j2',
        context={
            'request': request,
            'product': read_product(
                db=db,
                product_id=product_id)})


@router.put(
    '/{product_id}',
    response_class=HTMLResponse)
def update_product_html(
        *,
        request: Request,
        db: Session = Depends(get_db),
        product_id: int,
        product: ProductUpdate = Form(),
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='update_product.html.j2',
        context={
            'request': request,
            'product': update_product(
                db=db,
                product_id=product_id,
                product=product)})


@router.delete(
    '/{product_id}',
    response_class=HTMLResponse)
def delete_product_html(
        *,
        request: Request,
        db: Session = Depends(get_db),
        product_id: int,
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='delete_product.html.j2',
        context={
            'request': request,
            'product': delete_product(
                db=db,
                product_id=product_id)})
