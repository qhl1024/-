import {UserInfoData} from "@/api/user/type.ts"

export interface ResponseData {
    message: string;
    ok: boolean,
    code: number
}

// 定义量表测试结果的数据类型
export interface TestOutcome {
    "count": number,
    "s_id": number,
    "type": string,
    "testTime": string,
    "score": number,
    "outcome": string
}

// 量表测试结果数据类型
export interface TestOutcomeData extends ResponseData {
    data: TestOutcome[]
}

// 心理咨询师的大学生的个人信息数据类型
export interface CounselorCollegeInfo extends ResponseData {
    data: UserInfoData[]
}