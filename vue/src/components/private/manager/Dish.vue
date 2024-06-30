<template>
  <div class="dataTable">
    <el-dialog
      title="新增菜品"
      :visible.sync="visible"
      style="text-align: left"
    >
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
            <el-form-item label="类型"
              ><el-select v-model="dish.tType" placeholder="请选择类型">
                <template>
                  <el-option
                    v-for="i in filtersData"
                    :key="i.value"
                    :label="i.value"
                    :value="i.value"
                  ></el-option>
                </template>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="价格" placeholder="请输入价格">
              <el-input v-model="dish.dName" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="数量" placeholdder="请输入数量">
              <el-input v-model="dish.dName" autocomplete="off"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-form-item label="照片">
            <el-upload
              class="avatar-uploader"
              action="http://localhost:8081/assets/img/"
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
      <el-table-column
        prop="ttype"
        label="类型"
        :filters="filtersData"
        :filter-method="filterHandler"
        width="200"
      >
        <template slot-scope="scope">
          <el-select
            size="mini"
            v-model="scope.row.ttype"
            placeholder="请选择类型"
          >
            <template>
              <el-option
                v-for="i in filtersData"
                :key="i.value"
                :label="i.value"
                :value="i.value"
              ></el-option>
            </template>
          </el-select>
        </template>
      </el-table-column>
      <el-table-column prop="dprice" label="价格" sortable width="200">
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.dprice"
            autocomplete="off"
            placeholder="请输入价格"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column prop="dnumber" label="数量" sortable width="200">
        <template slot-scope="scope">
          <el-input
            size="mini"
            v-model="scope.row.dnumber"
            autocomplete="off"
            placeholder="请输入数量"
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
import { view as viewType } from '@/api/api-type'
import { view, add, revise, remove } from '@/api/api-dish'

export default {
  name: 'managerDish',
  data () {
    return {
      tableData: [],
      filtersData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      dish: {
        dId: '',
        dName: '土豆丝',
        tType: '小炒时蔬',
        dPrice: '7',
        dNumber: '15',
        dImage: ''
      },
      visible: false,
      imageUrl: ''
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
      this.$message({
        message: '添加菜品成功！',
        type: 'success'
      })
      this.disvisible = true
    },
    handleAdd () {
      this.$message({
        message: 'sdasdsar',
        type: 'success'
      })
      add()
    },
    handleModify (index, row) {
      revise({
        dId: row.did,
        dName: row.dname,
        tType: row.ttype,
        dPrice: row.dprice,
        dNumber: row.dnumber,
        dImage: row.dimage
      })
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
    },
    handleDelete (index, row) {
      remove({ dId: row.did })
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
    },
    handleAvatarSuccess (res, file) {
      this.imageUrl = URL.createObjectURL(file.raw)
    },
    beforeAvatarUpload (file) {
      const isJPG = file.type === 'image/jpeg' || file.type === 'image/png'
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 或 PNG 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      return isJPG && isLt2M
    }
  }
}
</script>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
