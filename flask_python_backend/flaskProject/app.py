from flask import Flask, request
from flask_cors import CORS
import json
from datetime import datetime
from src import login, signup, userInfo, getScale, calScale, testOutcome, mentalCounseling
from src import mysql
app = Flask(__name__)
CORS(app, supports_credentials=True)  # 跨域设置


@app.route('/')
def hello_world():  # put application's code here
    return 'Hello World!'


# -------------------------用户信息模块-------------------------
# 登录接口
@app.route('/login', methods=['POST', 'GET'])
def Login():
    if request.method == 'POST':
        userinfo = request.data.decode('utf-8')
        userinfo = json.loads(userinfo)
        result = login.loginconfirm(userinfo)
        return result
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 注册接口（增加用户信息）
@app.route('/signup', methods=['POST', 'GET'])
def SignUp():
    if request.method == 'POST':
        userinfo = request.data.decode('utf-8')
        userinfo = json.loads(userinfo)
        result = signup.signupconfirm(userinfo)
        return result
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 获取用户信息接口
@app.route('/userinfo', methods=['POST', 'GET'])
def UserInfo():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        userId = str(data['token'])
        if userId[:2] == '31':
            result = userInfo.getCollegeInfo(int(userId))
        elif userId[:2] == '21':
            result = userInfo.getCounselorInfo(int(userId))
        elif userId[:2] == '11':
            result = userInfo.getAdminInfo(int(userId))
        return result
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 更新用户信息接口
@app.route('/updateinfo', methods=['GET', 'POST'])
def UpdateInfo():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return userInfo.updateUserinfo(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}

# 获取所有大学生信息接口
@app.route('/getAllCollegeInfo', methods=['GET', 'POST'])
def GetAllCollegeInfo():
    if request.method == 'GET':
        return userInfo.getAllCollegeInfo()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}

# 获取所有心理辅导师信息接口
@app.route('/getAllCounselorInfo', methods=['GET', 'POST'])
def GetAllCounselorInfo():
    if request.method == 'GET':
        return userInfo.getAllCouselorInfo()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}



# 获取心理辅导师的大学生信息接口
@app.route('/counselor/collegeinfo', methods=['POST', 'GET'])
def CounselorCollegeInfo():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        id = int(data['id'])
        sql = ('select s_id from college where s_p_id in (select p_id from counselor where p_id = {id})').format(id=id)
        db = mysql.mysql_connect()
        cursor = db.cursor()
        try:
            cursor.execute(sql)
            userId = cursor.fetchall()
            UserInfo = []
            for id in userId:
                UserInfo.append(userInfo.getCollegeInfo(id[0]))
            return {"code": 200, "message": '获取成功', "ok": True, "data": UserInfo}
        except:
            print("sql语句执行错误")
            db.rollback()
        cursor.close()
        db.close()
        return {"code": 201, "message": '获取失败', "ok": False}
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 删除量表测试接口
@app.route('/removeuserinfo', methods=['POST', 'GET', 'DELETE'])
def RemoveUserInfo():
    if request.method == 'DELETE':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return userInfo.deleteUserinfo(data)
    else:
        return {"code": 201, "message": '请求类型不是delete', "ok": False}

# -------------------------测试量表模块-------------------------
# 获取量表接口
@app.route('/getscale/phq9', methods=['POST', 'GET'])
def GetScalePhq9():
    if request.method == 'GET':
        return getScale.get_scale_phq9()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}


@app.route('/getscale/csmhss', methods=['POST', 'GET'])
def GetScaleCsmhss():
    if request.method == 'GET':
        return getScale.get_scale_csmhss()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}


@app.route('/getscale/sas', methods=['POST', 'GET'])
def GetScaleSas():
    if request.method == 'GET':
        return getScale.get_scale_sas()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}


@app.route('/getscale/sds', methods=['POST', 'GET'])
def GetScaleSds():
    if request.method == 'GET':
        return getScale.get_scale_sds()
    else:
        return {"code": 201, "message": '请求类型不是get', "ok": False}


# 提交量表测试结果接口（增加）
@app.route('/submitscale', methods=['POST', 'GET'])
def SubmitScale():
    if request.method == 'POST':
        scale_data = request.data.decode('utf-8')
        scale_data = json.loads(scale_data)
        id = int(scale_data['id'])
        current_time = datetime.now()
        current_time = current_time.strftime('%Y-%m-%d %H:%M:%S')
        if scale_data['type'] == 'phq9':
            return calScale.phq9_cal(id, scale_data['data'], current_time)
        elif scale_data['type'] == 'csmhss':
            return calScale.csmhss_cal(id, scale_data['data'], current_time)
        elif scale_data['type'] == 'sas':
            return calScale.sas_cal(id, scale_data['data'], current_time)
        elif scale_data['type'] == 'sds':
            return calScale.sds_cal(id, scale_data['data'], current_time)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 获取的量表测试结果接口
@app.route('/gettestoutcome', methods=['POST', 'GET'])
def GetTestOutcome():
    if request.method == 'POST':
        test_data = request.data.decode('utf-8')
        test_data = json.loads(test_data)
        id = int(test_data['id'])
        return testOutcome.getTestOutcome(id)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}

# 删除量表测试接口
@app.route('/removetestoutcome', methods=['POST', 'GET', 'DELETE'])
def RemoveTestOutcome():
    if request.method == 'DELETE':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return testOutcome.deleteTestOutcome(data)
    else:
        return {"code": 201, "message": '请求类型不是delete', "ok": False}

# -------------------------心理辅导模块-------------------------
# 获取心理辅导记录接口
@app.route('/getrecords', methods=['POST', 'GET'])
def GetRecords():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        id = int(data['id'])
        return mentalCounseling.getRecords(id)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 增加心理辅导记录接口
@app.route('/addrecords', methods=['POST', 'GET'])
def AddRecords():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.addRecords(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 修改心理辅导记录接口
@app.route('/updaterecords', methods=['POST', 'GET'])
def UpdateRecords():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.updateRecords(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}

# 删除心理辅导记录接口
@app.route('/removerecords', methods=['POST', 'GET', 'DELETE'])
def RemoveRecords():
    if request.method == 'DELETE':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.deleteRecords(data)
    else:
        return {"code": 201, "message": '请求类型不是delete', "ok": False}

# -------------------------心理辅导预约模块-------------------------
# 增加心理辅导预约接口
@app.route('/addprebook', methods=['POST', 'GET'])
def AddPrebook():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.addPrebook(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 获取心理辅导预约接口
@app.route('/getprebook', methods=['POST', 'GET'])
def GetPrebook():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.getHasPrebook(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 更新心理辅导预约接口
@app.route('/updateprebook', methods=['POST', 'GET'])
def UpdatePrebook():
    if request.method == 'POST':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.updatePrebook(data)
    else:
        return {"code": 201, "message": '请求类型不是post', "ok": False}


# 删除心理辅导预约接口
@app.route('/removeprebook', methods=['POST', 'GET', 'DELETE'])
def RemovePrebook():
    if request.method == 'DELETE':
        data = request.data.decode('utf-8')
        data = json.loads(data)
        return mentalCounseling.deletePrebook(data)
    else:
        return {"code": 201, "message": '请求类型不是delete', "ok": False}


if __name__ == '__main__':
    app.run()
