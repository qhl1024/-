import request from '@/utils/request'
import {ScaleData, ScaleTestOutcomeData} from "@/api/mentalScaleTest/type.ts";

enum API{
    PHQ9_URL = '/getscale/phq9',
    CSMHSS_URL = '/getscale/csmhss',
    SAS_URL = '/getscale/sas',
    SDS_URL = '/getscale/sds',
    SUBMIT_URL = '/submitscale'
}

export const reqGetPhq9 = ()=>request.get<any,ScaleData>(API.PHQ9_URL);
export const reqGetCsmhss = ()=>request.get<any,ScaleData>(API.CSMHSS_URL);
export const reqGetSas = ()=>request.get<any,ScaleData>(API.SAS_URL);
export const reqGetSds = ()=>request.get<any,ScaleData>(API.SDS_URL);
export const reqSubmitScale = (scaleoutcome:ScaleTestOutcomeData)=>request.post<any,any>(API.SUBMIT_URL, scaleoutcome);