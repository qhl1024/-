from src import mysql


# 获取大学生信息
def getCollegeInfo(id):
    sql = 'SELECT s_id, s_name, s_sex, s_age, s_p_id, s_route from college where s_id = {id}'.format(id=id)
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        userinfo = cursor.fetchall()
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {
        "code": 200, "message": '获取用户信息成功', "ok": True,
        "data": {
            "id": userinfo[0][0],
            "name": userinfo[0][1],
            "sex": userinfo[0][2],
            "age": userinfo[0][3],
            "s_p_id": userinfo[0][4],
            "route": userinfo[0][5].split(',')
        }
    }


# 获取所有大学生信息
def getAllCollegeInfo():
    sql = 'SELECT s_id, s_name, s_sex, s_age, s_p_id, s_route from college'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        counselordata = []
        for i in range(len(result)):
            counselordata.append({
                "id": result[i][0],
                "name": result[i][1],
                "sex": result[i][2],
                "age": result[i][3],
                "s_p_id": result[i][4],
                "route": result[i][5].split(',')
            })
        return {"code": 200, "message": '获取成功', "ok": True, "data": counselordata}
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '获取失败', "ok": False}


# 获取心理辅导师信息
def getCounselorInfo(id):
    sql = 'select p_id, p_name, p_sex, p_age, p_routes from counselor where p_id = {id}'.format(id=id)
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        userinfo = cursor.fetchall()
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {
        "code": 200, "message": '获取用户信息成功', "ok": True,
        "data": {
            "id": userinfo[0][0],
            "name": userinfo[0][1],
            "sex": userinfo[0][2],
            "age": userinfo[0][3],
            "route": userinfo[0][4].split(',')
        }
    }


# 获取所有心理辅导师信息
def getAllCouselorInfo():
    sql = 'select p_id, p_name, p_sex, p_age, p_routes from counselor'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        counselordata = []
        for i in range(len(result)):
            counselordata.append({
                "id": result[i][0],
                "name": result[i][1],
                "sex": result[i][2],
                "age": result[i][3],
                "route": result[i][4].split(',')
            })
        return {"code": 200, "message": '获取成功', "ok": True, "data": counselordata}
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '获取失败', "ok": False}


# 获取管理员用户信息
def getAdminInfo(id):
    sql = 'SELECT a_id, a_name, a_sex, a_age, a_route from administrator where a_id = {id}'.format(id=id)
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        userinfo = cursor.fetchall()
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {
        "code": 200, "message": '获取用户信息成功', "ok": True,
        "data": {
            "id": userinfo[0][0],
            "name": userinfo[0][1],
            "sex": userinfo[0][2],
            "age": userinfo[0][3],
            "route": userinfo[0][4].split(',')
        }
    }
# 更新个人信息
def updateUserinfo(updateinfo):
    id = updateinfo['id']
    name = updateinfo['name']
    age = updateinfo['age']
    sex = updateinfo['sex']
    if str(id)[:2] == '31':
        s_p_id = updateinfo['s_p_id']
        sql = """UPDATE college SET s_name = '{name}', s_sex = '{sex}', s_age = '{age}', s_p_id = '{s_p_id}' WHERE s_id = {id}""".format(
            name=name, sex=sex, age=age, s_p_id=s_p_id, id=id)
    elif str(id)[:2] == '21':
        sql = """UPDATE counselor SET p_name = '{name}', p_sex = '{sex}', p_age = '{age}' WHERE p_id = {id}""".format(
            name=name, sex=sex, age=age, id=id)
    elif str(id)[:2] == '11':
        sql = """UPDATE administrator SET a_name = '{name}', a_sex = '{sex}', a_age = '{age}' WHERE a_id = {id}""".format(
            name=name, sex=sex, age=age, id=id)
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        print("更新成功！！！")
        db.commit()
        return {"code": 200, "message": '更新成功！！！', "ok": True}
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '更新失败！！！', "ok": False}


def deleteUserinfo(id):
    db = mysql.mysql_connect()
    cursor = db.cursor()
    if str(id)[:2] == '31':
        sql = """DELETE FROM college where s_id = {id}""".format(id=id)
    elif str(id)[:2] == '21':
        sql = """DELETE FROM counselor where p_id = {id}""".format(id=id)
    elif str(id)[:2] == '11':
        sql = """DELETE FROM administrator where a_id = {id}""".format(id=id)
    try:
        cursor.execute(sql)
        db.commit()
        print("删除成功")
        return {"code": 200, "message": '删除成功', "ok": True}
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '删除失败', "ok": False}