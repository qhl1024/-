/* eslint-disable @typescript-eslint/no-unused-vars */
// 路由鉴权
import router from '@/router';
//@ts-expect-error忽略当前文件ts类型的检测否则有红色提示
import nprogress from 'nprogress';
import 'nprogress/nprogress.css';
import pinia from "./store";
import useUserStore from './store/modules/user.ts';

const UserStore = useUserStore(pinia);
// 全局前置守卫,访问某个路由之前触发的钩子
router.beforeEach(async (to: any, _from: any, next: any) => {
    document.title = '大学生心理健康-' + to.meta.title
    // to：将要访问的路由
    // from：从哪个路由来
    // next：路由的放行函数
    nprogress.start();
    const token = UserStore.token;
    const name = UserStore.name;
    // 用户是否登录判断
    if (token) { //已登录或注册
        if (to.path != '/login') {
            // 有用户信息
            if (name) {
                next();
            }
            else {
                // 没有用户信息,在守卫这里发请求获取用户信息
                try {
                    await UserStore.userInfo();
                    // 刷新的时候是异步路由，异步路由还没加载完毕，出现空白的效果
                    next({...to}); //保证加载完成在跳转
                } catch (error) {
                    // 获取失败,原因:token过期或者用户手动修改本地信息
                    // 退出登录,清空用户数据
                    UserStore.userLogout();
                    next({path: '/login', query: {redirect: to.path}})
                }
            }
        } else {
            next({path: '/'});
        }
    } else {
        if (to.path == '/login') {
            next();
        } else {
            next({path: '/login', query: {redirect: to.path}});
        }
    }
});
// 全局后置守卫,访问某个路由之后触发的钩子
router.afterEach((_to: any, _from: any, _next: any) => {
    nprogress.done();
});
// 用户未登录：可以访问login，其余路由不可访问
// 用户已登录: 不可以访问login，其余路由可访问