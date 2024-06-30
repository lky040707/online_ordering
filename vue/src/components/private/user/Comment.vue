<template>
  <div class="info">
    <el-form
      ref="infoForm"
      :model="student"
      label-width="100px"
      style="width: auto"
    >
      <el-row :gutter="11" type="flex" justify="end">
        <el-col :span="6"
          ><el-form-item>
            <el-switch
              v-model="edit"
              active-text="编辑模式"
              active-color="#13ce66"
            ></el-switch>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="11">
        <el-col :span="8">
          <el-form-item label="学号">
            <el-input v-model="student.id" disabled></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="姓名">
            <el-input v-model="student.name" disabled></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="11">
        <el-col :span="8">
          <el-form-item label="性别">
            <el-radio-group v-model="student.gender" disabled>
              <el-radio :label="'男'">男</el-radio>
              <el-radio :label="'女'">女</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="8">
          <el-form-item label="学院">
            <el-input v-model="student.college" disabled></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="专业">
            <el-input v-model="student.major" disabled></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="8">
          <el-form-item label="班级">
            <el-input v-model="student.className" disabled></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="辅导员">
            <el-input v-model="student.adviser" disabled></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="11">
        <el-col :span="8"
          ><el-form-item label="学制">
            <el-input v-model="student.educationalSystem" disabled></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="入学时间">
            <el-input v-model="student.entryDate" disabled></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="学业状态">
            <el-input v-model="student.status" disabled></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <div slot="footer" class="el-footer">
      <
      <el-row type="flex" justify="center">
        <el-col :span="4">
          <el-form-item>
            <el-button type="danger" @click="handleModify" :disabled="!edit"
              >修改</el-button
            >
          </el-form-item>
        </el-col>
        <el-col :span="4">
          <el-form-item>
            <el-button type="primary" @click="handleBack">返回</el-button>
          </el-form-item>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
import { view, modify } from '@/api/api-user'
import { getLocalStorage } from '@/utils/local-storage'
import { dateFormatter, dateCreater } from '@/utils/dateformat'

export default {
  name: 'studentInfo',
  inject: ['reload'],
  data () {
    return {
      student: {
        id: '',
        name: '',
        gender: '',
        birth: '',
        political: '',
        nation: '',
        idCardNo: '',
        mobilePhone: '',
        marital: '',
        college: '',
        major: '',
        className: '',
        adviser: '',
        educationalSystem: 0,
        entryDate: '',
        status: ''
      },
      edit: false
    }
  },
  created () {},
  mounted () {
    this.init()
  },
  methods: {
    init () {
      const { id } = getLocalStorage('id')
      view({ id: id })
        .then((res) => {
          this.student = res.data.data
          this.student.birth = dateCreater(this.student.birth)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    handleModify () {
      this.student.birth = dateFormatter(this.student.birth)
      modify(this.student)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '修改成功',
              type: 'success'
            })
            this.reload()
          } else {
            this.$message({
              message: res.msg,
              type: 'error'
            })
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    handleBack () {
      this.$router.push({ name: 'student' })
    }
  }
}
</script>
<style scope>
.info {
  display: flex;
  justify-content: center;
}
</style>
