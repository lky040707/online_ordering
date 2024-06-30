<template>
  <div class="dataTable">
    <el-table
      ref="table"
      :data="tableData"
      :header-cell-style="{ textAlign: 'center' }"
      :cell-style="{ textAlign: 'center' }"
      stripe
      size="small"
      height="78vh"
      border
      tooltip-effect="dark"
      show-overflow-tooltip
      highlight-current-row
      style="width: 100%"
      :default-sort="{ prop: 'ttype'}"
    >
      <el-table-column type="index" width="100"></el-table-column>
      <el-table-column prop="ttype" label="名称" sortable></el-table-column>
    </el-table>
  </div>
</template>

<script>
import { view } from '@/api/api-type'

export default {
  name: 'managerType',
  data () {
    return {
      tableData: []
    }
  },
  created () {
    this.init()
  },

  methods: {
    init () {
      view()
        .then((res) => {
          this.tableData = res.data.data
        })
        .catch((err) => {
          console.log(err)
        })
    }
  }
}
</script>
