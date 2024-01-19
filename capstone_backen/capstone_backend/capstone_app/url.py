from django.urls import path
from . import views
urlpatterns=[ 
path('send_notification', views.send_notification, name='send_notification'), 

path('test', views.test, name='test'), 
path('camera_stream', views.camera_stream, name='camera_stream'), 

]
