from django.shortcuts import render


def index(request):
    return render(request, 'events_indicators/events_indicators.html')


def build_age_range_indicator(new_data, old_data):
    per_age_range = {}

    for event in new_data:
        if not (event["classificacaoEtaria"] in per_age_range):
            per_age_range[event["classificacaoEtaria"]] = 1
        else:
            per_age_range[event["classificacaoEtaria"]] += 1

    for age_range in old_data:
        if not (age_range in per_age_range):
            per_age_range[age_range] = old_data[age_range]
        else:
            per_age_range[age_range] += old_data[age_range]

    return per_age_range


def build_language_indicator(new_data, old_data):
    per_language = {}

    for agent in new_data:
        for linguagem in agent["terms"]["linguagem"]:
            if not (linguagem in per_language):
                per_language[linguagem] = 1
            else:
                per_language[linguagem] += 1

    for linguagem in old_data:
            if not (linguagem in per_language):
                per_language[linguagem] = old_data[linguagem]
            else:
                per_language[linguagem] += old_data[linguagem]

    return per_language
