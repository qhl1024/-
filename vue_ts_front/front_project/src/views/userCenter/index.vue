<script setup lang="ts">
import useUserStore from "@/store/modules/user.ts";
import {onMounted, reactive, ref} from "vue";
import {reqUpdateInfo, reqUserInfo, reqAllCounselorInfo} from "@/api/user";
import {ElMessage} from "element-plus";
import {UserInfo} from "@/api/user/type.ts";
import {useRouter} from "vue-router";

let userStore = useUserStore();
// 切换card
let scece = ref(0); // 0展示个人信息，修改个人信息
let router = useRouter();
// 表单收集修改的个人信息参数
let userInfoParams = reactive<UserInfo>({
  id: userStore.token,
  name: '',
  age: 0,
  sex: '',
});
// 展示个人信息参数
let userInfo = reactive<UserInfo>({
  name: '',
  age: 0,
  sex: '',
});
// 所有心理辅导师的个人信息
let counselorInfo = ref();
// 获取表单实例
let formRef = ref();
// 表单规则校验
const rules = reactive({
  name: [{required: true, trigger: 'blur', message: '请输入姓名'}],
  age: [{required: true, trigger: 'blur', message: '请输入年龄'}],
  sex: [{required: true, trigger: 'blur', message: '请输入性别'}],
});
onMounted(() => {
  getHasInfo();
})
// 获取用户信息
const getHasInfo = async () => {
  // 获取用户信息
  let result = await reqUserInfo(userStore.token);
  if (result.code === 200) {
    userInfo.name = result.data.name;
    userInfo.age = result.data.age;
    userInfo.sex = result.data.sex;
    userInfo.s_p_id = result.data.s_p_id;
  }
  // 如果用户为大学生用户，则获取所有心理辅导师信息接口
  if (userInfo.s_p_id || userInfo.s_p_id === null) {
    let result2 = await reqAllCounselorInfo();
    if (result2.code === 200) {
      counselorInfo.value = result2.data
    }
  }
}
// 修改信息按钮
const updateInfo = () => {
  scece.value = 1;
  Object.assign(userInfoParams, JSON.parse(JSON.stringify(userInfo)));
}
// 回到首页
const goHome = () => {
  router.push({path: '/home'});
}
// 确认按钮
const confirm = async () => {
  await formRef.value.validate();
  let result = await reqUpdateInfo(userInfoParams);
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    scece.value = 0;
    getHasInfo();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
</script>

<template>
  <div class="container">
    <el-card v-show="scece === 0">
      <div class="title">基本信息</div>
      <div class="infoshow">
        <div class="info">
          <div class="info-item">
            <span>姓名</span>
            <span>{{ userInfo.name ? userInfo.name : '无' }}</span>
          </div>
          <div class="info-item">
            <span>年龄</span>
            <span>{{ userInfo.age ? userInfo.age : '无' }}</span>
          </div>
          <div class="info-item">
            <span>性别</span>
            <span>{{ userInfo.sex ? userInfo.sex : '无' }}</span>
          </div>
          <div class="info-item" v-if="userInfo.s_p_id || userInfo.s_p_id === null">
            <span>心理辅导师</span>
            <span>{{ userInfo.s_p_id ? userInfo.s_p_id : "无" }}</span>
          </div>
        </div>
      </div>
      <el-button type="primary" size="default" @click="updateInfo">修改信息</el-button>
      <el-button type='primary' size='default' @click="goHome">回到首页</el-button>
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
        <el-form-item v-if="userInfo.s_p_id || userInfo.s_p_id === null" label="心理辅导师" prop="s_p_id"
                      label-width="100px">
          <el-select v-model="userInfoParams.s_p_id">
            <el-option v-for="(item,index) in counselorInfo" :key="index" :label="`${item.name}(${item.id})`"
                       :value="item.id"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <el-button type='primary' size='default' @click="scece=0">取消</el-button>
      <el-button type='primary' size='default' @click="confirm">确定</el-button>
    </el-card>
  </div>

</template>

<style scoped lang="scss">
.container {
  position: relative;
  margin: 20px 0;
  left: 25%;
  width: 50vw;
  .title {
    font-size: 20px;
    font-weight: 800;
  }
  .infoshow{
    display: flex;
    .avatar{
      margin: 20px 0;
      margin-right: 20px;
      height: 100px;
      width: 100px;
      border-radius: 50%;
    }
    .info {
      margin: 10px 0;
      display: flex;
      flex-direction: column;
    }

    .info-item {
      display: flex;
      margin: 10px 0;

      span {
        font-size: 15px;
        margin-right: 30px;
      }
    }
  }


}
</style>