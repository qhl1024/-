<template>
  <div class="box">
    <img src="../../assets/images/404.png" alt="">
    <el-button type='primary' size='default' @click="goHome">首页</el-button>
  </div>
</template>

<script setup lang='ts'>
import {useRouter} from "vue-router";
let $router = useRouter();
const goHome = ()=>{
  $router.push('/home');
}
</script>

<style scoped>
.box {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  img{
    width: 800px;
    height: 400px;
  }
}
</style>