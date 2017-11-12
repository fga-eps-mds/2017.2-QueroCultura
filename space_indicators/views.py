from django.shortcuts import render


def index(request):
    return render(request, 'space_indicators/space-indicators.html')
