<script setup lang="ts">
import SvgIcon from "@/components/SvgIcon/index.vue"
import useUserStore from "@/store/modules/user.ts";
import {onMounted} from "vue";
import {getTime} from "@/utils/time.ts";

let userStore = useUserStore();
onMounted(async ()=>{
  await userStore.userInfo();
});
</script>

<template>
  <el-card>
    <div class="box">
      <div class="bottom">
        <h3>{{ getTime() }},{{userStore.name}}</h3>
        <p>大学生心理健康检测与辅导平台</p>
      </div>
    </div>
  </el-card>
  <div class="svg">
    <SvgIcon name="welcome" width="500px" height="500px"></SvgIcon>
  </div>
</template>

<style scoped lang="scss">
.box{
  display: flex;
  .bottom{
    margin-left: 10px;
    h3{
      font-size: 20px;
      font-weight: 900;
      margin: 20px 0;
    }
    p{
      font-style: italic;
      color: gray;
    }
  }
}
.svg{
  display: flex;
  justify-content: center;
}
</style>