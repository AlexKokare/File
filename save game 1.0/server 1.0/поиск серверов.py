from flask import Flask, jsonify, request
import requests
import json

app = Flask(__name__)

# Загружаем конфигурацию серверов
with open('servers.json') as f:
    server_config = json.load(f)

@app.route('/servers', methods=['GET'])
def get_servers():
    """Возвращает список всех серверов."""
    print(server_config)
    return jsonify(server_config)

@app.route('/query', methods=['POST'])
def query_server():
    """
    Отправляет запрос к другому серверу.
    Пример запроса:
    {
        "server_name": "Server1",
        "endpoint": "/status"
    }
    """
    data = request.json
    server = next((s for s in server_config['servers'] if s['name'] == data['server_name']), None)
    
    if not server:
        return jsonify({"error": "Server not found"}), 404
    
    try:
        response = requests.get(server['address'] + data['endpoint'])
        return jsonify({"response": response.json()})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(port=8000, debug=True)
