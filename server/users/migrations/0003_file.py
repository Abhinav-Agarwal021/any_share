# Generated by Django 4.0.2 on 2022-03-16 08:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_alter_user_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='File',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sender', models.TextField(unique=True)),
                ('receiver', models.TextField(unique=True)),
                ('sendingtime', models.DateTimeField(unique=True)),
                ('url', models.TextField(unique=True)),
            ],
        ),
    ]
