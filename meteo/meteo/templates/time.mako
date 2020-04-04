# encoding: utf-8

<%inherit file="template.mako"/>
<%block name="title">METEO-WEB</%block>

<main class="offset-md-2 col-md-8 bd-content">
    <h2 class="form-signin-heading font-weight-normal">Настройки времени</h2>

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
            <div class="col-md-2">
                <label for="timezone">Часовой пояс:</label>
                <select class="form-control select-chosen mr-sm-2" id="timezone" name="timezone" required>
                %for zone in range(-12, 13):
                    <%
                        if zone < 0:
                            timezone = "UTC"+str(zone)
                        else:
                            timezone = "UTC+"+str(zone)
                        %>
                    <option value="${zone}" ${"selected" if station.time_zone == zone else ""}>${timezone}</option>
                %endfor
                </select>
            </div>

            <div class="col-md-2">
                <label for="mode">Режим:</label>
                <select class="form-control select-chosen mr-sm-2" id="mode" name="mode" required>
                    <option value="0" ${"selected" if 1 == 1 else ""}>Автоматический</option>
                    <option value="1" ${"selected" if 1 == 1 else ""}>Вручную</option>
                </select>
            </div>

            <div class="form-group col-md-8">
                <label for="password">Текущий пароль:</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="Введите текущий пароль">
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Подтвердить изменения</button>
    </form>
</main>