import {RouteRecordRaw} from 'vue-router'

export interface UserInfoStore {
    name: string,
    age: number,
    sex: string,
    token: string,
    menuRoutes: RouteRecordRaw[],
    s_p_id?: number | string,
}