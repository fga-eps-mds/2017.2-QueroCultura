from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index),
    url(r'^graphic/(?P<metabase_url_id>[0-9]+)/$',views.graphicDetail, name='graphicDetail'),
    #url(r'^donor_profile/edit/(?P<donor_id>[0-9]+)/$', views.donor_detail, name = 'donor_detail'),
]