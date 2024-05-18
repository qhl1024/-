<template>
  <div class="login-container">
    <el-card class="login-card">
      <h1>Hello</h1>
      <h2>欢迎来到大学生心理健康平台</h2>
      <div class="show">
        <el-button type='primary' size='default' @click="showLogin">登录页面</el-button>
        <el-button type='primary' size='default' @click="showSignUp">注册页面</el-button>
      </div>
      <!--  登录页面    -->
      <el-form :model="formData" class="login-form" v-show="isshow==1?true:false" :rules="rules" ref="loginForm">
        <el-form-item label="用户名" label-width="80px" prop="username">
          <el-input prefix-icon="User" placeholder="请输入用户名" v-model="formData.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" label-width="80px" prop="password">
          <el-input prefix-icon="Lock" type="password" placeholder="请输入密码" v-model="formData.password"
                    show-password></el-input>
        </el-form-item>
        <el-button type='primary' size='default' class="confirm" @click="login">登录</el-button>
      </el-form>
      <!--   注册页面   -->
      <el-form :model="formData" class="login-form" v-show="isshow==0?true:false" :rules="rules" ref="signupForm">
        <el-form-item label="用户名" label-width="80px" prop="username">
          <el-input prefix-icon="User" placeholder="请输入用户名" v-model="formData.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" label-width="80px" prop="password">
          <el-input prefix-icon="Lock" type="password" placeholder="请输入密码" v-model="formData.password"
                    show-password></el-input>
        </el-form-item>
        <el-form-item label="确认密码" label-width="80px" prop="confirmPassword">
          <el-input prefix-icon="Lock" type="password" placeholder="请再次输入密码" v-model="formData.confirmPassword"
                    show-password></el-input>
        </el-form-item>
        <el-form-item prop="identity">
          <el-radio-group v-model="formData.identity" style="margin: 10px 0">
            <el-radio value="college" size="large" border>大学生</el-radio>
            <el-radio value="counselor" size="large" border>心理咨询师</el-radio>
            <el-radio value="administrator" size="large" border>管理员</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-button type='primary' size='default' class="confirm" @click="signup">注册</el-button>
      </el-form>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import {nextTick, reactive, ref} from "vue";
import {UserFormData} from "@/api/user/type.ts";
import {useRouter} from 'vue-router'
import {ElMessage, ElNotification} from "element-plus";
import useUserStore from "@/store/modules/user"
// 引入获取当前时间的函数
import {getTime} from '@/utils/time'
let isshow = ref<number>(1);
let formData = reactive<UserFormData>({username: '3101', password: '1234567'});
// 获取登录表单实例
let loginForm = ref<any>();
// 获取注册表单实例
let signupForm = ref<any>();
// 路由器
let $router = useRouter();
let userStore = useUserStore();
// -----------------方法-----------------
// 切换登录页面
const showLogin = () => {
  isshow.value = 1;
  // 清除上一次的数据
  Object.assign(formData, {
    username: '',
    password: '',
  });
  // 清除上一次表单校验规则
  nextTick(() => {
    loginForm.value.clearValidate('username');
    loginForm.value.clearValidate('password');
  })
}
// 切换注册页面
const showSignUp = () => {
  isshow.value = 0;
  Object.assign(formData, {
    username: '',
    password: '',
    confirmPassword: '',
    identity: ''
  });
  nextTick(() => {
    signupForm.value.clearValidate('confirmPassword');
    signupForm.value.clearValidate('username');
    signupForm.value.clearValidate('password');
    signupForm.value.clearValidate('identity');
  })
}
// 登录按钮
const login = async () => {
  // 保证表单验证通过再发请求
  await loginForm.value.validate();
  try {
    await userStore.userLoginOrSignUp(formData);
    $router.push({path: '/home'});
    ElNotification({
      type: 'success',
      message: '登录成功，欢迎回来',
      title: `Hi,${getTime()}`
    });
  } catch (err:any) {
    ElMessage({type: 'error', message: err.message});
  }
}
// 注册按钮
const signup = async () => {
  await signupForm.value.validate();
  try {
    await userStore.userLoginOrSignUp(formData);
    $router.push({path: '/home'});
    ElNotification({
      type: 'success',
      message: '注册成功，欢迎来到大学生心理健康辅导与检测平台'
    });
    isshow.value = 1;
  } catch (err:any) {
    ElMessage({type: 'error', message: err.message});
  }
}
// 用户名校验规则
const validateUsername = (_rule: any, value: any, callback: any) => {
  if (value.trim().length < 4) {
    callback(new Error('用户名至少四位!!!'));
  } else if(formData.identity == 'college' && value.trim().substring(0,2) !== '31'){
    callback(new Error('大学生用户必须是31开头'))
  } else if(formData.identity == 'counselor' && value.trim().substring(0,2) !== '21'){
    callback(new Error('心理辅导师用户必须是21开头'))
  } else if(formData.identity == 'administrator' && value.trim().substring(0,2) !== '11'){
    callback(new Error('管理员用户必须是11开头'))
  } else {
    callback();
  }
};
// 密码校验规则
const validatePassword = (_rule: any, value: any, callback: any) => {
  if (value.length >= 6) {
    callback();
  } else {
    callback(new Error('密码至少6位！！！'))
  }
};
// 确认密码校验规则
const validatePasswordConfirm = (_rule: any, value: any, callback: any) => {
  if (value === formData.password) {
    callback();
  } else {
    callback(new Error('确认密码与密码不一致！！！'))
  }
};
const validateIdentity = (_rule: any, value: any, callback: any) => {
  if (value) {
    callback();
  } else {
    callback(new Error('请选择你的身份!!!'))
  }
}
// 自定义校验规则
const rules = {
  username: [{required: true, trigger: 'blur', validator: validateUsername},],
  password: [{required: true, trigger: "blur", validator: validatePassword},],
  confirmPassword: [{required: true, trigger: "blur", validator: validatePasswordConfirm},],
  identity: [{required: true, trigger: "change", validator: validateIdentity}]
}
</script>

<style scoped lang="scss">
.login-container {
  width: 100%;
  height: 100vh;
  background: url("@/assets/images/login_bg.jpg") no-repeat;
  background-size: 100% 100%;

  .login-card {
    position: relative;
    top: 15vh;
    left: 50%;
    width: 28%;

    h1 {
      font-size: 40px;
    }

    h2 {
      font-size: 20px;
      margin: 20px 0;
      text-align: center;
      font-weight: 800;
    }

    .show {
      margin: 0 auto;
      width: 60%;
      display: flex;
      justify-content: space-between;
    }

    .login-form {
      margin: 20px 0;

      .confirm {
        width: 100%;
      }
    }
  }

}
</style>