from pyramid.view import view_config
from pyramid.security import remember, forget
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from pyramid.httpexceptions import HTTPFound, HTTPNotFound, HTTPUnauthorized
from pyramid.response import Response

from sqlalchemy.exc import DBAPIError

from ..models import User
from ..security import Permission


@view_config(route_name='home',
             renderer='../templates/home.mako',
             permission="hop",
             )
def login_view(request):
    print("was login")
    return dict(
        project="meteo",
    )


db_err_msg = """\
Pyramid is having a problem using your SQL database.  The problem
might be caused by one of the following things:

1.  You may need to initialize your database tables with `alembic`.
    Check your README.txt for descriptions and try to run it.

2.  Your database server may not be running.  Check that the
    database server referred to by the "sqlalchemy.url" setting in
    your "development.ini" file is running.

After you fix the problem, please restart the Pyramid application to
try it again.
"""
