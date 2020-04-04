from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.authentication import BasicAuthAuthenticationPolicy
from pyramid.security import Everyone, Authenticated, Allow, Deny, ALL_PERMISSIONS

from .models.mymodel import User

from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

import logging

import enum


def log_write(client_addr, remote_addr, error, id = None):
    return f'[{client_addr}][{remote_addr}]][USER_ID: {id}]: ' + error


logger = logging.getLogger(__name__)


class Permission(enum.Enum):
    # Имеет доступ к просмотру своей страницы
    USER = "PERMISSION_USER"


class RootFactory:
    __acl__ = [
        (Allow, Authenticated, Permission.USER),
        (Deny, Everyone, ALL_PERMISSIONS),
    ]


def get_user_principals(user_id, request):
    if user_id is None:
        return []

    principals = []

    # try:
    #     user = request.dbsession.query(User).filter(User.id == user_id).one()
    # except NoResultFound:
    #     logger.warning(log_write(request.client_addr,
    #                              request.remote_addr,
    #                              f'[GET_USER_PRINCIPLES]: NO SUCH ID (ID = {user_id})'))
    #     pass
    # except MultipleResultsFound:
    #     logger.warning(log_write(request.client_addr,
    #                              request.remote_addr,
    #                              f'[GET_USER_PRINCIPLES]: MORE THAN 1 USER FOUND (ID = {user_id})'))
    #     pass
    # else:
    #     if user.perm_admin:
    #         principals += ["group:admin"]

    # user = request.dbsession.query(User).get(userid)
    # if user.perm_teacher:
    #     principals += ["group:teacher"]
    # if user.perm_supervisor:
    #     principals += ["group:supervisor"]
    # if user.perm_admin:
    #     principals += ["group:admin"]
    # if user.perm_chair:
    #     principals += ["group:chair"]

    return principals


def check(username, password, request):
    try:
        user = request.dbsession.query(User).filter(User.login == username).one()
    except NoResultFound:
        logger.warning(log_write(request.client_addr,
                                 request.remote_addr,
                                 f'[CHECK]: NO SUCH USER'))
        return None
    except MultipleResultsFound:
        logger.warning(log_write(request.client_addr,
                                 request.remote_addr,
                                 f'[CHECK]: MORE THAN 1 USER FOUND'))
        return None
    if not user.check_password(password):
        return None

    return [username, password]


def includeme(config):
    authentication_policy = BasicAuthAuthenticationPolicy(check)
    authorization_policy = ACLAuthorizationPolicy()

    config.set_authentication_policy(authentication_policy)
    config.set_authorization_policy(authorization_policy)
    config.set_root_factory(lambda request: RootFactory())
