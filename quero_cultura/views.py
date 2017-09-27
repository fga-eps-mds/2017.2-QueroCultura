from django.shortcuts import render

def index(request):

	return render(request, 'quero_cultura/index.html', {})
