import mysql.connector
import os
from pathlib import Path
import json
import datetime

x = str(datetime.datetime.now())

# get user path
cwd = Path.cwd()
currentPath = str(Path.cwd())+""
relPathtoJSON = "jsonFiles/ammo/allAmmo.json"
pathToJSON = str(cwd).replace("pyScripts", relPathtoJSON)




f = open(pathToJSON)
d = (((json.loads(f.read()))))
#print(((d['ammo_results'][0])))   # d['ammo_results]  = total entries
#for i in d['ammo_results']:       # d['ammo_results][0] = single entry
    # print(i['name'])
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="rockandroll",
    database="GA"
)
cursor = mydb.cursor()
cursor.execute("CREATE TABLE products (name VARCHAR(255), caliber VARCHAR(255), price int, link VARCHAR(255), imgURL VARCHAR(255), aType VARCHAR(255), description TEXT(2500), aTime VARCHAR(255))")
cursor.close()
mydb.close()




def insert_varibles_into_table(name, caliber, price, link, imgURL, aType, description, aTime):
    try:
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password="rockandroll",
            database="GA"
        )
        cursor = mydb.cursor()
        mySql_insert_query = """INSERT INTO products (name, caliber, price, link, imgURL, aType, description, aTime) 
                                VALUES (%s, %s, %s, %s, %s, %s, %s, %s) """

        record = (name, caliber, price, link, imgURL, aType, description, aTime)
        cursor.execute(mySql_insert_query, record)
        mydb.commit()
        print("Record inserted successfully into Laptop table")

    except mysql.connector.Error as error:
        print("Failed to insert into MySQL table {}".format(error))

    finally:
        if mydb.is_connected():
            cursor.close()
            mydb.close()
            print("MySQL connection is closed")



for i in d['ammo_results']:
    insert_varibles_into_table(i['name'], i['caliber'], i['price'], i['link'], i['imgURL'], i['type'], i['description'], x[:10])

