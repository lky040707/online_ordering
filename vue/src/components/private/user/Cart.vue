<template>
  <div class="dataTable">
    <el-dialog
      title="支付订单"
      :visible.sync="visible"
      style="text-align: left"
    >
      <div style="text-align: center">
        <img src="@/assets/qrcode.jpg" alt="QRCode" style="width: 300px" />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="handleBack">返 回</el-button>
      </div>
    </el-dialog>

    <el-col :span="22" style="margin: 10px; text-align: right">
      <el-button
        type="primary"
        @click="handleAdd"
        size="small"
        style="margin-right: -13px"
        >提交订单</el-button
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
      :default-sort="{ prop: 'did' }"
    >
      <el-table-column
        prop="did"
        label="编号"
        fixed
        sortable
        width="100"
      ></el-table-column
      ><el-table-column prop="dname" label="菜名" fixed width="200">
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.dname"
            placeholder="请输入菜名"
          ></el-input>
        </template>
      </el-table-column>

      <el-table-column prop="dprice" label="价格" sortable width="200">
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.dprice"
            autocomplete="off"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="dnumber" label="数量" sortable width="200">
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.dnumber"
            autocomplete="off"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="dimage" label="图片" width="200">
        <template slot-scope="scope">
          <el-popover placement="left" title="" trigger="hover">
            <el-image
              :src="require('@/assets/img/' + scope.row.dimage)"
              :alt="scope.row.dname"
              style="max-width: 500px"
            />
            <el-image
              slot="reference"
              :src="require('@/assets/img/' + scope.row.dimage)"
              :alt="scope.row.dname"
              style="max-width: 60px"
            />
          </el-popover>
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
  </div>
</template>

<script>
import { add } from '@/api/api-order'
import { view as viewType } from '@/api/api-type'
import {
  getLocalStorage,
  setLocalStorage,
  removeLocalStorage
} from '@/utils/local-storage'

export default {
  name: 'dish',
  data () {
    return {
      tableData: [],
      filterData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dish: {
        dId: '',
        dName: '',
        tType: '',
        dPrice: '',
        dNumber: '',
        dImage: ''
      },
      visible: false
    }
  },
  created () {
    this.initType()
    this.init()
  },
  methods: {
    initType () {
      viewType()
        .then((res) => {
          res.data.data.forEach((i) => {
            this.filtersData.push({ text: i.ttype, value: i.ttype })
          })
        })
        .catch((err) => {
          console.log(err)
        })
    },
    init () {
      const { cart } = getLocalStorage('cart')
      this.tableData = cart
    },
    handleAdd () {
      this.visible = true
      if (this.tableData !== []) {
        this.tableData
          .forEach((i) => {
            add(i).then((res) => {
              if (res.data.cide === 200) {
                this.$message({
                  message: '提交成功',
                  type: 'success'
                })
              } else {
                this.$message({
                  message: res.data.msg,
                  type: 'error'
                })
              }
            })
          })
          .catch((err) => {
            console.log(err)
          })
      }
    },
    handleBack () {
      this.visible = false
      removeLocalStorage('cart')
      this.init()
    },
    handleModify (index, row) {
      const { cart } = getLocalStorage('cart')
      cart.forEach((i) => {
        if (i.dId === row.did) {
          i = row
        }
      })
      setLocalStorage({ cart: cart })
      this.init()
    },
    handleDelete (index, row) {
      const { cart } = getLocalStorage('cart')
      cart.splice(cart.indexOf(row), 1)
      setLocalStorage({ cart: cart })
      this.init()
    },
    filterHandler (value, row, colum) {
      const property = colum.property
      return row[property] === value
    }
  }
}
</script>

<style>
.dataTable {
  background-color: #fff;
}
</style>
