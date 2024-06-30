<template>
  <div class="dataTable">
    <el-dialog
      title="填写评价"
      :visible.sync="visible"
      style="text-align: left"
    >
      <el-form ref="form" :model="comment" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item>
              <el-input v-model="comment.oId" hidden></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="菜名">
              <el-input v-model="comment.dName" readonly></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="评价">
              <el-input
                v-model="comment.cText"
                type="textarea"
                autocomplete="off"
                clearable
                :autosize="{ minRows: 2 }"
                maxlength="500"
                show-word-limit
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleComment">确 定</el-button>
        <el-button @click="visible = false">取 消</el-button>
      </div>
    </el-dialog>

    <el-table
      ref="table"
      :data="tableData"
      :header-cell-style="{ textAlign: 'center' }"
      :cell-style="{ textAlign: 'center' }"
      stripe
      size="mini"
      height="74vh"
      border
      tooltip-effect="dark"
      highlight-current-row
      style="width: 100%"
      :default-sort="{ prop: 'oid' }"
    >
      <el-table-column
        prop="oid"
        label="编号"
        fixed
        sortable
        width="100"
      ></el-table-column>
      <el-table-column prop="dname" label="菜名"></el-table-column>
      <el-table-column prop="dprice" label="单价" sortable></el-table-column>
      <el-table-column prop="onumber" label="数量" sortable></el-table-column>
      <el-table-column
        prop="adetail"
        label="地址"
        show-overflow-tooltip
      ></el-table-column>
      <el-table-column fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button size="small" @click="showDialog(scope.$index, scope.row)"
            >评价</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pageNum"
      :page-sizes="[10, 50, 100, 250, 500]"
      :page-size="pageSize"
      :total="total"
      layout="total, sizes, prev, pager, next, jumper"
    ></el-pagination>
  </div>
</template>

<script>
import { viewById } from '@/api/api-order'
import { add } from '@/api/api-comment'
import { getLocalStorage } from '@/utils/local-storage'

export default {
  name: 'order',
  data () {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      comment: {
        oId: '',
        uId: '',
        dName: '',
        cText: '',
        cTime: ''
      },
      rules: {
        cText: [
          {
            requied: true,
            message: '请输入评价',
            trigger: 'blur'
          }
        ]
      },
      visible: false
    }
  },
  created () {
    this.init()
  },
  methods: {
    init () {
      const { uid } = getLocalStorage('uid')
      viewById({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        uId: uid
      })
        .then((res) => {
          this.tableData = res.data.data
          this.total = res.data.count
        })
        .catch((err) => {
          console.log(err)
        })
    },
    getToday () {
      const date = new Date()
      var y = date.getFullYear()
      var m = date.getMonth()
      m = m < 10 ? '0' + m : m
      var d = date.getDate()
      d = d < 10 ? '0' + d : d
      return `${y}.${m}.${d}`.toString()
    },
    showDialog (index, row) {
      this.comment.oId = row.oid
      this.comment.uId = row.uid
      this.comment.dName = row.dname

      this.visible = true
    },
    handleComment () {
      this.$refs.form.validate((valid) => {
        if (valid) {
          add({
            oId: this.comment.oId,
            uId: this.comment.uId,
            cText: this.comment.cText,
            cTime: this.getToday()
          })
            .then((res) => {
              if (res.data.code === 200) {
                this.$message({
                  message: '评论成功',
                  type: 'success'
                })
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
          this.init()
        } else {
          return false
        }
      })
    },
    handleSizeChange (val) {
      this.pageSize = val
      this.init()
    },
    handleCurrentChange (val) {
      this.pageNum = val
      this.init()
    }
  }
}
</script>
