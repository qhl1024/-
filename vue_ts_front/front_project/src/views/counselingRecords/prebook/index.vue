<script setup lang="ts">
import {nextTick, onMounted, reactive, ref} from 'vue'
import {Prebook} from "@/api/counselingRecords/type.ts";
import {reqAddOrUpdatePrebook, reqGetPrebooks, reqRemovePrebook} from "@/api/counselingRecords/index"
import {reqAllCounselorInfo, reqAllCollegeInfo} from "@/api/user";
import {UserInfo} from "@/api/user/type.ts";
import useUserStore from "@/store/modules/user.ts";
import {ElMessage} from "element-plus";
import {reqAddOrUpdateRecord} from "@/api/counselingRecords";

let userStore = useUserStore();
// 增加预约参数
let prebookParams = reactive<Prebook>({
  s_id: userStore.token,
  p_id: '',
  time: '',
});
// 切换card
let scene = ref(0);
// 大学生信息
let college = ref<UserInfo[]>()
// 心理辅导师信息
let counselor = ref<UserInfo[]>()
// 展示已有的预约信息
let prebookData = ref<Prebook[]>([])
// 获取表单实例
let formRef = ref();

onMounted(() => {
  getHasPrebooks();
});
// 获取已有的预约信息
const getHasPrebooks = async () => {
  // 获取已有预约记录
  let result = await reqGetPrebooks(userStore.token);
  if (result.code === 200) {
    prebookData.value = result.data;
  }
  // 获取心理辅导师信息
  let result1 = await reqAllCounselorInfo();
  if (result1.code === 200) {
    counselor.value = result1.data
  }
  // 获取心理辅导师信息
  let result2 = await reqAllCollegeInfo();
  if (result2.code === 200) {
    college.value = result2.data
  }
}

// 添加预约按钮
const addPrebook = async () => {
  // 添加前先清空数据
  Object.assign(prebookParams, {
    p_id: '',
    time: '',
    state: '',
    count: '',
    s_id: ''
  });
  nextTick(() => {
    formRef.value.clearValidate('p_id');
    formRef.value.clearValidate('time');
  })
  scene.value = 1;
}
// 确定按钮
const comfirm = async () => {
  await formRef.value.validate();
  prebookParams.time = prebookParams.time.toLocaleString().replace(/\//g, "-");
  if(prebookParams.s_id === '') prebookParams.s_id = userStore.token;
  let result = await reqAddOrUpdatePrebook(prebookParams);
  if (result.code == 200) {
    scene.value = 0
    ElMessage({type: 'success', message: result.message});
    getHasPrebooks();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
// 修改预约按钮
const update = async (row: any) => {
  scene.value = 1;
  nextTick(() => {
    formRef.value.clearValidate('s_id');
    formRef.value.clearValidate('p_id');
    formRef.value.clearValidate('time');
  })
  Object.assign(prebookParams, row);
}
// 删除按钮
const remove = async (row: any) => {
  let result = await reqRemovePrebook(row)
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    getHasPrebooks();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
// 完成按钮
const finish = async (row: any) => {
  const currentTime = new Date();
  const prebookTime = new Date(row.time);
  if (prebookTime > currentTime) {
    ElMessage({type: 'error', message: '当前时间还没达到预约时间'});
  } else {
    //   把状态“未开始”改成'已结束'
    Object.assign(prebookParams, row);
    prebookParams.state = '已结束';
    let result = await reqAddOrUpdatePrebook(prebookParams);
    if (result.code == 200) {
      scene.value = 0
      ElMessage({type: 'success', message: result.message});
      getHasPrebooks();
      // 预约状态已结束后添加，需要对本次辅导填写心理辅导记录
      // 增加辅导记录
      await reqAddOrUpdateRecord({
        id: prebookParams.s_id,
        c_p_id: prebookParams.p_id,
        time: prebookParams.time,
      });
    } else {
      ElMessage({type: 'error', message: result.message});
    }
  }
}
// 时间校验
const validateTime = (_rule: any, value: any, callback: any) => {
  const currentTime = new Date();
  if (value == "") {
    callback(new Error("请输入预约时间"))
  } else if (value <= currentTime) {
    callback(new Error("预约时间要大于当前时间"))
  } else {
    callback();
  }
};
// 表单规则校验
const rules = reactive({
  s_id: [{required: true, trigger: 'change', message: '请选择大学生！'}],
  p_id: [{required: true, trigger: 'change', message: '请选择心理辅导师！'}],
  time: [{required: true, trigger: 'blur', validator: validateTime}],
});
</script>

<template>
  <!-- 展示心理辅导预约 -->
  <el-card v-show="scene==0">
    <!--  大学生用户才有增加预约按钮  -->
    <el-button v-if="userStore.token.substring(0,2)!=='21'" type='primary' size='default' icon="Plus"
               style="margin: 10px 0;" @click="addPrebook">添加预约
    </el-button>
    <el-table border :data="prebookData">
      <el-table-column type="index" label="序号" width="100px" align="center"></el-table-column>
      <el-table-column v-if="userStore.token.substring(0,2)!=='31'" label="大学生id号" prop="s_id"></el-table-column>
      <el-table-column v-if="userStore.token.substring(0,2)!=='21'" label="心理辅导师id号"
                       prop="p_id"></el-table-column>
      <el-table-column label="预约时间" prop="time"></el-table-column>
      <el-table-column label="状态" prop="state"></el-table-column>
      <el-table-column label="操作">
        <template #default="{row}">
          <el-button v-if="userStore.token.substring(0,2)!=='21'" type='primary' size='small' icon="Edit"
                     @click="update(row)"></el-button>
          <el-popconfirm title="你确定删除吗?" @confirm="remove(row)">
            <template #reference>
              <el-button :disabled="userStore.token.substring(0,2)!=='21'?false:true" type='danger' size='small'
                         icon="Delete"></el-button>
            </template>
          </el-popconfirm>
          <el-popconfirm title="你确定修改状态吗?" @confirm="finish(row)">
            <template #reference>
              <el-button v-if="userStore.token.substring(0,2)=='21'" type="info" size="small" icon="Finished"
                         :disabled="row.state=='已结束'"></el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
  <!-- 增加/修改心理辅导预约 -->
  <el-card v-show="scene==1">
    <el-form :rules="rules" ref="formRef" :model="prebookParams">
      <el-form-item v-if="userStore.token.substring(0,2)==='11'" label="预约大学生" label-width="130px" prop="s_id">
        <el-select v-model="prebookParams.s_id" style="width: 220px">
          <el-option v-for="(item,index) in college" :key="index" :label="`${item.name}(${item.id})`"
                     :value="(item.id as number)"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="预约心理辅导师" label-width="130px" prop="p_id">
        <el-select v-model="prebookParams.p_id" style="width: 220px">
          <el-option v-for="(item,index) in counselor" :key="index" :label="`${item.name}(${item.id})`"
                     :value="(item.id as number)"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="预约时间" label-width="130px" prop="time">
        <el-date-picker v-model="prebookParams.time" type="datetime" placeholder="请选择时间"/>
      </el-form-item>
    </el-form>
    <el-button type='primary' size='default' @click="scene=0">取消</el-button>
    <el-button type='primary' size='default' @click="comfirm">确定</el-button>
  </el-card>
</template>

<style scoped>

</style>