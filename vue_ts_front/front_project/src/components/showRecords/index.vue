<script setup lang="ts">
import {reqGetRecords} from "@/api/counselingRecords";
import {onMounted, ref} from "vue";
import {Record, RecordsData} from "@/api/counselingRecords/type.ts";
let token = defineProps(['id', 'show','c_p_id'])

let recordsParams = ref<Record[]>([]);
onMounted(() => {
  getHasRecords();
})
// 控制card组件切换,0：展示个人信息，1：增加记录
let scene = ref<number>(0);

// 获取已有的辅导记录
const getHasRecords = async () => {
  let result: RecordsData = await reqGetRecords(token.id);
  if (result.code == 200) {
    recordsParams.value = result.data
  }
};
</script>

<template>
  <el-card v-show="scene==0">
    <el-table border :data="recordsParams">
      <el-table-column type="index" align="center" label="序号" width="80px"></el-table-column>
      <el-table-column label="辅导时间" prop="time"></el-table-column>
      <el-table-column label="辅导内容" prop="content"></el-table-column>
      <el-table-column label="辅导情况" prop="situation"></el-table-column>
      <el-table-column label="辅导建议" prop="advice" width="500px"></el-table-column>
    </el-table>
  </el-card>
</template>

<style scoped>
</style>