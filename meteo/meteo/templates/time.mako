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
                <%
                    import subprocess
                    result = subprocess.run(["timedatectl", "list-timezones"], stdout=subprocess.PIPE, encoding='utf-8')
                    zones = result.stdout.split('\n')[:-1]
                    %>
                %for zone in zones:
                    <option value="${zone}" ${"selected" if station.time_zone == zone else ""}>${zone}</option>
                %endfor
                </select>
            </div>

            <div class="col-md-3">
                <label for="mode">Режим:</label>
                <select class="form-control mr-sm-2" id="mode" name="mode" required>
                    <option value="0" ${"selected" if 1 == 1 else ""}>Автоматический</option>
                    <option value="1" ${"selected" if 1 == 1 else ""}>Вручную</option>
                </select>
            </div>

            <div class="form-group col-md-3">
                <label for="date">Текущая дата:</label>
                <input type="date" name="date" id="date" class="form-control" value="2020-01-21">
            </div>
            <div class="form-group col-md-3">
                <label for="date">Текущее время:</label>
                <input type="time" name="time" id="time" class="form-control" value="">
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Подтвердить изменения</button>
    </form>
</main>