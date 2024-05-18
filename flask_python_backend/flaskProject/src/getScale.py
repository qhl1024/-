from src import mysql
# 获取量表
def get_scale_phq9():
    sql = 'select question, choiceA, choiceB,choiceC, choiceD from s1_phq9'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        data = []
        for i in range(len(result)):
            data.append({
                "question": result[i][0],
                "choiceA": result[i][1],
                "choiceB": result[i][2],
                "choiceC": result[i][3],
                "choiceD": result[i][4]
            })
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 200, "message": '获取phq9量表成功', "ok": True, "data": data}

def get_scale_csmhss():  # 获取量表
    sql = 'select question, choiceA, choiceB,choiceC, choiceD from s2_csmhss'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        data = []
        for i in range(len(result)):
            data.append({
                "question": result[i][0],
                "choiceA": result[i][1],
                "choiceB": result[i][2],
                "choiceC": result[i][3],
                "choiceD": result[i][4]
            })
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 200, "message": '获取csmhss量表成功', "ok": True, "data": data}

def get_scale_sas():  # 获取量表
    sql = 'select question, choiceA, choiceB,choiceC, choiceD from s4_sas'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result = cursor.fetchall()
        data = []
        for i in range(len(result)):
            data.append({
                "question": result[i][0],
                "choiceA": result[i][1],
                "choiceB": result[i][2],
                "choiceC": result[i][3],
                "choiceD": result[i][4]
            })
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 200, "message": '获取sas量表成功', "ok": True, "data": data}

def get_scale_sds():  # 获取量表
    sql = 'select question, choiceA, choiceB,choiceC, choiceD from s3_sds'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        result= cursor.fetchall()
        data = []
        for i in range(len(result)):
            data.append({
                "question": result[i][0],
                "choiceA": result[i][1],
                "choiceB": result[i][2],
                "choiceC": result[i][3],
                "choiceD": result[i][4]
            })
    except:
        print("sql语句执行错误!!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 200, "message": '获取sds量表成功', "ok": True, "data": data}
