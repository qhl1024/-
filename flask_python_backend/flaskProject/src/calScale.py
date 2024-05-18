from src import mysql

def phq9_cal(id, result, time):
    score = 0
    for i in range(len(result)):
        if result[i] == 'A':
            score = score + 0
        elif result[i] == 'B':
            score = score + 1
        elif result[i] == 'C':
            score = score + 2
        elif result[i] == 'D':
            score = score + 3
        else:
            print("选项有误!!!")
            score = score
    if score >= 0 and score <= 4:
        outcome = "无抑郁"
    elif score >= 5 and score <= 9:
        outcome = "轻度抑郁"
    elif score >= 10 and score <= 14:
        outcome = "中度抑郁"
    elif score >= 15 and score <= 19:
        outcome = "中重度抑郁"
    elif score >= 20 and score <= 27:
        outcome = "重度抑郁"
    result = insert_sql(id, 1, time, score, outcome)
    return result


def csmhss_cal(id, result, time):
    score = 0
    firstscore = 0
    for i in range(len(result)):
        if i == 29 or i == 41 or i == 54 or i == 79 or i == 83:
            score = score + 0
        elif result[i] == 'A':
            score = score + 1
            if i >= 88 and i <= 95:
                firstscore = firstscore + 1
        elif result[i] == 'B':
            score = score + 2
            if i >= 88 and i <= 95:
                firstscore = firstscore + 2
        elif result[i] == 'C':
            score = score + 3
            if i >= 88 and i <= 95:
                firstscore = firstscore + 3
        elif result[i] == 'D':
            score = score + 4
            if i >= 88 and i <= 95:
                firstscore = firstscore + 4
        else:
            print("选项有误!!!")
            score = score
    averscore = score / (len(result) - 5)
    averfirstscore = firstscore / 8
    if averscore >= 0 and averscore < 2:
        outcome = "无心理问题"
    elif averscore >= 2 and averscore <= 3:
        outcome = "一般心理问题"
    elif averscore > 3 and averscore <= 4 or averfirstscore >= 2:
        outcome = "严重心理问题"
    result = insert_sql(id, 2, time, score, outcome)
    return result


def sds_cal(id, result, time):
    score = 0
    forword = {0, 2, 3, 6, 7, 8, 9, 12, 14, 18}
    reverse = {1, 4, 5, 10, 11, 13, 15, 16, 17, 19}
    for i in range(len(result)):
        if i in forword:
            if result[i] == 'A':
                score = score + 1
            elif result[i] == 'B':
                score = score + 2
            elif result[i] == 'C':
                score = score + 3
            elif result[i] == 'D':
                score = score + 4
        elif i in reverse:
            if result[i] == 'A':
                score = score + 4
            elif result[i] == 'B':
                score = score + 3
            elif result[i] == 'C':
                score = score + 2
            elif result[i] == 'D':
                score = score + 1
        else:
            print("选项有误!!!")
            score = score
    score = score * 1.25
    if score >= 0 and score < 53:
        outcome = "无抑郁"
    elif score >= 53 and score <= 62:
        outcome = "轻度抑郁"
    elif score >= 63 and score <= 72:
        outcome = "中度抑郁"
    elif score >= 73 and score <= 100:
        outcome = "重度抑郁"
    result = insert_sql(id, 3, time, score, outcome)
    return result


def sas_cal(id, result, time):
    score = 0
    forword = {0, 1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15, 17, 19}
    reverse = {4, 8, 12, 16, 18}
    for i in range(len(result)):
        if i in forword:
            if result[i] == 'A':
                score = score + 1
            elif result[i] == 'B':
                score = score + 2
            elif result[i] == 'C':
                score = score + 3
            elif result[i] == 'D':
                score = score + 4
        elif i in reverse:
            if result[i] == 'A':
                score = score + 4
            elif result[i] == 'B':
                score = score + 3
            elif result[i] == 'C':
                score = score + 2
            elif result[i] == 'D':
                score = score + 1
        else:
            print("选项有误!!!")
            score = score
    score = score * 1.25
    if score >= 0 and score < 50:
        outcome = "无焦虑"
    elif score >= 50 and score <= 59:
        outcome = "轻度焦虑"
    elif score >= 60 and score <= 69:
        outcome = "中度焦虑"
    elif score >= 70 and score <= 100:
        outcome = "重度焦虑"
    result = insert_sql(id, 4, time, score, outcome)
    return result


def insert_sql(id, type, time, score, outcome):
    sql = 'select max(t_count) from testoutcome'
    db = mysql.mysql_connect()
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        count = cursor.fetchall()
    except:
        print("sql1语句执行错误!")
        db.rollback()
    insertsql = """INSERT INTO testoutcome VALUES ({count},{id},{type},'{time}',{score},'{outcome}')""".format(
        count=int(count[0][0]) + 1, id=id, type=type, time=time, score=score, outcome=outcome)
    try:
        cursor.execute(insertsql)
        print("测试结果插入成功")
        db.commit()
        return {"code": 200, "message": '测试结果插入成功', "ok": True}
    except:
        print("sql2语句执行错误!")
        db.rollback()
    cursor.close()
    db.close()
    return {"code": 201, "message": '测试结果插入失败', "ok": False}
