from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index),
    url(r'/graphic',views.graphicPage, name='graphicPage')
]
