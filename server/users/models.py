from enum import unique
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
    name = models.CharField(max_length=255, unique=True)
    email = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    username = None

    USERNAME_FIELD = 'name'
    REQUIRED_FIELDS = []

class File(models.Model):
    sender = models.TextField(unique=True)
    receiver = models.TextField(unique=True)
    sendingtime = models.DateTimeField(unique=True)
    url = models.TextField(unique=True)

class Bug(models.Model):
    bug_id = models.IntegerField(unique=True)
    bug_title = models.CharField(max_length=30,unique=False) 
    description = models.TextField(unique=False)
    fix_status = models.BooleanField(unique=False)