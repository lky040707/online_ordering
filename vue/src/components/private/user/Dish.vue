<template>
  <div class="dataTable">
    <el-dialog title="评论" :visible.sync="visible" style="text-align: left">
      <el-form ref="form" :model="dish" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="菜名">
              <el-input
                v-model="dish.dName"
                autocomplete="off"
                placeholder="请输入菜名"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类型"> </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="价格">
              <el-input v-model="dish.dName" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="数量">
              <el-input v-model="dish.dName" autocomplete="off"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-form-item label="照片">
            <el-upload
              class="avatar-uploader"
              action="http://localhost:8081/img/img/"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
            >
              <img v-if="imageUrl" :src="imageUrl" class="avatar" />
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="visible = false">确 定</el-button>
        <el-button @click="visible = false">取 消</el-button>
      </div>
    </el-dialog>

    <el-table
      ref="table"
      :data="tableData"
      :header-cell-style="{ textAlign: 'center' }"
      :cell-style="{ textAlign: 'center' }"
      stripe
      size="small"
      height="72vh"
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
          <el-button size="small" @click="handleAdd(scope.$index, scope.row)"
            >加入购物车</el-button
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
import { view as viewComment } from '@/api/api-comment'
import { view } from '@/api/api-dish'
import { view as viewType } from '@/api/api-type'
import { getLocalStorage, setLocalStorage } from '@/utils/local-storage'

export default {
  name: 'dish',
  data () {
    return {
      tableData: [],
      filterType: [],
      filtersData: [],
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
      view({
        pageNum: this.pageNum,
        pageSize: this.pageSize
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
    handleAdd (index, row) {
      var cart = []
      cart = getLocalStorage('cart').cart
      cart.push(row)
      setLocalStorage({ cart: cart })
    },
    handleComment (val) {
      viewComment({
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        dId: val
      })
        .then((res) => {
          this.tableData = res.data.data
          this.total = res.data.count
        })
        .catch((err) => {
          console.log(err)
        })
    },
    handleType () {},
    filterHandler (value, row, colum) {
      const property = colum.property
      return row[property] === value
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

<style>
.dataTable {
  background-color: #fff;
}
</style>
