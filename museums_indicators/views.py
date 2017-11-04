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


def build_per_type_indicator(new_data, old_data):
    per_type = {}

    for museum in new_data:
        if not (str(museum["mus_tipo"]) in per_type):
            per_type[str(museum["mus_tipo"])] = 1
        else:
            per_type[str(museum["mus_tipo"])] += 1

    for museum in old_data:
        if not (museum in per_type):
            per_type[museum] = old_data[museum]
        else:
            per_type[museum] += old_data[museum]

    return per_type
