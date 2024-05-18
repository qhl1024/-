<script setup lang="ts">
import Menu from "./menu/index.vue"
import Tabber from "./tabber/index.vue"
import Main from "./main/index.vue"
import useUserStore from "@/store/modules/user.ts";
import {onUnmounted, ref} from "vue";
import emitter from "@/utils/emitter.ts";
import SvgIcon from "@/components/SvgIcon/index.vue";

let userStore = useUserStore();
let isFold = ref<boolean>(false);
emitter.on('isfold',(value)=>{
  // 绑定事件
  isFold.value = (value as boolean);
})

onUnmounted(()=>{
  // 解绑
  emitter.off('isfold');
})

</script>

<template>
  <div class="layout-container">
    <!--  左侧菜单栏  -->
    <div class="layout-slider" :class="{active: isFold}">
      <div class="slider-title">
        <span class="title-logo">
          <svg-icon name="heart" height="60px" width="60px"></svg-icon>
        </span>
        <p>{{ isFold ? '' : '大学生心理健康检测与辅导平台'}}</p>
      </div>
      <el-menu :collapse="isFold" active-text-color="#ffd04b" background-color="#545c64" text-color="#fff">
        <Menu :menuList="userStore.menuRoutes"></Menu>
      </el-menu>
    </div>
    <!--  顶部导航区  -->
    <div class="layout-tabber" :class="{active: isFold}">
      <Tabber></Tabber>
    </div>
    <!--  内容区  -->
    <div class="layout-main" :class="{active: isFold}">
      <Main></Main>
    </div>
  </div>
</template>

<style scoped lang="scss">
.layout-container {
  width: 100%;
  height: 100vh;
  .layout-slider{
    width: $base-menu-width;
    background: $base-menu-bgColor;
    height: 100vh;
    transition: all 0.3s;
    position: fixed;

    .slider-title{
      width: 100%;
      height: $base-menu-title-height;
      line-height: $base-menu-title-height;
      text-align: center;
      display: flex;
      justify-content: center;
      p{
        font-size: 15px;
        font-style: italic;
        font-weight: 800;
        color: #f8f5f5;
      }
    }
    .el-menu{
      border-right: 0;
    }
    &.active{
      width: $base-menu-min-width;
    }
  }

  .layout-tabber{
    z-index: 999; //将导航栏置于最顶层
    position: fixed;
    top: 0;
    left: $base-menu-width;
    width: calc(100% - $base-menu-width);
    height: $base-tabbar-height;
    background: #c3e6ed;
    transition: all 0.3s;
    &.active{
      left: $base-menu-min-width;
      width: calc(100% - $base-menu-min-width);
    }
  }
  .layout-main{
    position: absolute;
    top:$base-tabbar-height;
    left: $base-menu-width;
    width: calc(100% - $base-menu-width);
    padding: 20px;
    transition: all 0.3s;
    &.active{
      left: $base-menu-min-width;
      width: calc(100% - $base-menu-min-width);
    }
  }
}
</style>