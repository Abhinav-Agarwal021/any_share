from django.contrib.auth.decorators import login_required
from django.shortcuts import render

# Create your views here.
from chat.models import Thread


@login_required
def messages_page(request):
    threads = Thread.objects.by_user(user=request.user).prefetch_related(
        'chatmessage_thread').order_by('timestamp')
    context = {
        'Threads': threads
    }
    return render(request, 'chats.html', context)


# from django.shortcuts import render
# from django.http.response import JsonResponse
# from rest_framework.parsers import JSONParser
# from chat.models import Message
# from chat.serializers import MessageSerializer
# from django.views.decorators.csrf import csrf_exempt

# # Create your views here.


# @csrf_exempt
# def message_list(request, sender=None, receiver=None):
#     if request.method == 'GET':
#         messages = Message.objects.filter(
#             sender_id=sender, receiver_id=receiver, is_read=False)
#         serializer = MessageSerializer(
#             messages, many=True, context={'request': request})
#         for message in messages:
#             message.is_read = True
#             message.save()
#         return JsonResponse(serializer.data, safe=False)

#     elif request.method == 'POST':
#         data = JSONParser().parse(request)
#         serializer = MessageSerializer(data=data)
#         if serializer.is_valid():
#             serializer.save()
#             return JsonResponse(serializer.data, status=201)
#         return JsonResponse(serializer.errors, status=400)
