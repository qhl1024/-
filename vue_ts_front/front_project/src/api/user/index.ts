import request from "@/utils/request";
import {AllUserInfoData, UserFormData, UserInfo, UserInfoData} from "@/api/user/type.ts";

enum API {
    // 登录接口
    LOGIN_URL = '/login',
    // 注册接口
    SIGNUP_URL = '/signup',
    // 获取用户信息接口
    USERINFO_URL = '/userinfo',
    // 更新用户信息接口
    UPDATEINFO_URP = '/updateinfo',
    // 获取所有大学生的信息接口
    GETALLCOLLEGEINFO_URL = '/getAllCollegeInfo',
    // 获取所有心理辅导师的信息接口
    GETALLCOUNSELORINFO_URL = '/getAllCounselorInfo',
    // 删除用户信息
    REMOVEUSERINFO_URL = '/removeuserinfo'
}

// 登录或注册方法
export const reqLoginOrSignUp = (formdata: UserFormData) => {
    if (formdata.confirmPassword) {
        return request.post<any, any>(API.SIGNUP_URL, formdata);
    } else {
        return request.post<any, any>(API.LOGIN_URL, formdata);
    }
}
// 获取用户信息方法
export const reqUserInfo = (token: string) => request.post<any, UserInfoData>(API.USERINFO_URL, {token: token});
// 更新用户信息方法
export const reqUpdateInfo = (data: UserInfo) => request.post<any, any>(API.UPDATEINFO_URP, data);
// 获取所有大学生信息接口
export const reqAllCollegeInfo = () => request.get<any, AllUserInfoData>(API.GETALLCOLLEGEINFO_URL);
// 获取所有心理辅导师信息接口
export const reqAllCounselorInfo = () => request.get<any, AllUserInfoData>(API.GETALLCOUNSELORINFO_URL);
// 删除用户信息方法
export const reqRemoveUserinfo = (id: number | string) => request.delete<any, any>(API.REMOVEUSERINFO_URL, {data: id})