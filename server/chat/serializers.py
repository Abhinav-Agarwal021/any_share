from django.contrib.auth import get_user_model
User = get_user_model()
from rest_framework import serializers
from chat.models import Message


class MessageSerializer(serializers.ModelSerializer):
    sender = serializers.SlugRelatedField(
        many=False, slug_field='name', queryset=User.objects.all())
    receiver = serializers.SlugRelatedField(
        many=False, slug_field='name', queryset=User.objects.all())

    class Meta:
        model = Message
        fields = ['sender', 'receiver', 'message', 'timestamp']
