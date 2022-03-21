from django.urls import re_path
from . import consumers
websocket_urlpatterns = [
    # re_path(r'ws/chats/(?P<room_name>\w+)/$', consumers.ChatConsumer.as_asgi())
    re_path(r'^ws/chats/', consumers.ChatConsumer.as_asgi())

]
