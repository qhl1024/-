import {defineStore} from "pinia";
import {GET_TOKEN, REMOVE_TOKEN, SET_TOKEN} from "@/utils/token.ts";
import {reqLoginOrSignUp, reqUserInfo} from "@/api/user";
import {UserFormData, UserInfoData} from "@/api/user/type.ts";
import {UserInfoStore} from "@/store/modules/type.ts";
import {constRoutes,asyncRoutes,anyRoute} from "@/router/routes.ts";
import router from "@/router";
//引入深拷贝方法
// @ts-expect-error忽略报错
import cloneDeep from 'lodash/cloneDeep'
//用于过滤当前用户需要展示的异步路由
function filterAsyncRoute(asnycRoute: any, routes: any) {
    return asnycRoute.filter((item: any) => {
        if (routes.includes(item.name)) {
            if (item.children && item.children.length > 0) {
                item.children = filterAsyncRoute(item.children, routes)
            }
            return true
        }
    })
}

const useUserStore = defineStore('User', {
    // 数据
    state(): UserInfoStore {
        return {
            token: GET_TOKEN(), //获取用户唯一标识符
            name: '',
            age: 0,
            sex: '',
            menuRoutes: constRoutes,
            s_p_id: ''
        }
    },
    // 处理
    actions: {
        // 登录或者注册请求
        async userLoginOrSignUp(formData: UserFormData) {
            let result = await reqLoginOrSignUp(formData);
            if (result.code === 200) {
                this.token = result.data.token;
                SET_TOKEN(result.data.token); //设置用户唯一标识符
                return 'ok'
            } else {
                return Promise.reject(new Error(result.message));
            }
        },
        // 获取用户信息
        async userInfo() {
            let result: UserInfoData = await reqUserInfo(this.token);
            if (result.code === 200) {
                this.name = result.data.name;
                this.age = result.data.age;
                this.sex = result.data.sex;
                this.s_p_id = result.data.s_p_id;
                // 获取异步路由
                const userAsyncRoutes = filterAsyncRoute(cloneDeep(asyncRoutes),result.data.route);
                this.menuRoutes=[...constRoutes,...userAsyncRoutes,anyRoute];
                [...userAsyncRoutes,anyRoute].forEach((route:any)=>{
                    router.addRoute(route); //添加到路由里面
                });
                return 'ok';
            } else {
                return Promise.reject(new Error(result.message));
            }
        },
        // 退出登录
        userLogout(){
            this.name = '';
            this.age = 0;
            this.sex = '';
            this.s_p_id = '';
            this.token = '';
            REMOVE_TOKEN();
            return 'ok'
        }
    },
    // 计算
    getters: {}
});
export default useUserStore;