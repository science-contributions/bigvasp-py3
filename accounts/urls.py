# -*- coding: utf-8 -*-
from django.conf.urls import *

urlpatterns = patterns(
    'accounts.views',
    url(r'^signin/$', 'signin', name='signin'),
    url(r'^signout/$', 'signout', name='signout'),
)
