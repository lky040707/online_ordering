<template>
  <div class="dataTable">
    <el-dialog
      title="新增地址"
      :visible.sync="visible"
      style="text-align: left"
    >
      <el-form ref="form" :model="address" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="收货人">
              <el-input
                v-model="address.aName"
                autocomplete="off"
                placeholder="请输入收货人"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系方式">
              <el-input
                v-model="address.aPhone"
                type="tel"
                autocomplete="off"
                placeholder="请输入联系方式"
              >
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="收货地址">
              <el-input
                v-model="address.aDetail"
                type="textarea"
                maxlength="100"
                autocomplete="off"
                clearable
                :autosize="{ minRows: 2 }"
                show-word-limit
                placeholdder="请输入收货地址"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleAdd">确 定</el-button>
        <el-button @click="visible = false">取 消</el-button>
      </div>
    </el-dialog>
    <el-col :span="22" style="margin: 10px; text-align: right">
      <el-button
        type="primary"
        @click="showDialog"
        size="small"
        style="margin-right: -13px"
        >新增</el-button
      >
    </el-col>

    <el-table
      ref="table"
      :data="tableData"
      :header-cell-style="{ textAlign: 'center' }"
      :cell-style="{ textAlign: 'center' }"
      stripe
      size="small"
      height="67vh"
      border
      tooltip-effect="dark"
      highlight-current-row
      style="width: 100%"
      :default-sort="{ prop: 'aid' }"
    >
      <el-table-column
        prop="aid"
        label="编号"
        fixed
        sortable
        width="100"
      ></el-table-column
      ><el-table-column prop="aname" label="收货人" fixed>
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.aname"
            placeholder="请输入收货人"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="aphone" label="联系方式" sortable>
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.aphone"
            autocomplete="off"
            placeholder="请输入联系方式"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="adetail" label="详细地址" sortable>
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.adetail"
            autocomplete="off"
            placeholder="请输入详细地址"
            show-overflow-tooltip
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作">
        <template slot-scope="scope">
          <el-button size="small" @click="handleModify(scope.$index, scope.row)"
            >编辑</el-button
          >
          <el-button
            size="small"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button
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
import { view, add, revise, remove } from '@/api/api-address'
import { getLocalStorage } from '@/utils/local-storage'

export default {
  name: 'address',
  data () {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      address: {
        aId: '',
        uId: '',
        aDetail: '',
        aPhone: '',
        aName: ''
      },
      rules: {
        aDetail: [
          {
            requied: true,
            message: '请输入收货地址',
            trigger: 'blur'
          }
        ],
        aPhone: [
          {
            requied: true,
            message: '请输入联系方式',
            trigger: 'blur'
          }
        ],
        aName: [
          {
            requied: true,
            message: '请输入收货人',
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
      view({
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
    showDialog () {
      this.visible = true
    },
    handleAdd () {
      this.$refs.form.validate((valid) => {
        if (valid) {
          add(this.address)
            .then((res) => {
              if (res.data.code === 200) {
                this.$message({
                  message: '添加成功',
                  type: 'success'
                })
                this.init()
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
    handleModify (index, row) {
      this.$refs.form.validate((valid) => {
        if (valid) {
          revise(row)
            .then((res) => {
              if (res.data.code === 200) {
                this.$message({
                  message: '修改成功',
                  type: 'success'
                })
                this.init()
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
    handleDelete (index, row) {
      remove({ uId: row.uid })
      remove({ uId: row.uid })
        .then((res) => {
          if (res.data.code === 200) {
            this.$message({
              message: '删除成功',
              type: 'success'
            })
            this.init()
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
