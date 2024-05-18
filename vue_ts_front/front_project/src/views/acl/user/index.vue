<script setup lang="ts">
import {reqAllCollegeInfo, reqAllCounselorInfo, reqRemoveUserinfo, reqUpdateInfo} from "@/api/user";
import {onMounted, reactive, ref} from "vue";
import {AllUserInfoData, UserInfo} from "@/api/user/type.ts";
import {ElMessage} from "element-plus";

let collegeinfo = ref<UserInfo[]>([]);
let counselorinfo = ref<UserInfo[]>([])
let scece = ref(0); // 0展示个人信息，修改个人信息
// 表单收集修改的个人信息参数
let userInfoParams = reactive<UserInfo>({
  id: "",
  name: '',
  age: 0,
  sex: '',
});
// 获取表单实例
let formRef = ref();
// 设置是否显示心理辅导师id号,0不显示，1显示
let isshowid = ref(0);
// 表单规则校验
const rules = reactive({
  name: [{required: true, trigger: 'blur', message: '请输入姓名'}],
  age: [{required: true, trigger: 'blur', message: '请输入年龄'}],
  sex: [{required: true, trigger: 'blur', message: '请输入性别'}],
});

onMounted(() => {
  getAllUserInfo();
});

const getAllUserInfo = async () => {
  let result: AllUserInfoData = await reqAllCollegeInfo();
  if (result.code === 200) {
    collegeinfo.value = result.data;
  }
  let result2: AllUserInfoData = await reqAllCounselorInfo();
  if (result2.code === 200) {
    counselorinfo.value = result2.data;
  }
};
// 修改按钮
const update = (row: UserInfo) => {
  scece.value = 1;
  if (row.s_p_id) {
    isshowid.value = 1;
  }else{
    isshowid.value = 0;
  }
  Object.assign(userInfoParams, JSON.parse(JSON.stringify(row)));
};
// 确认按钮
const confirm = async () => {
  await formRef.value.validate();
  let result = await reqUpdateInfo(userInfoParams);
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    scece.value = 0;
    getAllUserInfo();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
// 删除按钮
const remove = async (row: UserInfo) => {
  let result = await reqRemoveUserinfo((row.id as number))
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    scece.value = 0;
    getAllUserInfo();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
</script>

<template>
  <el-card v-show="scece===0">
    <div class="title">大学生信息</div>
    <el-table border :data="collegeinfo" height="300px" style="margin: 20px 0;">
      <el-table-column type="index" label="序号" align="center" width="80px"></el-table-column>
      <el-table-column label="姓名" prop="name"></el-table-column>
      <el-table-column label="年龄" prop="age"></el-table-column>
      <el-table-column label="性别" prop="sex"></el-table-column>
      <el-table-column label="心理辅导师" prop="s_p_id"></el-table-column>
      <el-table-column label="操作">
        <template #="{row}">
          <el-button type='primary' size='small' icon="Edit" @click="update(row)"></el-button>
          <el-popconfirm title="你确定要删除这名用户的信息吗?" @confirm="remove(row)">
            <template #reference>
              <el-button type='danger' size='small' icon="Delete"></el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div class="title">心理辅导师信息</div>
    <el-table border :data="counselorinfo" style="margin: 20px 0;" height="200px">
      <el-table-column type="index" label="序号" align="center" width="80px"></el-table-column>
      <el-table-column label="姓名" prop="name"></el-table-column>
      <el-table-column label="年龄" prop="age"></el-table-column>
      <el-table-column label="性别" prop="sex"></el-table-column>
      <el-table-column label="操作">
        <template #="{row}">
          <el-button type='primary' size='small' icon="Edit" @click="update(row)"></el-button>
          <el-popconfirm title="你确定要删除这名用户的信息吗??" @confirm="remove(row)">
            <template #reference>
              <el-button type='danger' size='small' icon="Delete"></el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
  </el-card>

  <el-card v-show="scece===1">
    <el-form ref="formRef" :rules="rules" :model="userInfoParams">
      <el-form-item label="姓名" prop="name" label-width="100px">
        <el-input v-model="userInfoParams.name"></el-input>
      </el-form-item>
      <el-form-item label="年龄" prop="age" label-width="100px">
        <el-input v-model="userInfoParams.age"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex" label-width="100px">
        <el-select v-model="userInfoParams.sex">
          <el-option label="男" value="男"></el-option>
          <el-option label="女" value="女"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item v-show="isshowid==1" label="心理辅导师" prop="s_p_id" label-width="100px">
        <el-select v-model="userInfoParams.s_p_id">
          <el-option v-for="(item,index) in counselorinfo" :key="index" :label="`${item.name}(${item.id})`"
                     :value="(item.id as number)"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <el-button type='primary' size='default' @click="scece=0">取消</el-button>
    <el-button type='primary' size='default' @click="confirm">确定</el-button>
  </el-card>
</template>

<style scoped>
.title {
  font-size: 25px;
  font-weight: 800;
}
</style>