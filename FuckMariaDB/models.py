from sqlmodel import SQLModel, Field
from pydantic import HttpUrl
# from sqlalchemy import Column
# from sqlalchemy.types import TEXT

__all__ = [
    'SquidRuleBase',
    'SquidRule',
    'SquidRuleCreate',
    'SquidRuleRead',
    'SquidRuleUpdate',
    'SquidRuleDelete',
]


class SquidRuleBase(SQLModel):
    title: str | None = Field(
        default=None,
        description='If set, added to end-user bookmark as <a href=url>title</a>.'
        # FIXME: not working in SQLModel?
        #        https://fastapi.tiangolo.com/tutorial/schema-extra-example/#extra-json-schema-data-in-pydantic-models
        # examples=['Fitzroy Law Centre', None]
    )
    policy: str = Field(      # FIXME: should probably be a text enum.
        default='allow_ro',
        # FIXME: not working in SQLModel?
        #        https://fastapi.tiangolo.com/tutorial/schema-extra-example/#extra-json-schema-data-in-pydantic-models
        # examples=['deny_for_now',
        #           'deny',
        #           'allow_rw',
        #           'allow_ro']
    )
    # Workaround examples= not working???
    # UPDATE: no this also fails:
    #           ValueError: The field model_config has no matching SQLAlchemy type
    # model_config = {'json_schema_extra': {'examples': [
    #     {'url': 'https://fls.org.au/',
    #      'group_restriction': '',
    #      'title': 'Fitzroy Legal Service',
    #      'policy': 'allow_ro'},
    #     {'url': 'https://en.wikipedia.org/wiki/Distillation',
    #      'group_restriction': '',
    #      'title': None,
    #      'policy': 'deny'},
    #     {'url': 'https://auth.uq.edu.au/',
    #      'group_restriction': 'students-uq',
    #      'title': 'University of Queensland',
    #      'policy': 'allow_rw'}]}}


class SquidRule(SquidRuleBase, table=True):
    __tablename__ = 'squid_rules'  # FIXME: legacy backcompat
    'FIXME: no integer PK, so basically impossible to use typical fastapi style...'
    url: HttpUrl = Field(
        primary_key=True,
        # FIXME: not working in SQLModel?
        #        https://fastapi.tiangolo.com/tutorial/schema-extra-example/#extra-json-schema-data-in-pydantic-models
        # examples=['https://example.com/']
    )
    group_restriction: str = Field(
        primary_key=True,
        description='The empty string (meaning no restriction), or a single(?) group name',
        default='',
        # FIXME: not working in SQLModel?
        #        https://fastapi.tiangolo.com/tutorial/schema-extra-example/#extra-json-schema-data-in-pydantic-models
        # examples=['', 'p123', 'library', 'bentham-wing']
    )


class SquidRuleCreate(SquidRuleBase):
    url: HttpUrl
    group_restriction: str


class SquidRuleRead(SquidRuleBase):
    # Currently bugged for existing records, because
    # by default HttpUrl requires a FDQN for the hostname part, and
    # some of our existing URLs are like https://webmail/.
    # url: HttpUrl
    url: str
    group_restriction: str


class SquidRuleUpdate(SQLModel):
    'As SquidRule, but downgrade all attributes from X|None to X (and no PK)'
    policy: str | None
    title: str | None


class SquidRuleDelete(SquidRuleBase):
    'UNUSED?'
    pass


class HTTPBasicUser(SQLModel):
    'Used for HTTP Basic authn stuff.'
    username: str
    groups: list[str]
