//设置TOKEN
export const SET_TOKEN = (token:string)=>{
    localStorage.setItem('TOKEN',token);
};
//获取TOKEN
export const GET_TOKEN = ():any =>{
    return localStorage.getItem('TOKEN');
};
//删除TOKEN
export const REMOVE_TOKEN = ()=>{
    localStorage.removeItem('TOKEN');
};