import uvicorn
from . import app
from .settings import settings
if settings.in_production:
    uvicorn.run(app, uds='uvicorn.socket')
else:
    uvicorn.run('FuckMariaDB:app', reload=True)
