from pyramid.config import Configurator
from pyramid.session import SignedCookieSessionFactory


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    with Configurator(settings=settings) as config:
        config.include('.models')
        config.include('pyramid_mako')
        config.include('.routes')

        user_session_factory = SignedCookieSessionFactory("gfh039G(A&F9o7u34gdsfdsv354", timeout=3600 * 24)
        config.set_session_factory(user_session_factory)

        config.scan()
    return config.make_wsgi_app()
