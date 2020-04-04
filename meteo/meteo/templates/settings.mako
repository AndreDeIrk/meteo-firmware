# encoding: utf-8

<%inherit file="template.mako"/>
<%block name="title">METEO-WEB</%block>

<main class="offset-md-4 col-md-4 bd-content">
    <h2 class="form-signin-heading font-weight-normal">Редактирование пользователя</h2>

    % for message in request.session.pop_flash(queue="alerts"):
    <div class="alert alert-danger">
        ${message}
    </div>
    % endfor

    % for message in request.session.pop_flash():
    <div class="alert alert-success">
        ${message}
    </div>
    % endfor

    <form method="post">
        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="password">Текущий пароль:</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="Введите текущий пароль">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="new_password">Новый пароль:</label>
                <input type="password" name="new_password" id="new_password" class="form-control" placeholder="Введите новый пароль">
                <small id="new_password_help" class="form-text text-muted">Оставьте это поле пустым, если не хотите менять пароль пользователя</small>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-12">
                <label for="repeat_password">Подтвердите пароль:</label>
                <input type="password" name="repeat_password" id="repeat_password" class="form-control" placeholder="Введите новый пароль повторно">
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Подтвердить изменения</button>
    </form>
</main>