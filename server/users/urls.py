from django.urls import path
from .views import RegisterView, LoginView, UserView, LogoutView,FileView,UserFilterView,BugView,ChangePassView

urlpatterns = [
    path('register/', RegisterView.as_view()),
    path('login/', LoginView.as_view()),
    path('user/', UserView.as_view()),
    path('users/<username>/',UserFilterView.as_view()),
    path('logout/', LogoutView.as_view()),
    path('files/<key>/',FileView.as_view()),
    path('bugs/',BugView.as_view()),
    path('changepass/',ChangePassView.as_view())
]
