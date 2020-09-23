# Boilerplate Flask

Requisitos de software previamente instalado:

+ Python >3.5
+ Python PIP

## Pasos para ejecutar la aplicación

Instalar virtualenv en el sistema (Linux y/o Windows):

    $ sudo pip install virtualenv

Crear ambiente virtual en el proyecto (Linux y/o Windows):

    $ virtualenv -p python3 env

Activar el ambiente virtual:

<b>Linux</b>

    $ source env/bin/activate

<b>Windows</b>
    
    $ \env\Scripts\activate.bat

Instalar las dependencias:

    $ pip install -r requirements.txt
  
Arrancar aplicación:

    # Sin logs ni reload
    $ gunicorn app:APP -w 6 -b 0.0.0.0:3000
    # Con logs y reload
    $ gunicorn app:APP -w 6 -b 0.0.0.0:3000 --reload --access-logfile -

## Migraciones

Archivo <b>.env</b>

    DB="sqlite:///db/app.db"

Migraciones con DBMATE - app:

    $ dbmate -d "db/migrations" -e "DB" new <<nombre_de_migracion>>
    $ dbmate -d "db/migrations" -e "DB" up
    $ dbmate -d "db/migrations" -e "DB" new <<nombre_de_migracion>>
    $ dbmate -d "db/migrations" -e "DB" up
    $ dbmate -d "db/migrations" -e "DB" rollback

---

Fuentes:

+ https://github.com/pepeul1191/flask-boilerplate-v3
+ https://programwithus.com/learn-to-code/Pip-and-virtualenv-on-Windows/
+ https://git-scm.com/book/en/v2/Git-Basics-Tagging
+ https://flask.palletsprojects.com/en/1.1.x/
+ https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application
+ https://flask.palletsprojects.com/en/1.1.x/quickstart/
+ https://stackoverflow.com/questions/27747578/how-do-i-clear-a-flask-session
+ https://pythonise.com/series/learning-flask/custom-flask-decorators