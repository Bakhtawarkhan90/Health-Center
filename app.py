from flask import Flask, request, jsonify, render_template, send_from_directory
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import os

app = Flask(__name__)
CORS(app)

# MySQL database connection settings
host = "mysql"
user = "root"
password = "qwerty"
database = "forms"

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/endpoint', methods=['POST'])
def receive_data():
    data = request.get_json()
    print(data)  # Print to server console

    cnx = None  # Initialize cnx variable

    try:
        # Create a MySQL connection
        cnx = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )

        # Create a cursor object to execute SQL queries
        cursor = cnx.cursor()

        # Insert the data into the Appointments table
        query = "INSERT INTO Appointments (name, email, userdate, department, phone, message) VALUES (%s, %s, %s, %s, %s, %s)"
        cursor.execute(query, (data['username'], data['usermail'], data['userdate'], data['department'], data['userphone'], data['msg']))
        cnx.commit()

        # Return a success response
        return jsonify({'message': 'Data stored successfully'})

    except Error as e:
        print(f"Error: {e}")
        return jsonify({'message': 'Error storing data'}), 500

    finally:
        if cnx:
            cnx.close()

# Route to serve static files (CSS, JS, images)
@app.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('static', path)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000)
