<script setup lang="ts">
//此组件为展示大学生心理量表测试结果
import {reqRemoveTestOutcome, reqTestOutcome} from "@/api/mentalScaleResults";
import {onMounted, ref} from "vue";
import {TestOutcome, TestOutcomeData} from "@/api/mentalScaleResults/type.ts";
import useLayoutSettingStore from "@/store/modules/setting.ts";
import useUserStore from "@/store/modules/user.ts";
import {ElMessage} from "element-plus";

let id = defineProps(['id']);
let testData = ref<TestOutcome[]>([]);
let searchid = ref('');
let settingStore = useLayoutSettingStore()
let userStore = useUserStore()
onMounted(() => {
  getTestOutcome();
})
const getTestOutcome = async () => {
  let result: TestOutcomeData = await reqTestOutcome(id.id);
  if (result.code === 200) {
    testData.value = result.data
  }
}
// 搜索按钮
const saerch = async ()=>{
  let result: TestOutcomeData = await reqTestOutcome(searchid.value);
  if (result.code === 200) {
    testData.value = result.data
  }
}
// 重置按钮
const reset = () => {
  settingStore.refresh = !settingStore.refresh;
}
// 删除按钮
const remove = async (row:TestOutcome) => {
  let result = await reqRemoveTestOutcome(row);
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    reset();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
</script>

<template>
  <el-card v-if="userStore.token.substring(0,2)==='11'">
    <div class="search-card">
      <div>
        <el-form>
          <el-form-item label="大学生id号">
            <el-input placeholder="请输入你要搜索的id号" v-model="searchid"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <div>
        <el-button type='primary' size='default' icon="Search" @click="saerch" :disabled="searchid?false:true">搜索</el-button>
        <el-button size="default" icon="RefreshRight" @click="reset">重置</el-button>
      </div>
    </div>
  </el-card>
  <el-table border :data="testData" style="margin-top:20px;">
    <el-table-column label="序号" type="index" width="80px" align="center"></el-table-column>
    <el-table-column label="大学生id号" prop="s_id"></el-table-column>
    <el-table-column label="量表类型" prop="type"></el-table-column>
    <el-table-column label="测试次数" prop="count"></el-table-column>
    <el-table-column label="测试时间" prop="testTime" width="200px"></el-table-column>
    <el-table-column label="测试分数" prop="score"></el-table-column>
    <el-table-column label="测试结果判断" prop="outcome"></el-table-column>
    <el-table-column label="操作" v-if="userStore.token.substring(0,2)==='11'">
      <template #="{row}">
        <el-popconfirm title="你确定要删除这条量表测试结果吗?" @confirm="remove(row)">
          <template #reference>
            <el-button type='danger' size='small' icon="Delete"></el-button>
          </template>
        </el-popconfirm>
      </template>
    </el-table-column>
  </el-table>
</template>

<style scoped>
.search-card {
  display: flex;
  justify-content: space-between;
}
</style>