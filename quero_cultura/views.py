from django.shortcuts import render
import yaml


def index(request):
    return render(request, 'quero_cultura/index.html', {})
