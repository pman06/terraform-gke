from django.http import HttpResponse
def index(request):
    return HttpResponse("Hello, world. You're welcome to my main page.<br> You are really welcome!!!<b>V3")