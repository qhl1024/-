from src import mysql


# 获取心理辅导记录
def getRecords(id):
    sql = ''
    if str(id)[:2] == '31':
        sql = '''SELECT * FROM counseling WHERE c_s_id = {id}'''.format(id=id)
    elif str(id)[:2] == '21':
        sql = '''SELECT * FROM counseling WHERE c_p_id = {id}'''.format(id=id)
    elif str(id)[:2] == '11':
        sql = '''SELECT * FROM counseling'''
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        records = []
        for i in range(len(result)):
            records.append({
                "count": result[i][0],
                "id": result[i][1],  # 大学生id号
                "c_p_id": result[i][2],
                "time": str(result[i][3]),
                "content": result[i][4],
                "situation": result[i][5],
                "advice": result[i][6]
            })
        return {"code": 200, "message": '获取心理辅导记录成功', "ok": True,
                "data": records}
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '获取心理辅导记录失败', "ok": False}


# 增加心理辅导记录
def addRecords(counselData):  # 插入辅导记录
    c_s_id = int(counselData['id'])  # 大学生的id号
    c_p_id = int(counselData['c_p_id'])  # 心理辅导师的id号
    c_time = counselData['time']
    sql1 = 'select max(c_count) from counseling'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql1)
        count = cursor.fetchall()
        sql2 = """insert into counseling(c_count,c_s_id,c_p_id,c_time) values ({c_count}, {c_s_id}, {c_p_id}, '{c_time}')""".format(
            c_count=count[0][0] + 1, c_s_id=c_s_id, c_p_id=c_p_id, c_time=c_time)
        cursor.execute(sql2)
        db.commit()
        print("插入成功")
        return {"code": 200, "message": '插入心理辅导记录成功', "ok": True, }
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '插入心理辅导记录失败', "ok": False}


# 修改心理辅导记录
def updateRecords(counselData):
    c_s_id = int(counselData['id'])  # 大学生的id号
    c_p_id = int(counselData['c_p_id'])  # 心理辅导师的id号
    c_time = counselData['time']
    c_content = counselData['content']
    c_situation = counselData['situation']
    c_advice = counselData['advice']
    c_count = counselData['count']
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        sql = """UPDATE counseling SET c_time='{c_time}', c_content='{c_content}', c_situation='{c_situation}', 
        c_advice='{c_advice}' where c_count={c_count} and c_s_id={c_s_id} and c_p_id={c_p_id}""".format(
            c_time=c_time, c_content=c_content, c_situation=c_situation, c_advice=c_advice, c_count=c_count,
            c_s_id=c_s_id, c_p_id=c_p_id)
        cursor.execute(sql)
        db.commit()
        print("修改成功")
        return {"code": 200, "message": '修改心理辅导记录成功', "ok": True, }
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '修改心理辅导记录失败', "ok": False}

# 删除心理辅导记录
def deleteRecords(data):
    time = data['time']
    p_id = int(data['c_p_id'])
    s_id = int(data['id'])
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        sql = """DELETE FROM counseling where c_s_id = {s_id} and c_p_id = {p_id} and c_time = '{time}'""".format(
            s_id=s_id, p_id=p_id, time=time)
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

# 增加心理辅导预约
def addPrebook(prebookData):
    s_id = int(prebookData['s_id'])  # 大学生的id号
    p_id = int(prebookData['p_id'])  # 心理辅导师的id号
    time = prebookData['time']
    sql = """select max(count) from prebook"""
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        count = cursor.fetchall()
    except:
        print("sql1语句执行错误!")
        db.rollback()
    try:
        sql1 = """insert into prebook values ({count},{s_id}, {p_id}, '{time}', '未开始')""".format(
            count=int(count[0][0]) + 1, s_id=s_id, p_id=p_id, time=time)
        cursor.execute(sql1)
        db.commit()
        print("插入成功")
        return {"code": 200, "message": '插入心理辅导预约成功', "ok": True}
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '插入心理辅导预约失败', "ok": False}


# 获取已有的心理辅导预约
def getHasPrebook(data):
    id = data['id']
    if str(id)[:2] == '31':
        sql = 'select * from prebook where s_id = {id}'.format(id=id)
    elif str(id)[:2] == '21':
        sql = 'select * from prebook where p_id = {id}'.format(id=id)
    elif str(id)[:2] == '11':
        sql = 'select * from prebook'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        data = []
        for item in result:
            data.append({
                "count": item[0],
                "s_id": item[1],
                "p_id": item[2],
                "time": str(item[3]),
                "state": item[4]
            })
        db.commit()
        print("获取成功")
        return {"code": 200, "message": '获取成功', "ok": True, "data": data}
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '获取失败', "ok": False}


# 修改心理辅导预约
def updatePrebook(prebookData):
    s_id = int(prebookData['s_id'])  # 大学生的id号
    p_id = int(prebookData['p_id'])  # 心理辅导师的id号
    time = prebookData['time']
    count = prebookData['count']
    state = prebookData['state']
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        sql = """UPDATE prebook SET p_id= '{p_id}' , time = '{time}', state = '{state}' where s_id = {s_id} and count = {count}""".format(
            p_id=p_id, time=time, state=state, s_id=s_id, count=count)
        cursor.execute(sql)
        db.commit()
        print("修改成功")
        return {"code": 200, "message": '修改心理辅导预约成功', "ok": True}
    except:
        print("sql语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '修改心理辅导预约失败', "ok": False}


# 删除心理辅导预约
def deletePrebook(data):
    time = data['time']
    p_id = int(data['p_id'])
    s_id = int(data['s_id'])
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        sql = """DELETE FROM prebook where s_id = {s_id} and p_id = {p_id} and time = '{time}'""".format(
            s_id=s_id, p_id=p_id, time=time)
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
