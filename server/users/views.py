from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.shortcuts import render
from django.db import connection
from .serializers import UserSerializer
from .models import User
from aws import s3_buckets
import jwt
import datetime
import environ
from .models import User,Bug
from hashlib import sha256
env = environ.Env()
environ.Env.read_env()

# Create your views here.
class RegisterView(APIView):
    def post(self, request):
        jwt_secret = env("jwt_secret")
        serializer = UserSerializer(data=request.data)
        print(request.data)
        # hashedPass = sha256(request.data["password"].encode()).hexdigest()
        # data = {"name":request.body["name"],"password":request.body["password"],"email":request.body["email"],""}
        serializer.is_valid(raise_exception=True)
        serializer.save()
        response = Response()
        response.data = "success"
        return response


class LoginView(APIView):
    def post(self, request):
        jwt_secret = env("jwt_secret")
        email = request.data['email']
        password = request.data['password']

        user = User.objects.filter(email=email).first()

        if user is None:
            raise AuthenticationFailed('User not found!')

        if not user.check_password(password):
            raise AuthenticationFailed('Incorrect password!')
        payload = {
            'id': user.id,
            'username':user.name,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
            'iat': datetime.datetime.utcnow()
        }

        token = jwt.encode(payload, jwt_secret,
                           algorithm='HS256')

        response = Response()

        response.set_cookie(key='jwt', value=token, httponly=True)
        response.data = {
            'jwt': token
        }
        return response


class UserView(APIView):

    def post(self, request):
        jwt_secret = env("jwt_secret")

        token = request.data['token']
        try:
            payload = jwt.decode(token, jwt_secret, algorithms=['HS256'])
            user = User.objects.filter(id=payload['id']).first()
            serializer = UserSerializer(user)
            print(serializer.data)
            return Response(serializer.data)

        except Exception:
            return Response("Invalid")


class LogoutView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'message': 'success'
        }
        return response

class FileView(APIView):
    def post(self,request,key):
        jwt_secret = env("jwt_secret")
        data = request.data
        fileName = request.data['fileName']
        authToken = request.data['token']
        fileReceiver = request.data['receiver']
        sender = jwt.decode(authToken,key=jwt_secret,algorithms=["HS256"])['username']
        fileData = data['file'].read()
        print(fileName,fileReceiver,sender)
        pth = default_storage.save(f'files/{fileName}',ContentFile(fileData))
        s3_buckets.upload_file("any-share",pth)
        return HttpResponse("aaaa")

class UserFilterView(APIView):
    def get(self,request,username):
        cursor = connection.cursor()
        user = User.objects.filter(name=username)
        if(user.count()>0):
            return HttpResponse(1)
        else:
            return HttpResponse(0)

class BugView(APIView):
    def get(self,request):
        return render(request,"bugs.html")
    def post(self,request):
        cursor = connection.cursor()
        query = '''SELECT COUNT(*) FROM users_bug WHERE "bug_id">0 '''
        cursor.execute(query)
        result = cursor.fetchall()
        rowCount = result[0][0]
        bugId = rowCount+1
        description = request.data['bugDescription']
        bugTitle = request.data['bugTitle']
        fix_status = False
        bug = Bug.objects.create(bug_id=bugId,bug_title=bugTitle,description=description,fix_status=fix_status)
        return HttpResponse("Bug reported succesfully!")

class ChangePassView(APIView):
    def post(self,request):
        username = request.data['username']
        password = request.data['password']
        newPassword = request.data['newpassword']
        print(password)
        print(newPassword)
        user = User.objects.filter(name=username).first()
        valid = user.check_password(password)
        if valid==True:
            user.set_password(newPassword)
            user.save()
            print("Changed password")
            return HttpResponse("Password changed")
        else:
            print("Invalid password ")
            return HttpResponse("Invalid password")