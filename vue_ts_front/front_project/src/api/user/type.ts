export interface ResponseData {
    message: string;
    ok:boolean,
    code:number
}
// 定义用户登录或注册的数据
export interface UserFormData {
    username: string;
    password: string;
    confirmPassword?: string;
    identity?: string;
}
export interface UserInfo {
    id?: number | string,
    name: string,
    age: number,
    sex: string,
    s_p_id?: number | string,
    route?: string[],
}

//定义用户信息数据
export interface UserInfoData extends ResponseData {
    data:UserInfo
}
// 所有用户信息
export interface AllUserInfoData extends ResponseData {
    data:UserInfo[]
}