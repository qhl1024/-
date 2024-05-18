<script setup lang="ts">
import useUserStore from "@/store/modules/user"
import {useRouter} from "vue-router";
import {ref} from "vue"
import useLayoutSettingStore from "@/store/modules/setting";
let userStore = useUserStore()
let router = useRouter()
let visible = ref<boolean>(false);
let LayoutSettingStore = useLayoutSettingStore()
// 暗黑开关按钮，true表示开启暗黑模式
const isDark = ref(true);
// 颜色
const color = ref('rgba(255, 69, 0, 0.68)')

// 全屏按钮
const fullscreen = () => {
  // document.fullscreenElement用于判断页面是否全屏
  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
  } else {
    document.exitFullscreen();
  }
}
// 刷新按钮
const refresh = () => {
  LayoutSettingStore.refresh = !LayoutSettingStore.refresh
}
// 退出按钮
const logout = () => {
  userStore.userLogout();
  router.push('/login');
}
// 个人中心按钮
const userCenter = () => {
  router.push('/userCenter');
}
// 设置按钮
const setting = () => {
  visible.value = true;
}
//进行暗黑模式的切换
const changeDark = ()=>{
  let html = document.documentElement;
  html.classList.toggle('dark');
}
// 主题颜色设置
const setColor = () => {
  let html = document.documentElement;
  html.style.setProperty('--el-color-primary', color.value);
}
</script>

<template>
  <el-button size='default' circle icon="FullScreen" @click="fullscreen"></el-button>
  <el-button size='default' circle icon="Refresh" @click="refresh"></el-button>
  <el-button size='default' circle icon="Setting" @click="setting"></el-button>
  <el-dropdown>
    <el-button size="default" circle icon="User" style="margin: 0 10px"></el-button>
    <template #dropdown>
      <el-dropdown-menu>
        <el-dropdown-item icon="More" @click="userCenter">个人中心</el-dropdown-item>
        <el-dropdown-item icon="Position" @click="logout">退出登录</el-dropdown-item>
      </el-dropdown-menu>
    </template>
  </el-dropdown>
  <el-drawer v-model="visible" title="设置" direction="rtl">
    <template #header>
      <h4>主题设置</h4>
    </template>
    <template #default>
      <el-form>
        <el-form-item label="主题颜色">
          <el-color-picker @change="setColor" v-model="color" size="small"/>
        </el-form-item>
        <el-form-item label="暗黑模式">
          <el-switch @change="changeDark" v-model="isDark" active-icon="Moon" inactive-icon="Sunny"
                     class="mt-2" style="margin-left: 24px" inline-prompt/>
        </el-form-item>
      </el-form>
    </template>
  </el-drawer>
</template>

<style scoped>

</style>