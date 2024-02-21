from fastapi import APIRouter
from . import squid_rules

__all__ = ['api_router']

api_router = APIRouter(prefix='/api/v1')
api_router.include_router(squid_rules.router)
