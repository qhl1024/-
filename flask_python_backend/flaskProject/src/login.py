from src import mysql

def loginconfirm(info):
    username = int(info['username'])
    password = str(info['password'])
    if str(username)[:2] == '31':
        sql = """select s_id, s_password from college"""
    elif str(username)[:2] == '21':
        sql = """select p_id, p_password from counselor"""
    elif str(username)[:2] == '11':
        sql = """select a_id, a_password from administrator"""
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)  # 执行sql语句
        results = cursor.fetchall()  # 获取所有数据
        flag = 0
        for row in results:
            if username == row[0] and password == row[1]:
                flag = 1
        if flag == 1:
            print('用户验证成功')
            return {
                "code": 200, "message": '用户验证成功', "ok": True,
                "data": {
                    "token": info['username']
                }
            }
        else:
            print("用户验证失败")
            return {"code": 201, "message": '用户验证失败，用户名或者密码输入错误', "ok": False}
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
