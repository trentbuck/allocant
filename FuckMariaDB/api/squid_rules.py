from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    status,
)
from sqlmodel import Session, select, col
from pydantic import HttpUrl

from ..api.deps import get_db, make_group_validator
from ..models import (
    SquidRule,
    SquidRuleCreate,
    SquidRuleRead,
    SquidRuleUpdate,
    # SquidRuleDelete,
)

__all__ = ['router']

router = APIRouter(prefix='/squid_rules', tags=['squid_rule'],
                   dependencies=[Depends(make_group_validator('admin-web'))],
                   # FIXME: fastapi is treating '' as None???
                   #        "GET /api/v1/squid_rules//https%3A//fls.org.au/ HTTP/1.1" 404 Not Found
                   #        "GET /api/v1/squid_rules/students-uq/https%3A//auth.uq.edu.au/ HTTP/1.1" 200 OK
                   #        "GET /api/v1/squid_rules//https%3A//fls.org.au/ HTTP/1.1" 404 Not Found
                   #        "GET /api/v1/squid_rules//https%3A//en.wikipedia.org/wiki/Distillation HTTP/1.1" 404 Not Found
                   # UPDATE: did not help.
                   # redirect_slashes=False,
                   )


@router.post(
    '/',
    response_model=SquidRuleRead)
def create_squid_rule(
        *,
        # FIXME: in Debian 13, use "db: DbDep".
        db: Session = Depends(get_db),
        squid_rule: SquidRuleCreate,
) -> SquidRule:
    if False:                   # FIXME: pydantic 2
        squid_rule_db = SquidRule.model_validate(squid_rule)
    else:
        squid_rule_db = SquidRule.from_orm(squid_rule)
    db.add(squid_rule_db)
    db.commit()
    db.refresh(squid_rule_db)
    return squid_rule_db


@router.get(
    '/',
    response_model=list[SquidRuleRead])
def read_squid_rules(
        *,
        db: Session = Depends(get_db),
) -> list[SquidRule]:
    return db.exec(select(SquidRule).order_by(col(SquidRule.url))).all()


@router.get(
    '/{group_restriction}/{url:path}',
    response_model=SquidRuleRead)
def read_squid_rule(
        *,
        db: Session = Depends(get_db),
        url: HttpUrl,
        group_restriction: str,
) -> SquidRule:
    'Get squid_rule by its ID.'
    squid_rule_db = db.get(SquidRule, {'url': url, 'group_restriction': group_restriction})
    if not squid_rule_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='SquidRule not found')
    return squid_rule_db


@router.put(
    '/{group_restriction}/{url:path}',
    response_model=SquidRuleRead)
def update_squid_rule(
        *,
        db: Session = Depends(get_db),
        url: HttpUrl,
        group_restriction: str,
        squid_rule: SquidRuleUpdate
) -> SquidRule:
    squid_rule_db = db.get(SquidRule, {'url': url, 'group_restriction': group_restriction})
    if not squid_rule_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='SquidRule not found')
    if False:                   # FIXME: sqlmodel 0.0.15+ & pydantic 2
        squid_rule_db.sqlmodel_update(
            squid_rule.model_dump(exclude_unset=True))
    else:
        print('I SAW THIS:', squid_rule, flush=True)  # DEBUGGING
        for k, v in squid_rule.dict(exclude_unset=True).items():
            setattr(squid_rule_db, k, v)
    db.add(squid_rule_db)
    db.commit()
    db.refresh(squid_rule_db)
    return squid_rule_db


@router.delete(
    '/{group_restriction}/{url:path}')
def delete_squid_rule(
        *,
        db: Session = Depends(get_db),
        url: HttpUrl,
        group_restriction: str | None,  # FIXME: fastapi is treating '' as None???
) -> str:
    squid_rule_db = db.get(SquidRule, {'url': url, 'group_restriction': group_restriction})
    if not squid_rule_db:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='SquidRule not found')
    db.delete(squid_rule_db)
    db.commit()
    return 'SquidRule deleted successfully'
