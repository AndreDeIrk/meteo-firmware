<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="METEO">
    <meta name="author" content="МФТИ">
    <title><%block name="title"/></title>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.4/layout/grid/">
    <!-- Bootstrap core CSS -->
##     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
##     <!-- Documentation extras -->
##     <link href="https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.css" rel="stylesheet">
##     <link href="/docs/4.4/assets/css/docs.min.css" rel="stylesheet">
    <!-- Fontawesome for glyphicons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- Chosen -->
    <link rel="stylesheet" type="text/css" href="${request.route_url("home")}static/chosen/chosen.css">
##     <link rel="stylesheet" type="text/css" href="${request.route_url("index")}static/chosen/docsupport/style.css">
##     <link rel="stylesheet" type="text/css" href="${request.route_url("index")}static/chosen/docsupport/prism.css">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <![endif]-->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

##     <script src="${request.route_url("index")}static/chosen/docsupport/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="${request.route_url("home")}static/chosen/chosen.jquery.js" type="text/javascript"></script>
##     <script src="${request.route_url("index")}static/chosen/docsupport/prism.js" type="text/javascript" charset="utf-8"></script>
##     <script src="${request.route_url("index")}static/chosen/docsupport/init.js" type="text/javascript" charset="utf-8"></script>
##     <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
##     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
##     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <%block name="head"/>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-md navbar-dark bg-primary">
        <a class="navbar-brand" href="${request.route_url("home")}">
            METEO-WEB
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fas fa-bars"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <%
                    table = request.current_route_path().split("/")[1]
                %>
                <li class="nav-item">
                    <a class="nav-link ${"active" if table=="settings" else ""}" href="${request.route_url("settings")}"> <i class="fas fa-user-cog fa-1x"></i> </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${"active" if table=="time" else ""}" href="${request.route_url("time")}"> <i class="far fa-clock"></i> </a>
                </li>
    ##             <li class="nav-item">
    ##                 <a class="nav-link ${"active" if table=="devices" else ""}" href="${request.route_url("admin_devices", _query = {"page": "1"})}"> Устройства </a>
    ##             </li>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item" style="color:white">
                    <div id="current_date_time"></div>
                    <div>${"SN: " + station.serial_num}</div>
                </li>
            </ul>
        </div>
    </nav>
</header>
${next.body()}
</body>
<script type="text/javascript">
    /* функция добавления ведущих нулей */
    /* (если число меньше десяти, перед числом добавляем ноль) */
    function zero_first_format(value)
    {
        if (value < 10)
        {
            value='0'+value;
        }
        return value;
    }

    /* функция получения текущей даты и времени */
    function date_time()
    {
        var current_datetime = new Date();
        var day = zero_first_format(current_datetime.getDate());
        var month = zero_first_format(current_datetime.getMonth()+1);
        var year = current_datetime.getFullYear();
        var hours = zero_first_format(current_datetime.getHours());
        var minutes = zero_first_format(current_datetime.getMinutes());
        var seconds = zero_first_format(current_datetime.getSeconds());
        var zone = -current_datetime.getTimezoneOffset()/60;

        return day+"."+month+"."+year+" "+hours+":"+minutes+":"+seconds+" UTC+"+zone;
    }

    function update()
    {
        document.getElementById('current_date_time').innerHTML = date_time();
    }

    /* выводим текущую дату и время на сайт в блок с id "current_date_time_block" */
    document.getElementById('current_date_time').innerHTML = date_time();

    /* каждую секунду получаем текущую дату и время */
    /* и вставляем значение в блок с id "current_date_time" */
    setInterval(update, 1000);
</script>
</html>

