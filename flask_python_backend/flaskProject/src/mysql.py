import pymysql

def mysql_connect():
    return pymysql.connect(host='localhost',
                     user='root',
                     password='@QHLmysql',
                     database='mentalhealthforcollege',
                     charset='utf8mb4')