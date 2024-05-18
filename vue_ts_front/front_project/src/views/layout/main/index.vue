<script setup lang="ts">
import { watch,ref,nextTick } from 'vue'
import useLayoutSettingStore from '@/store/modules/setting'
let LayoutSettingStore = useLayoutSettingStore()
// 控制当前组件是否刷新销毁
let flag = ref(true);
// 监听refresh，如果发生变化就销毁重建，达到刷新的效果
watch(() => LayoutSettingStore.refresh,() => {
  flag.value = false; // 销毁
  nextTick(()=>{ //使用nextTick重建
    flag.value = true;
  })
})
</script>

<template>
  <router-view v-slot="{ Component }">
    <transition name="fade">
      <!-- 渲染layout一级路由组件的子路由 -->
      <component :is="Component" v-if="flag"/>
    </transition>
  </router-view>
</template>

<style scoped>
.fade-enter-from {
  opacity: 0;
}
.fade-enter-active {
  transition: all 1s;
}
.fade-enter-to {
  opacity: 1;
}
</style>