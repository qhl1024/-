<script setup lang="ts">
import {reqCounselorCollegeInfo} from "@/api/mentalScaleResults";
import {onMounted, ref} from "vue";
import useUserStore from "@/store/modules/user.ts";
import {CounselorCollegeInfo} from "@/api/mentalScaleResults/type.ts";
import {UserInfo, UserInfoData} from "@/api/user/type.ts";
import ScaleOutcome from "@/components/scaleOutcome/index.vue";
// 大学生个人信息
let collegeInfo = ref<UserInfo[]>([]);
// 获取大学生id号
let collegeId = ref('');
// 是否展示大学生量表测试结果
let isshow = ref(false)
let userStore = useUserStore();
onMounted(() => {
  getCollegeInfo();
})
// 获取心理辅导师的大学生的信息
const getCollegeInfo = async () => {
  let result: CounselorCollegeInfo = await reqCounselorCollegeInfo(userStore.token);
  if (result.code === 200) {
    collegeInfo.value = result.data.map((item: UserInfoData) => {
      return item.data
    });
  }
}
// 查看大学生的量表测试情况
const lookInfo = async (row: any) => {
  isshow.value =true;
  collegeId.value = row.id;
}

</script>

<template>
  <el-card>
    <!-- 大学生个人信息 -->
    <el-table border :data="collegeInfo">
      <el-table-column label="序号" type="index" width="80px" align="center"></el-table-column>
      <el-table-column label="id" prop="id"></el-table-column>
      <el-table-column label="姓名" prop="name"></el-table-column>
      <el-table-column label="年龄" prop="age"></el-table-column>
      <el-table-column label="性别" prop="sex"></el-table-column>
      <el-table-column label="操作">
        <template #="{row}">
          <el-button type='info' size='default' icon="InfoFilled" @click="lookInfo(row)"></el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
    <el-drawer  v-model="isshow" :title="`${collegeId}学生的量表测试情况`" direction="rtl" size="50%">
      <!-- 大学生量表测试结果 -->
      <ScaleOutcome :id="collegeId" v-if="isshow"></ScaleOutcome>
    </el-drawer>
</template>

<style scoped>

</style>