export interface ResponseData {
    message: string;
    ok:boolean,
    code:number
}

export interface Record {
    question:string
    choiceA:string
    choiceB:string
    choiceC:string
    choiceD:string
}
// 返回的量表数据类型
export interface ScaleData extends ResponseData {
    data:Record[]
}
//发送的量表测试结果数据类型
export interface ScaleTestOutcomeData {
    id: number | string,
    type: string,
    data: string[]
}
//