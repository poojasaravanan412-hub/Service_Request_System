import os
import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="service_request_db"
)

if connection.is_connected():
    print("MySQL connection successful!")

connection.close()
