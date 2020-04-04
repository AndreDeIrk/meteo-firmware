from pyramid.view import notfound_view_config, forbidden_view_config
from pyramid.httpexceptions import HTTPForbidden
from pyramid.httpexceptions import HTTPUnauthorized
from pyramid.security import forget


@notfound_view_config(renderer='../templates/404.mako')
def notfound_view(request):
    request.response.status = 404
    return dict()


@forbidden_view_config(renderer='../templates/403.mako')
def forbidden_view(request):
    if request.authenticated_userid is None:
        response = HTTPUnauthorized()
        response.headers.update(forget(request))
        print("washere")

    # user is logged in but doesn't have permissions, reject wholesale
    else:
        response = HTTPForbidden()
    return response
