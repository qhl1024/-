<script setup lang="ts" name="scaleTest">
import {reqSubmitScale} from "@/api/mentalScaleTest";
import {ref} from "vue";
import {ScaleTestOutcomeData} from "@/api/mentalScaleTest/type.ts";
import {ElMessage} from "element-plus";
import useUserStore from "@/store/modules/user.ts";
// 获取父组件传递过来的数据
let scaledata = defineProps(['scaleQuestion', 'scaleType', 'scaleTitle']);
// 选择的量表的结果
let choose = ref([]);
// 判断是否完成所有的题目
let flag = ref<boolean>(true);
// 发送的量表测试结果的数据
let scaleOutcome = ref<ScaleTestOutcomeData>({
  id: '',
  type: scaledata.scaleType,
  data: []
})
// 调用仓库获取用户token
let userStore = useUserStore();
// 未完成的题目序号
let questionindex = ref(0);
// 提交按钮
const submit = async () => {
  // 提交前的判断
  for (let i = 0; i < scaledata.scaleQuestion.length; i++) {
    if (choose.value[i] === undefined) {
      flag.value = false;
      questionindex.value = i + 1;
      break;
    } else {
      flag.value = true;
    }
  }
  if (flag.value == false) {
    ElMessage({type: 'error', message: `第${questionindex.value}题没选择，请完成所有题目再提交！`});
  } else {
    // 整理数据
    scaleOutcome.value.data = choose.value.map((item: string) => {
      return item.slice(item.length - 1, item.length);
    })
    scaleOutcome.value.id = userStore.token
    // 发送请求
    let result = await reqSubmitScale(scaleOutcome.value);
    console.log("res", result);
    if (result.code == 200) {
      ElMessage({type: 'success', message: '提交成功'});
      // 把选项清空
      choose.value = []
    } else {
      ElMessage({type: 'error', message: '提交失败'});
    }
  }
}
</script>

<template>
  <el-card>
    <template #header>
      <div class="card-header">
        <h2>{{ scaleTitle }}</h2>
      </div>
    </template>
    <template #default>
      <el-form v-for="(item,index) in scaleQuestion" :key="index">
        <h4>{{ index + 1 }}.{{ item.question }}</h4>
        <el-form-item>
          <el-radio-group style="margin: 10px 0 20px" v-model="choose[index]">
            <el-radio :value="`${index}A`" size="large" border>{{ item.choiceA }}</el-radio>
            <el-radio :value="`${index}B`" size="large" border>{{ item.choiceB }}</el-radio>
            <el-radio :value="`${index}C`" size="large" border>{{ item.choiceC }}</el-radio>
            <el-radio :value="`${index}D`" size="large" border>{{ item.choiceD }}</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
    </template>
    <template #footer>
      <el-button v-show="userStore.token.substring(0,2)=='31'" type='primary' size='default' @click="submit">提交
      </el-button>
    </template>
  </el-card>
</template>

<style scoped>
h2 {
  font-size: 30px;
  font-weight: 800;
  text-align: center;
}
</style>