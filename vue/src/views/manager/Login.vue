<template>
  <el-form
    ref="form"
    :model="manager"
    :rules="rules"
    label-position="left"
    label-width="0"
    class="demo-ruleForm login-container"
  >
    <img alt="logo" src="@/assets/logo.png" />
    <h3 class="title">登录后台系统</h3>
    <el-form-item prop="mName">
      <el-input
        type="text"
        v-model="manager.mName"
        auto-complete="off"
        placeholder="账号"
        :maxlength="50"
        :clearable="true"
      ></el-input>
    </el-form-item>
    <el-form-item prop="mPassword">
      <el-input
        type="password"
        v-model="manager.mPassword"
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
    <el-checkbox v-model="checked" checked class="remember"
      >记住密码</el-checkbox
    >
  </el-form>
</template>

<script>
// import { login } from '@/api/api-manager'
import { setLocalStorage } from '@/utils/local-storage'

export default {
  name: 'login',
  inject: ['reload'],
  data () {
    return {
      manager: {
        mName: '',
        mPassword: ''
      },
      rules: {
        mName: [
          {
            required: true,
            message: '请输入账号',
            trigger: 'blur'
          }
        ],
        mPassword: [
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
      // eslint-disable-next-line no-undef
      if (valid) {
        // 模拟登录成功，设置用户信息到本地存储
        setLocalStorage({
          token: 'yourTokenHere',
          mid: 1001
        })
        // 显示登录成功的提示信息
        this.$message({
          message: '登录成功',
          type: 'success'
        })
        // 跳转到管理后台页面
        this.$router.push({ name: 'manager' })
      } else {
        // 表单验证失败，不执行其它操作
        // return
      }
    }
  }
}
</script>
