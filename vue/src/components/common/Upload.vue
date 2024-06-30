<template>
  <el-upload
    :limit="1"
    :data="data"
    :file-list="filelist"
    :http-request="handleUpload"
    class="avatar-uploader"
    action
    :before-upload="beforeUpload"
    accept=".csv"
  >
    <span slot="tip" class="el-upload__tip" style="margin: 0 10px">
      仅限上传CSV文件，且不超过500KB</span
    >
    <el-button size="small" type="primary">上传文件</el-button>
  </el-upload>
</template>

<script>
export default {
  data () {
    return {
      filelist: null
    }
  },
  methods: {
    beforeUpdate (file) {
      const isCSV = file.type === '.csv'
      const islt500KB = file.size / 1024 < 500
      if (!isCSV) {
        this.common.errorTip('仅限上传CSV格式文件')
        return false
      }
      if (!islt500KB) {
        this.common.errorTip('文件大小不能超过500KB')
        return false
      }
      const data = new FormData()
      data.append('file', file)
      data.append('target', '')
      this.$axios
        .post('/m/add', data)
        .then((res) => {
          if (res.data.code === 200) {
            console.log('success')
          }
        })
        .catch((err) => {
          console.log(err)
        })
    }
  }
}
</script>
