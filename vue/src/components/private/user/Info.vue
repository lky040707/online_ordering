<template>
  <div class="info" height="78vh">
    <el-form ref="form" :model="user" style="width: auto">
      <el-row :gutter="11" type="flex" justify="end">
        <el-col :span="22" style="text-align: right"
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
        <el-col :span="24">
          <el-form-item label="账号">
            <el-input v-model="user.uName" readonly></el-input>
          </el-form-item> </el-col
      ></el-row>
      <el-row :gutter="11">
        <el-col :span="24">
          <el-form-item label="密码">
            <el-input v-model="user.uPassword" :disabled="!edit"></el-input>
          </el-form-item> </el-col></el-row
      ><el-row :gutter="11">
        <el-col :span="24">
          <el-form-item label="绑定手机">
            <el-input v-model="user.uPhone" :disabled="!edit"></el-input>
          </el-form-item> </el-col
      ></el-row>
      <el-row type="flex" justify="center">
        <el-col :span="12">
          <el-form-item>
            <el-button type="danger" @click="handleModify" :disabled="!edit">修改</el-button>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item>
            <el-button type="reset" :disabled="!edit">取消</el-button>
          </el-form-item>
        </el-col></el-row
      >
    </el-form>
  </div>
</template>

<script>
import { info, revise } from '@/api/api-user'
import { getLocalStorage } from '@/utils/local-storage'

export default {
  name: 'info',
  inject: ['reload'],
  data () {
    return {
      user: {
        uId: '',
        uNname: '',
        uPassword: '',
        uPhone: ''
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
      const { uid } = getLocalStorage('uid')
      info({ uId: uid })
        .then((res) => {
          this.user = res.data.data
        })
        .catch((err) => {
          console.log(err)
        })
    },
    handleModify () {
      revise(this.user)
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '修改成功',
              type: 'success'
            })
            this.init()
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
    }
  }
}
</script>
<style scope>
.info {
  background-color: #fff;
  display: flex;
  justify-content: center;
}
</style>
