<script setup lang="ts">
import {onMounted, ref, reactive} from "vue";
import useUserStore from "@/store/modules/user.ts";
import {UserInfo} from "@/api/user/type.ts";
import {reqGetRecords, reqAddOrUpdateRecord, reqRemoveRecord} from "@/api/counselingRecords";
import {Record, RecordsData} from "@/api/counselingRecords/type.ts";
import {reqUserInfo} from "@/api/user";
import {ElMessage} from "element-plus";

// 大学生个人信息
let collegeInfo = ref<UserInfo>();
// 获取大学生id号
let collegeId = ref('');
// 是否展示大学生个人信息
let isshow = ref(false)
// 是否修改大学生心理辅导记录
let isDialog = ref(false);
let userStore = useUserStore();
// 未填写心理辅导记录的信息
let unRecordParams = ref<Record[]>()
// 已经填写心理辅导记录的信息
let hasRecordParams = ref<Record[]>()
// 大学生心理辅导记录收集信息
let recordParams = ref<Record>({
  id: '',  //大学生的id号
  c_p_id: '',  //心理辅导师的id号
  time: '',
  content: '',
  situation: '',
  advice: ''
})
// 获取表单实例
let formref = ref();
// 方法
onMounted(() => {
  getRecords();
});
// 获取已有的辅导记录
const getRecords = async () => {
  let result: RecordsData = await reqGetRecords(userStore.token);
  if (result.code == 200) {
    unRecordParams.value = result.data.filter((item) => {
      return item.content === null;
    });
    hasRecordParams.value = result.data.filter((item) => {
      return item.content !== null;
    });
  }
};
// 查看大学生的个人信息
const lookCollegeInfo = async (row: any) => {
  isshow.value = true;
  collegeId.value = row.id;
  let result: any = await reqUserInfo(row.id);
  if (result.code === 200) {
    collegeInfo.value = result.data;
  }
}
// 更新辅导记录
const updateRecord = (row: any) => {
  isDialog.value = true;
  Object.assign(recordParams.value, row);
};
// 表单规则校验
const rules = reactive({
  time: [{required: true, trigger: 'change', message: '请输入心理辅导时间！'}],
  content: [{required: true, trigger: 'blur', message: '请输入心理辅导内容！'}],
  situation: [{required: true, trigger: 'blur', message: '请输入心理辅导情况！'}],
  advice: [{required: true, trigger: 'blur', message: '请输入心理辅导建议！'}],
});
// 确认按钮
const confirm = async () => {
  // 校验规则
  await formref.value.validate();
  // 整理数据
  recordParams.value.time = (recordParams.value.time as string).toLocaleString().replace(/\//g, "-");
  // 发送请求
  let result = await reqAddOrUpdateRecord(recordParams.value);
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    isDialog.value = false;
    getRecords();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
// 删除记录按钮
const remove = async (row: any) => {
  let result = await reqRemoveRecord(row);
  if (result.code == 200) {
    ElMessage({type: 'success', message: result.message});
    getRecords();
  } else {
    ElMessage({type: 'error', message: result.message});
  }
}
</script>

<template>
  <!-- 未填写信息展示展示 -->
  <el-card>
    <template #header>
      <div class="card-header">
        <span>未填写记录</span>
      </div>
    </template>
    <el-table border :data="unRecordParams">
      <el-table-column label="序号" type="index" width="80px" align="center"></el-table-column>
      <el-table-column label="id" prop="id"></el-table-column>
      <el-table-column label="时间" prop="time"></el-table-column>
      <el-table-column label="操作">
        <template #="{row}">
          <el-button type='info' size='small' icon="InfoFilled" @click="lookCollegeInfo(row)"></el-button>
          <el-button type='primary' size='small' icon="Edit" @click="updateRecord(row)"></el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
  <!-- 已填写信息展示展示 -->
  <el-card style="margin: 10px 0;">
    <template #header>
      <div class="card-header">
        <span>已填写记录</span>
      </div>
    </template>
    <el-table border :data="hasRecordParams" height="280">
      <el-table-column label="序号" type="index" width="80px" align="center"></el-table-column>
      <el-table-column label="id" prop="id" width="80px"></el-table-column>
      <el-table-column label="辅导时间" prop="time" width="200px"></el-table-column>
      <el-table-column label="辅导内容" prop="content" width="200px" show-overflow-tooltip></el-table-column>
      <el-table-column label="辅导情况" prop="situation" width="200px" show-overflow-tooltip></el-table-column>
      <el-table-column label="辅导建议" prop="advice" width="500px" show-overflow-tooltip></el-table-column>
      <el-table-column label="操作" fixed="right" width="180px">
        <template #="{row}">
          <el-button type='info' size='small' icon="InfoFilled" @click="lookCollegeInfo(row)"></el-button>
          <el-button type='primary' size='small' icon="Edit" @click="updateRecord(row)"></el-button>
          <el-popconfirm title="你确定要删除这条记录吗?" @confirm="remove(row)"
                         v-if="userStore.token.substring(0,2)=='11'">
            <template #reference>
              <el-button type="danger" size="small" icon="Delete"></el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
  </el-card>

  <el-drawer v-model="isshow" :title="`${collegeId}学生的个人信息`" direction="rtl">
    <!-- 大学生个人信息展示  -->
    <div class="infoshow">
      <div class="info">
        <div class="info-item">
          <span>姓名</span>
          <span>{{ collegeInfo?.name }}</span>
        </div>
        <div class="info-item">
          <span>年龄</span>
          <span>{{ collegeInfo?.age }}</span>
        </div>
        <div class="info-item">
          <span>性别</span>
          <span>{{ collegeInfo?.sex }}</span>
        </div>
      </div>
    </div>
  </el-drawer>
  <!-- 对话框：展示修改页面 -->
  <el-dialog v-model="isDialog">
    <el-form :rules="rules" :model="recordParams" ref="formref">
      <!--      <el-form-item label="辅导时间" label-width="100px" prop="time">-->
      <!--        <el-date-picker v-model="recordParams.time" type="datetime" placeholder="请选择时间"/>-->
      <!--      </el-form-item>-->
      <el-form-item label="辅导内容" label-width="100px" prop="content">
        <el-input v-model="recordParams.content" type="textarea" placeholder="请输入辅导内容"></el-input>
      </el-form-item>
      <el-form-item label="辅导情况" label-width="100px" prop="situation">
        <el-input v-model="recordParams.situation" type="textarea" placeholder="请输入辅导情况"></el-input>
      </el-form-item>
      <el-form-item label="辅导建议" label-width="100px" prop="advice">
        <el-input v-model="recordParams.advice" type="textarea" placeholder="请输入辅导建议"></el-input>
      </el-form-item>
    </el-form>
    <el-button type="primary" size="default" @click="isDialog=false">取消</el-button>
    <el-button type='primary' size='default' @click="confirm">确定</el-button>
  </el-dialog>
</template>

<style scoped>
.infoshow {
  display: flex;

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
</style>