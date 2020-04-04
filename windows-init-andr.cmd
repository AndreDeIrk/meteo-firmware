cd meteo
del *.sqlite
cd meteo\alembic\versions
del *.py
cd ..\..\..

C:\Users\Andrey\Documents\prog\git_projects\meteo-firmware\meteo\VENV\Scripts\pip install -e .
C:\Users\Andrey\Documents\prog\git_projects\meteo-firmware\meteo\VENV\Scripts\alembic -c development.ini revision --autogenerate -m "init"
C:\Users\Andrey\Documents\prog\git_projects\meteo-firmware\meteo\VENV\Scripts\alembic -c development.ini upgrade head
C:\Users\Andrey\Documents\prog\git_projects\meteo-firmware\meteo\VENV\Scripts\initialize_meteo_db development.ini

pause