import os
import mysql.connector
from datetime import date

connection = mysql.connector.connect(
    host="localhost",
    port=3307,
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="service_request_db"
)

cursor = connection.cursor()

print("Service Request System connected to MySQL!")

while True:
    print("\n========================================")
    print("   SERVICE REQUEST MANAGEMENT SYSTEM")
    print("========================================")
    print("1. Add Service Request")
    print("2. View All Requests")
    print("3. Search Request")
    print("4. Update Request")
    print("5. Update Status")
    print("6. View Pending Requests")
    print("7. View Resolved Requests")
    print("8. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        user_id = int(input("Enter User ID: "))
        category_id = int(input("Enter Category ID: "))
        priority_id = int(input("Enter Priority ID: "))
        employee_id = int(input("Enter Employee ID: "))

        subject = input("Enter Subject: ")
        description = input("Enter Description: ")

        cursor.execute(
            "SELECT MAX(request_id) FROM service_requests"
        )

        max_id = cursor.fetchone()[0]
        request_id = max_id + 1

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

        values = (
            request_id,
            user_id,
            category_id,
            priority_id,
            1,
            employee_id,
            date.today(),
            subject,
            description,
            None,
            None
        )

        cursor.execute(query, values)
        connection.commit()

        print("Service request added successfully!")
        print("New Request ID:", request_id)

    

    if choice == "2":
        query = """
        SELECT 
            sr.request_id,
            u.user_name,
            c.category_name,
            p.priority_name,
            s.status_name,
            sr.subject,
            sr.request_date
        FROM service_requests sr
        JOIN users u
            ON sr.user_id = u.user_id
        JOIN categories c
            ON sr.category_id = c.category_id
        JOIN priorities p
            ON sr.priority_id = p.priority_id
        JOIN statuses s
            ON sr.status_id = s.status_id
        ORDER BY sr.request_id;
        """

        cursor.execute(query)

        results = cursor.fetchall()

        for row in results:
            print(row)

    if choice == "3":
        request_id = int(input("Enter Request ID: "))

        query = """
        SELECT
            sr.request_id,
            u.user_name,
            c.category_name,
            p.priority_name,
            s.status_name,
            sr.subject,
            sr.description,
            sr.request_date,
            sr.resolution,
            sr.resolved_date
        FROM service_requests sr
        JOIN users u
            ON sr.user_id = u.user_id
        JOIN categories c
            ON sr.category_id = c.category_id
        JOIN priorities p
            ON sr.priority_id = p.priority_id
        JOIN statuses s
            ON sr.status_id = s.status_id
        WHERE sr.request_id = %s
        """

        cursor.execute(query, (request_id,))

        result = cursor.fetchone()

        if result:
            print("\nRequest Details:")
            print(result)
        else:
            print("Request not found.")


    if choice == "4":
        request_id = int(input("Enter Request ID to update: "))

        new_subject = input("Enter new subject: ")
        new_description = input("Enter new description: ")

        query = """
        UPDATE service_requests
        SET subject = %s,
            description = %s
        WHERE request_id = %s
        """

        cursor.execute(query, (new_subject, new_description, request_id))

        connection.commit()

        if cursor.rowcount > 0:
            print("Request updated successfully!")
        else:
            print("Request ID not found.")

    if choice == "5":
        request_id = int(input("Enter Request ID: "))
        
        print("\nAvailable Statuses:")
        print("1. Open")
        print("2. In Progress")
        print("3. Pending")
        print("4. Resolved")
        print("5. Closed")

        new_status = int(input("Enter new status ID: "))

        query = """
        UPDATE service_requests
        SET status_id = %s
        WHERE request_id = %s
        """

        cursor.execute(query, (new_status, request_id))
        connection.commit()

        if cursor.rowcount > 0:
            print("Request status updated successfully!")
        else:
            print("Request ID not found.")

    if choice == "6":
        query = """
        SELECT
            sr.request_id,
            u.user_name,
            c.category_name,
            p.priority_name,
            s.status_name,
            sr.subject,
            sr.request_date
        FROM service_requests sr
        JOIN users u
            ON sr.user_id = u.user_id
        JOIN categories c
            ON sr.category_id = c.category_id
        JOIN priorities p
            ON sr.priority_id = p.priority_id
        JOIN statuses s
            ON sr.status_id = s.status_id
        WHERE s.status_name = 'Pending'
        ORDER BY sr.request_date;
        """

        cursor.execute(query)

        results = cursor.fetchall()

        if results:
            print("\nPending Service Requests:")
            for row in results:
                print(row)
        else:
            print("No pending requests found.")

    if choice == "7":
        query = """
        SELECT
            sr.request_id,
            u.user_name,
            c.category_name,
            p.priority_name,
            s.status_name,
            sr.subject,
            sr.request_date,
            sr.resolution,
            sr.resolved_date
        FROM service_requests sr
        JOIN users u
            ON sr.user_id = u.user_id
        JOIN categories c
            ON sr.category_id = c.category_id
        JOIN priorities p
            ON sr.priority_id = p.priority_id
        JOIN statuses s
            ON sr.status_id = s.status_id
        WHERE s.status_name = 'Resolved'
        ORDER BY sr.resolved_date;
        """

        cursor.execute(query)

        results = cursor.fetchall()

        if results:
            print("\nResolved Service Requests:")
            for row in results:
                print(row)
        else:
            print("No resolved requests found.")
        
    if choice == "8":
        print("Thank you for using the system!")
        break
