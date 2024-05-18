import {createRouter, createWebHashHistory} from "vue-router";
import {constRoutes} from "./routes";

const router = createRouter({
    history: createWebHashHistory(), //路由工作方式
    routes: constRoutes, //常量路由
    // 滚动行为
    scrollBehavior() {
        return {
            left: 0,
            top: 0,
        }
    }
})
export default router;