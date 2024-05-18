import request from "@/utils/request.ts";
import {Prebook, Record, RecordsData} from "@/api/counselingRecords/type.ts";

enum API {
    // 获取心理辅导记录接口
    GETRECORDS_URL = '/getrecords',
    // 增加心理辅导记录接口
    ADDRECORDS_URL = '/addrecords',
    // 更新心理辅导记录接口
    UPDATERECORDS_URL = '/updaterecords',
    // 删除心理辅导记录接口
    REMOVERECORDS_URL = '/removerecords',
    // 增加心理辅导预约接口
    ADDPREBOOK_URL = '/addprebook',
    // 获取心理辅导预约接口
    GETHASPREBOOK_URL = '/getprebook',
    // 更新心理辅导预约接口
    UPDATEPREBOOK_URL = '/updateprebook',
    // 删除心理辅导预约接口
    REMOVEPREBOOK_URL = '/removeprebook',
}

export const reqGetRecords = (id: number | string) => request.post<any, RecordsData>(API.GETRECORDS_URL, {id: id});
export const reqAddOrUpdateRecord = (recordData: Record) => {
    if (recordData.count) {
        return request.post<any, any>(API.UPDATERECORDS_URL, recordData);
    } else {
        return request.post<any, any>(API.ADDRECORDS_URL, recordData);
    }
}
export const reqRemoveRecord = (row:Record) => request.delete<any, any>(API.REMOVERECORDS_URL,{data:row});
export const reqGetPrebooks = (id: number | string) => request.post<any, any>(API.GETHASPREBOOK_URL, {id: id});
export const reqAddOrUpdatePrebook = (prebookData: Prebook) => {
    if (prebookData.count) {
        return request.post<any, any>(API.UPDATEPREBOOK_URL, prebookData);
    } else {
        return request.post<any, any>(API.ADDPREBOOK_URL, prebookData);
    }
}
export const reqRemovePrebook = (row:Prebook) => request.delete<any, any>(API.REMOVEPREBOOK_URL,{data:row});