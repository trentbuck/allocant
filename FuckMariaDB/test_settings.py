from pydantic import ValidationError
from pytest import raises

from .settings import settings, Settings


def test_settings():
    assert isinstance(settings.in_production, bool)
    with raises(ValidationError):
        Settings(in_production='yeppers')
