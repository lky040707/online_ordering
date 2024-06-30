<template>
  <div>
    <span style="font-size: 16px; font-weight: bold;margin-right: 10px; padding-top: 20px;">{{
      mName
    }}</span>
    <el-button type="text" @click="exit">退出</el-button>
  </div>
</template>

<script>
import { info } from '@/api/api-manager'
import { getLocalStorage, removeLocalStorage } from '@/utils/local-storage'

export default {
  data () {
    return {
      mName: ''
    }
  },
  created () {
    this.init()
  },
  methods: {
    init () {
      const { mid } = getLocalStorage('mid')
      info({ mId: mid })
        .then((res) => {
          if (res.data.code === 200) {
            this.mName = res.data.data.mname
          } else {
            this.$message({ message: res.data.msg, type: 'error' })
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    exit () {
      removeLocalStorage('token', 'mid')
      this.$router.push({ name: 'managerLogin' })
    }
  }
}
</script>

<style></style>
