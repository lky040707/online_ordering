<template>
  <el-container style="height: auto; border: 1px solid #eee">
    <el-header style="font-size: 12px">
      <div class="header-one">
        <div class="collapse">
          <span>
            <i
              class="el-icon-arrow-left"
              style="font-size: 28px"
              v-show="!isCollapse"
              @click="_isShow"
            ></i>
          </span>
          <span>
            <i
              class="el-icon-arrow"
              style="font-size: 28px"
              v-show="isCollapse"
              @click="_isShow"
            ></i>
          </span>
        </div>
        <span style="font-size: 24px; color: gray; margin: 0 auto"
          ><span style="color: tomato; font-weight: bold">Rapid Eat</span>
          在线订餐后台</span
        >
        <h-setting></h-setting>
      </div>
    </el-header>
    <el-container>
      <el-aside width="auto" style="background-color: rgb(238, 241, 246)">
        <el-menu
          router
          @close="handleClose"
          :collapse="isCollapse"
          class="el-menu-vertical-demo"
          style="height: 84vh; overflow: hidden"
          :default-active="$route.path"
        >
          <el-menu-item
            v-for="(v, i) in sidedata"
            :key="i"
            :index="v.roter"
            @click="handleClick(v.roter)"
          >
            <template slot="title">
              <i :class="v.icon"></i>
              <span>{{ v.title }}</span>
            </template>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-main>
        <router-view></router-view>
        <el-empty :hidden="hidden" style="height: 78vh;" description="欢迎使用 Rapid Eat 后台管理系统"></el-empty>
      </el-main>
    </el-container>
    <f-footer></f-footer>
  </el-container>
</template>

<script>
import sidedata from '@/data/sidebar-manager'
import Setting from '@/components/private/manager/Setting'
import Footer from '@/components/common/Footer'

export default {
  data () {
    return {
      isCollapse: false,
      isShow: true,
      sidedata: null,
      hidden: false
    }
  },
  components: {
    'h-setting': Setting,
    'f-footer': Footer
  },
  methods: {
    handleClose (key, path) {},
    handleOpen (key, path) {},
    // 点击侧边栏收缩
    _isShow () {
      this.isCollapse = !this.isCollapse
    },
    handleClick (val) {
      this.hidden = val !== '/manager'
      console.log(val)
    }
  },
  created () {
    this.sidedata = sidedata.data
    this.hidden = this.$route.name !== 'manager'
  }
}
</script>
