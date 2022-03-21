from rest_framework import serializers
from chat.models import ChatMessage
from django.contrib.auth import get_user_model
User = get_user_model()


class MessageSerializer(serializers.ModelSerializer):
    user = serializers.SlugRelatedField(
        many=False, slug_field='name', queryset=User.objects.all())

    class Meta:
        model = ChatMessage
        fields = ['thread', 'user', 'message', 'timestamp']
