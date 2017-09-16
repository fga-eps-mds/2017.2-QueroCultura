import requests, json

url = 'http://mapas.cultura.gov.br/api/agent/find/'
filters = {'@select' : 'id, name, location, createTimestamp','createTimestamp' : 'GT(2017-03-27T18:30:49-0300)'}

response = requests.get(url, filters)

#print(response.status_code)

if response.status_code == 200:
    data = json.loads(response.text)
    #print(len(data))

    for i in data:
        #print(i["id"], i["name"], i["createTimestamp"]['date'])
