<template>
  <div>
    <span style="font-size: 16px; font-weight: bold; margin-right: 10px; padding-top: 20px;">{{ uName }}</span>
    <el-button type="text" @click="exit">退出</el-button>
  </div>
</template>

<script>
import { info } from '@/api/api-user'
import { getLocalStorage, removeLocalStorage } from '@/utils/local-storage'

export default {
  data () {
    return {
      uName: ''
    }
  },
  created () {
    this.init()
  },
  methods: {
    init () {
      const { uid } = getLocalStorage('uid')
      info({ uId: uid })
        .then((res) => {
          if (res.data.code === 200) {
            this.uName = res.data.data.uname
          } else {
            this.$message({ message: res.data.msg, type: 'error' })
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    exit () {
      removeLocalStorage('token', 'uid')
      this.$router.push({ name: 'login' })
    }
  }
}
</script>

<style></style>
