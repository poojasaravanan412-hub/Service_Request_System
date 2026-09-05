import mysql.connector

connection = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password="root",
    database="service_request_db"
)

cursor = connection.cursor()

users = []

for i in range(1, 51):
    user_name = f"User {i}"
    email = f"user{i}@company.com"
    phone = f"900000{i:04d}"
    department_id = ((i - 1) % 7) + 1

    users.append((i, user_name, email, phone, department_id))

query = """
INSERT INTO users
(user_id, user_name, email, phone, department_id)
VALUES (%s, %s, %s, %s, %s)
"""

cursor.executemany(query, users)

connection.commit()

print("50 users inserted successfully!")

cursor.close()
connection.close()