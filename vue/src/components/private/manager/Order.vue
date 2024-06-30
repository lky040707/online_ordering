<template>
  <div class="dataTable">
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
      ></el-table-column
      ><el-table-column prop="aname" label="顾客"></el-table-column>
      <el-table-column prop="dname" label="菜名"></el-table-column>
      <el-table-column prop="dprice" label="单价" sortable></el-table-column>
      <el-table-column prop="onumber" label="数量" sortable></el-table-column>
      <el-table-column
        prop="adetail"
        label="地址"
        show-overflow-tooltip
      ></el-table-column>
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
import { view } from '@/api/api-order'

export default {
  name: 'managerOrder',
  data () {
    return {
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      total: 0
    }
  },
  created () {
    this.init()
  },
  methods: {
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
