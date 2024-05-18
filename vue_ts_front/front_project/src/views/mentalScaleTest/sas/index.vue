<template>
  <ScaleTest :scaleType=type :scaleQuestion=dataParams :scaleTitle="title"></ScaleTest>
</template>

<script setup lang='ts'>
import ScaleTest from '@/components/scaleTest/index.vue'
import {reqGetSas} from "@/api/mentalScaleTest";
import {onMounted, ref} from "vue";
import {Record, ScaleData} from "@/api/mentalScaleTest/type.ts";
let type = ref<string>('sas')
let title = ref<string>('SAS焦虑自评量表')
// 量表数据
let dataParams = ref<Record[]>();
// 一挂载就获取数据
onMounted(() => {
  getHasScale();
});
// 获取量表
const getHasScale = async () => {
  let result: ScaleData = await reqGetSas();
  if (result.code == 200) {
    dataParams.value = result.data
  }
}
</script>

<style scoped>

</style>