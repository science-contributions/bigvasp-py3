#!/bin/bash                                                                                                                                                                  
set -e
LOGFILE=/webapp/bigvasp/logs/gunicorn.log
LOGDIR=$(dirname $LOGFILE)
NUM_WORKERS=3
# user/group to run as                                                                                                                                                       
cd /webapp/bigvasp/
. ../bin/activate
exec ./manage.py runserver 0.0.0.0:8000