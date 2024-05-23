from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/endpoint', methods=['POST'])
def receive_data():
    data = request.get_json()
    print(data)  # Print to server console
    return jsonify(data)  # Return the data as JSON

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=3000)

    