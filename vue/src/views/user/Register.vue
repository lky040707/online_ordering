<template>
  <el-form
    ref="form"
    :model="user"
    :rules="rules"
    label-position="left"
    label-width="0"
    class="demo-ruleForm login-container"
  >
    <img alt="logo" src="@/assets/logo.png" />
    <h3 class="title">注册账号</h3>
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
    <el-form-item prop="requiredPassword">
      <el-input
        type="password"
        v-model="user.requiredPassword"
        auto-complete="off"
        placeholder="确认密码"
        :maxlength="50"
        :clearable="true"
      ></el-input>
    </el-form-item>
    <el-form-item prop="uPhone">
      <el-input
        type="tel"
        v-model="user.uPhone"
        auto-complete="off"
        placeholder="绑定手机"
        :maxlength="50"
        :clearable="true"
      ></el-input>
    </el-form-item>
    <el-form-item style="width: 100%">
      <el-button
        :loading="loading"
        type="primary"
        style="width: 100%"
        @click="handleRegister"
        >注册</el-button
      >
    </el-form-item>
    <el-link type="primary" :underline="false" @click="goLogin"
      >返回登录</el-link
    >
  </el-form>
</template>

<script>
import { register } from '@/api/api-user'

export default {
  name: 'register',
  inject: ['reload'],
  data () {
    return {
      user: {
        uName: '',
        uPassword: '',
        uPhone: '',
        requiredPassword: ''
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
        ],
        uPhone: [
          {
            required: true,
            message: '请输入绑定手机',
            trigger: 'blur'
          }
        ],
        requiredPassword: [
          {
            required: true,
            message: '请输入确认密码',
            trigger: 'blur'
          }
        ]
      },
      checked: true,
      loading: false
    }
  },
  methods: {
    handleRegister () {
      this.$refs.form.validate((valid) => {
        if (
          valid &&
          this.user.uPassword === this.user.requiredPassword &&
          !this.loading
        ) {
          delete this.user.requiredPassword
          register(this.user)
            .then((res) => {
              if (res.data.code === 200) {
                this.$message({
                  message: '注册成功',
                  type: 'success'
                })
                this.$router.push({ name: 'login' })
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
    goLogin () {
      this.$router.push({ name: 'login' })
    }
  }
}
</script>
