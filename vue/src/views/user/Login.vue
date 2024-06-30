<template>
  <el-form
    ref="form"
    :model="user"
    :rules="rules"
    label-position="top"
    label-width="0"
    class="demo-ruleForm login-container"
  >
    <img alt="logo" src="@/assets/logo.png" />
    <h3 class="title">移动订餐系统</h3>
    <el-form-item prop="uName">
      <el-input
        type="text"
        v-model="user.uName"
        auto-complete="off"
        placeholder="账号"
        :maxlength="50"
        :clearable="true"
      ></el-input>
    </el-form-item>
    <el-form-item prop="uPassword">
      <el-input
        type="password"
        v-model="user.uPassword"
        auto-complete="off"
        placeholder="密码"
        :maxlength="50"
        :clearable="true"
      ></el-input>
    </el-form-item>
    <el-form-item style="width: 100%">
      <el-button
        :loading="loading"
        type="primary"
        style="width: 100%"
        @click="handleLogin"
        >登录</el-button
      >
    </el-form-item>
    <el-row>
      <el-col :span="8">
        <el-checkbox v-model="checked" checked class="remember"
          >记住密码</el-checkbox
        >
      </el-col>
      <el-col :span="8">
        <el-link type="primary" :underline="false" @click="goRegister"
          >去注册</el-link
        >
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
import { login } from '@/api/api-user'
import { setLocalStorage } from '@/utils/local-storage'

export default {
  name: 'login',
  inject: ['reload'],
  data () {
    return {
      user: {
        uName: '',
        uPassword: ''
      },
      rules: {
        uName: [
          {
            required: true,
            message: '请输入账号',
            trigger: 'blur'
          }
        ],
        uPassword: [
          {
            required: true,
            message: '请输入密码',
            trigger: 'blur'
          }
        ]
      },
      checked: true,
      loading: false
    }
  },
  methods: {
    handleLogin () {
      this.$refs.form.validate((valid) => {
        if (valid && !this.loading) {
          login(this.user)
            .then((res) => {
              if (res.data.code === 200) {
                setLocalStorage({
                  token: res.data.token,
                  uid: res.data.data.uid
                })
                this.$message({
                  message: '登录成功',
                  type: 'success'
                })
                console.log(window.localStorage.getItem('user'))
                this.$router.push({ name: 'home' })
              } else {
                this.$message({
                  message: res.data.msg,
                  type: 'error'
                })
              }
            })
            .catch((err) => {
              console.log(err)
            })
        } else {
          return false
        }
      })
    },
    goRegister () {
      this.$router.push({ name: 'register' })
    }
  }
}
</script>

<style>
body {
  background: #dfe9fb;
}
.login-container {
  width: 350px;
  margin: 0 auto;
}
</style>
