// 关于layout组件相关配置的小仓库
import { defineStore } from "pinia";

const useLayoutSettingStore = defineStore('SettingStore', {
    state: () => {
        return{
            refresh:false, // 用于控制刷新
        }
    }
})

export default useLayoutSettingStore;