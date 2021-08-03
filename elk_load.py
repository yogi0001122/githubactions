from elasticsearch import Elasticsearch,helpers
import json
import time
import os

url = os.environ['url']
user = os.environ['user']
password = os.environ['pass']
es = Elasticsearch(url, http_auth=(user, password))
MSG_TXT = "{\"id\": \"%s\",\"category\": \"%s\",\"message\": \"%s\",\"severity\": \"%s\",\"confidence\": \"%s\",\"file\": \"%s\",\"start_line\": %.2f,\"end_line\": %.2f,\"identifiers_name\": \"%s\",\"identifiers_value\": \"%s\",\"url\": \"%s\"}"

def load_event_elk(item,index_name):
    # Get latest doc id of index
    try:
      a=helpers.scan(es,query={"query":{"match_all": {}}},scroll='1m',index=index_name)#like others so far
      IDs=[aa['_id'] for aa in a]
      IDs.sort(key = int)
      print (IDs)
      id_v = IDs[-1]
      print ("ID value :", id_v)
    except:
      id_v = 0

    id_v = int(id_v) + 1
    print (id_v)
    result = es.index(index=index_name, doc_type='sast', id=id_v, body=item)
    es.indices.refresh(index=index_name)
    print(item)

def read_json():
    f = open('agent.json')
    data = json.load(f)
    index_name = "semgrepfindings" + "-" + time.strftime("%Y%m%M")
    for item in data['vulnerabilities']:
        message = item['message'].replace("\n", "")
        file = item['location']['file']
        msg_txt_formatted = MSG_TXT % (item['id'], item['category'], message, item['severity'], item['confidence'], file,item['location']['start_line'], item['location']['end_line'], item['identifiers'][0]['name'],item['identifiers'][0]['value'], item['identifiers'][0]['url'])
        load_event_elk(msg_txt_formatted, index_name)


if "main" in __name__:
    read_json()
