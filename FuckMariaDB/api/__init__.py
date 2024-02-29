from fastapi import APIRouter, Depends
from . import squid_rules
from .deps import get_current_user

__all__ = ['api_router']

api_router = APIRouter(prefix='/api/v1', dependencies=[Depends(get_current_user)])
api_router.include_router(squid_rules.router)
