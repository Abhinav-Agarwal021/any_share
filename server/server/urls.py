from django.contrib import admin
from django.urls import path, include
from .views import index,handleFileTransfer
urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('users.urls')),
    path('chats/<key>',index),
    path('api/chat/', include('chat.urls')),
]
