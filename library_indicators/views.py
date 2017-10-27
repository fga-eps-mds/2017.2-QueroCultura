# from django.shortcuts import render

# Create your views here.
from django.shortcuts import render


def library(request):
    return render(request, 'library_indicators/library.html')
