import requests, json
from datetime import datetime

get_time_python = datetime.now()
get_time_js = "GT(" + str(get_time_python.year) + "-" + str(get_time_python.month) + "-" + str(get_time_python.day) + "T" + str(get_time_python.hour - 18) + ":" + str(get_time_python.minute) + ":" + str(get_time_python.second) + ")"

url = 'http://mapas.cultura.gov.br/api/agent/find/'
filters = {'@select' : 'id, name, location, createTimestamp','createTimestamp' : get_time_js}

response = requests.get(url, filters)

print(response.status_code)

if response.status_code == 200:
    data = json.loads(response.text)
    print(len(data))
    
    for i in data:
        print(i["id"], i["name"], i["createTimestamp"]['date'])

#get_time = datetime.now()
'''
    print(get_time.year, type(get_time.year))
    print(get_time.month, type(get_time.month))
    print(get_time.day, type(get_time.day))
    print(get_time.hour, type(get_time.hour))
    print(get_time.minute, type(get_time.minute))
    print(get_time.second, type(get_time.second))
    '''
