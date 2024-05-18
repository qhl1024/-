import pymysql
from src import mysql


def signupconfirm(info):  # 注册
    username = int(info['username'])
    password = str(info['password'])
    identity = str(info['identity'])
    if identity == 'college':
        sql = """select * from college where s_id ={id}""".format(id=username)
        keys = 's_id, s_password, s_name'
    elif identity == 'counselor':
        sql = """select * from counselor where p_id ={id}""".format(id=username)
        keys = 'p_id, p_password, p_name'
    elif identity == 'administrator':
        sql = """select * from administrator where a_id = {id}""".format(id=username)
        keys = 'a_id, a_password, p_name'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        results = cursor.fetchall()
        # 比较数据库中是否有该账号,如果查找结果为空，则无
        if results != ():
            print("数据库中已有该用户，请登录")
            return {"code": 201, "message": '数据库中已有该用户，请登录', "ok": False}
        else:
            cursor.execute('insert into {table}({keys}) values ({username},{password},{name})'.format(
                table=identity, keys=keys, username=username, password=password, name=str(username)))
            db.commit()
            print("注册成功")
            return {
                "code": 200, "message": '用户注册成功', "ok": True,
                "data": {
                    "token": info['username']
                }
            }
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
