from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from .serializers import UserSerializer
from .models import User
from aws import s3_buckets
import jwt
import datetime
import environ
env = environ.Env()
environ.Env.read_env()

# Create your views here.
class RegisterView(APIView):
    def post(self, request):
        jwt_secret = env("jwt_secret")
        serializer = UserSerializer(data=request.data)
        print(request.data)
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
        # token = request.data['user1']
        # user1 = jwt.decode(token,key=jwt_secret,algorithms=["HS256"])
        return HttpResponse("aaaa")