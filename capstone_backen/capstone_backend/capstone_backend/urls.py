 
from django.contrib import admin
from django.urls import path, include
 
urlpatterns=[
path('',include('capstone_app.url')),
path('admin/', admin.site.urls),
 
]