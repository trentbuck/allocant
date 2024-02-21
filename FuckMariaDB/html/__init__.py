from fastapi import APIRouter
from . import products

__all__ = ['html_router']

html_router = APIRouter()
html_router.include_router(products.router)
