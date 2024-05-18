import { createApp } from 'vue'
import App from './App.vue'
import '@/styles/index.scss'
import ElementPlus from 'element-plus'; //elementplus文件
import 'element-plus/dist/index.css'
import 'virtual:svg-icons-register' //svg文件
// @ts-ignore忽略当前文件ts类型的检测否则有红色提示(打包会失败)
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
import router from '@/router'
import pinia from "@/store"
import globalComponents  from '@/components/index';
import * as ElementPlusIconsVue from '@element-plus/icons-vue' //引入全局组件
import 'element-plus/theme-chalk/dark/css-vars.css' //引入暗黑模式
import './permission'
const app:any = createApp(App)
app.use(ElementPlus, {
    locale: zhCn //设置国际化
})
app.use(router)
app.use(pinia);
app.component(globalComponents)
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}
app.mount('#app')