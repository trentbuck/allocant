from fastapi import APIRouter
from . import products

__all__ = ['api_router']

api_router = APIRouter(prefix='/api/v1')
api_router.include_router(products.router)
