<script setup lang="ts">
import {useRoute} from "vue-router";
import {ref} from "vue";
import emitter from "@/utils/emitter.ts";

let route = useRoute();
let isfold = ref<boolean>(false);
const fold = ()=>{
  isfold.value = !isfold.value;
  // 触发事件
  emitter.emit('isfold', isfold.value);
}
</script>

<template>
  <el-icon>
    <component :is="isfold?'Fold':'Expand'" @click="fold"></component>
  </el-icon>
  <el-breadcrumb separator-icon="ArrowRight">
    <el-breadcrumb-item class="b-item" v-for="(item,index) in route.matched" :key="index" :to="item.path" v-show="item.meta.title">
      <el-icon style="margin: 0 5px" size="13">
        <component :is="item.meta.icon"></component>
      </el-icon>
      <span>{{ item.meta.title }}</span>
    </el-breadcrumb-item>
  </el-breadcrumb>
</template>

<style scoped lang="scss">
</style>