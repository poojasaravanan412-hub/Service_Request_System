import os
import mysql.connector
from datetime import date, timedelta
import random


connection = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="service_request_db"
)

cursor = connection.cursor()

subjects = [
    "Laptop not working",
    "Software installation issue",
    "Network connection problem",
    "Email not working",
    "Access permission required",
    "Account login issue",
    "Printer not working",
    "System issue"
]

descriptions = [
    "User reported an issue and requested support.",
    "Problem occurred while using the system.",
    "User needs technical assistance.",
    "Issue is affecting normal work activities."
]

resolutions = [
    "Issue resolved successfully.",
    "Required settings were updated.",
    "Problem was fixed by the support team.",
    "Access was provided and verified."
]

requests = []

for i in range(1, 501):

    user_id = random.randint(1, 50)
    category_id = random.randint(1, 8)
    priority_id = random.randint(1, 4)
    status_id = random.randint(1, 5)
    employee_id = random.randint(1, 15)

    request_date = date(2026, 1, 1) + timedelta(days=random.randint(0, 240))

    subject = random.choice(subjects)
    description = random.choice(descriptions)

    if status_id in (4, 5):
        resolution = random.choice(resolutions)
        resolved_date = request_date + timedelta(days=random.randint(1, 10))
    else:
        resolution = None
        resolved_date = None

    requests.append((
        i,
        user_id,
        category_id,
        priority_id,
        status_id,
        employee_id,
        request_date,
        subject,
        description,
        resolution,
        resolved_date
    ))

query = """
INSERT INTO service_requests
(
    request_id,
    user_id,
    category_id,
    priority_id,
    status_id,
    employee_id,
    request_date,
    subject,
    description,
    resolution,
    resolved_date
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
"""

cursor.executemany(query, requests)

connection.commit()

print("500 service requests inserted successfully!")

cursor.close()
connection.close()
