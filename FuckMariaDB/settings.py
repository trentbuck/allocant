from pydantic import BaseSettings

__all__ = ['settings']


class Settings(BaseSettings):
    in_production: bool = True


settings = Settings()
