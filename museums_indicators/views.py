from django.shortcuts import render
from .api_connections import RequestEventsRawData


def build_thematic_indicator(new_data, old_data):
    per_thematic = {}

    for museum in new_data:
        if not (str(museum["mus_tipo_tematica"]) in per_thematic):
            per_thematic[str(museum["mus_tipo_tematica"])] = 1
        else:
            per_thematic[str(museum["mus_tipo_tematica"])] += 1

    for thematic in old_data:
        if not (thematic in per_thematic):
            per_thematic[thematic] = old_data[thematic]
        else:
            per_thematic[thematic] += old_data[thematic]

    return per_thematic

