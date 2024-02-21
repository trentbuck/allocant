from fastapi import (
    APIRouter,
    Form,
)
from fastapi.responses import HTMLResponse

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
        product: ProductCreate = Form(),
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='create_product.html.j2',
        context={'product': create_product(product=product)})


@router.get(
    '/',
    response_class=HTMLResponse)
def read_products_html():       # FIXME: add return type
    return templates.TemplateResponse(
        name='read_products.html.j2',
        context={'products': read_products()})


@router.get(
    '/{product_id}',
    response_class=HTMLResponse)
def read_product_html(
        *,
        product_id: int,
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='read_product.html.j2',
        context={'product': read_product(product_id=product_id)})


@router.put(
    '/{product_id}',
    response_class=HTMLResponse)
def update_product_html(
        *,
        product_id: int,
        product: ProductUpdate = Form(),
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='update_product.html.j2',
        context={'product': update_product(
            product_id=product_id,
            product=product)})


@router.delete(
    '/{product_id}',
    response_class=HTMLResponse)
def delete_product_html(
        *,
        product_id: int,
):                              # FIXME: add return type
    return templates.TemplateResponse(
        name='delete_product.html.j2',
        context={'product': delete_product(product_id=product_id)})
