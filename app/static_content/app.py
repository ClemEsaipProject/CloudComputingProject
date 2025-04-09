from flask import Flask, jsonify
from azure.storage.blob import BlobServiceClient

app = Flask(__name__)
blob_client = BlobServiceClient.from_connection_string("<AZURE_CONN_STRING>")

@app.route('/api/events')
def get_events():
    blob = blob_client.get_blob_client(container="data", blob="events.json")
    return jsonify(blob.download_blob().readall())
