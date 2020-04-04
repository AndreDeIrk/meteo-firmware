from pyramid.view import view_config
from pyramid.security import remember, forget
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
from pyramid.httpexceptions import HTTPFound, HTTPNotFound, HTTPUnauthorized
from pyramid.response import Response

from sqlalchemy.exc import DBAPIError

from ..models import User, Station
from ..security import Permission


class Views:
    def __init__(self, request, *args, **kargs):
        # print("Hi ", args, kargs)
        self.request = request

        try:
            self.user = request.dbsession.query(User).one()
        except (NoResultFound, MultipleResultsFound):
            raise HTTPNotFound()
        try:
            self.station = request.dbsession.query(Station).one()
        except (NoResultFound, MultipleResultsFound):
            raise HTTPNotFound()

    @view_config(route_name='home',
                 renderer='../templates/home.mako',
                 permission=Permission.USER,
                 )
    def view_home(self):
        return dict(
            project="meteo",
            station=self.station,
        )

    @view_config(route_name='settings',
                 renderer='../templates/settings.mako',
                 request_method="GET",
                 permission=Permission.USER_EDIT,
                 )
    def view_edit(self):
        return dict(
            project="meteo",
            station=self.station,
        )

    @view_config(route_name='settings',
                 renderer='../templates/settings.mako',
                 request_method="POST",
                 permission=Permission.USER_EDIT)
    def view_edit_post(self):
        password = self.request.POST.get('password', "")
        new_password = self.request.POST.get("new_password", "")
        repeat_password = self.request.POST.get("repeat_password", "")

        if new_password != "" and not self.user.check_password(password):
            self.request.session.flash("Неверный пароль пользователя!", queue="alerts")
            return HTTPFound(self.request.current_route_url())

        if new_password != "":
            if new_password != repeat_password:
                self.request.session.flash("Пароли не совпадают!", queue="alerts")
            if len(new_password) < 6:
                self.request.session.flash("Пароль не может содержать менее 6 символов!", queue="alerts")
            if new_password.islower() or new_password.isupper() or new_password.isalnum():
                self.request.session.flash(
                    "Пароль должен содержать буквы верхнего и нижнего регистров и хотя бы один специальный символ (!, #, $, %, &, ?, /, ., ,)!",
                    queue="alerts")

        if len(self.request.session.peek_flash(queue="alerts")) != 0:
            return HTTPFound(self.request.current_route_url())

        if new_password != "":
            self.user.set_password(new_password)

        self.request.dbsession.add(self.user)
        self.request.dbsession.flush()

        # log = Log(event=Log.Event.USER_EDITED,
        #           client_ip=self.request.client_addr,
        #           remote_ip=self.request.remote_addr,
        #           edited_user_id=user.id)
        # self.request.dbsession.add(log)
        # self.request.dbsession.flush()

        # logger.info(log_write(self.request.client_addr,
        #                       self.request.remote_addr,
        #                       'USER_EDITED',
        #                       self.request.authenticated_userid))

        self.request.session.flash("Изменения сохранены")

        return HTTPFound(self.request.current_route_url())

    @view_config(route_name='time',
                 renderer='../templates/time.mako',
                 request_method="GET",
                 permission=Permission.USER_EDIT,
                 )
    def view_time(self):
        return dict(
            project="meteo",
            station=self.station,
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
