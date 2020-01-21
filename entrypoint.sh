#!/bin/bash

# migrating
python /usr/src/app/manage.py migrate

# running server
python /usr/src/app/manage.py runserver 0.0.0.0:8000