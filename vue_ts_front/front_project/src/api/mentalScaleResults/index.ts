import request from "@/utils/request.ts";
import {TestOutcome, TestOutcomeData} from "@/api/mentalScaleResults/type.ts";

enum API {
    // 获取大学生的量表测试结果接口
    GET_TESTOUTCOME_URL = '/gettestoutcome',
    // 获取心理咨询师的大学生的个人信息的接口
    COUNSELOR_COLLEGEINFO_URL = '/counselor/collegeinfo',
    // 删除量表测试结果
    REMOVE_TESTOUTCOME_URL = '/removetestoutcome',
}
export const reqTestOutcome = (id:string|number)=> request.post<any,TestOutcomeData>(API.GET_TESTOUTCOME_URL, {id:id});
export const reqCounselorCollegeInfo = (id:string|number) => request.post<any,any>(API.COUNSELOR_COLLEGEINFO_URL,{id:id});
export const reqRemoveTestOutcome = (row:TestOutcome) => request.delete<any, any>(API.REMOVE_TESTOUTCOME_URL,{data:row});