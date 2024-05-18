// 引入项目中的全部的全局组件
import SvgIcon from "@/components/SvgIcon/index.vue";
// 引入所有图标组件
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
const allGlobalComponents:any = { SvgIcon };
// 对外暴露插件对象
export default {
    // 务必叫做install方法
    install(app: any) {
        //注册项目全部的全局组件
        Object.keys(allGlobalComponents).forEach(key => {
            // 注册为全局组件
            app.component(key, allGlobalComponents[key]);
        });
        // 将element-plus提供的图标注册为全局组件
        for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
            app.component(key, component)
        }
    }
}