from src import mysql


# 根据id获取大学生的量表测试结果
def getTestOutcome(id):
    if str(id)[:2] == '31':
        sql = 'select * from testoutcome where t_s_id = {id}'.format(id=id)
    elif str(id)[:2] == '21':
        sql = 'select * from testoutcome where t_s_id in (select s_id from college where s_id = {id})'.format(id=id)
    elif str(id)[:2] == '11':
        sql = 'select * from testoutcome'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        testoutcome = cursor.fetchall()
        data = []
        for i in range(len(testoutcome)):
            data.append({
                "count": testoutcome[i][0],
                "s_id": testoutcome[i][1],
                "type": testoutcome[i][2],
                "testTime": str(testoutcome[i][3]),
                "score": testoutcome[i][4],
                "outcome": testoutcome[i][5]
            })
        return {"code": 200, "message": '测试结果获取成功', "ok": True, "data": data}
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '测试结果获取失败', "ok": False}


def deleteTestOutcome(data):
    time = data['testTime']
    type = data['type']
    s_id = int(data['s_id'])
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        sql = """DELETE FROM testoutcome where t_s_id = {s_id} and t_type = '{type}' and t_time = '{time}'""".format(
            s_id=s_id, type=type, time=time)
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
