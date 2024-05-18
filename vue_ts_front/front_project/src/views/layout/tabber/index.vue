<script setup lang="ts">

import Breadcrumb from "@/views/layout/tabber/breadcrumb.vue";
import Setting from "@/views/layout/tabber/setting.vue";
</script>

<template>
<div class="tabber">
  <div class="tabber-left">
    <Breadcrumb ></Breadcrumb>
  </div>
  <div class="tabber-right">
    <Setting></Setting>
  </div>
</div>
</template>

<style scoped>
.tabber{
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
  .tabber-left{
    display: flex;
    align-items: center;
  }
  .tabber-right{
    display: flex;
    align-items: center;
  }
}
</style>