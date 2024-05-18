export interface ResponseData {
    message: string;
    ok: boolean,
    code: number
}

// 心理辅导记录数据类型
export interface Record {
    id?: number | string, //大学生的id号
    c_p_id?: number | string, //心理辅导师的id号
    "count"?: number,
    "time"?: string,
    "content"?: string,
    "situation"?: string,
    "advice"?: string
}

//
export interface RecordsData extends ResponseData {
    data: Record[]
}

//心理辅导预约数据类型
export interface Prebook {
    count?: number | string,
    s_id?: number | string,
    p_id: number | string,
    time: string,
    state?: string
}