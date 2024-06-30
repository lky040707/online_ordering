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
              >折叠</i
            >
          </span>
          <span>
            <i
              class="el-icon-arrow-right"
              style="font-size: 28px"
              v-show="isCollapse"
              @click="_isShow"
            ></i>
          </span>
        </div>
        <span style="font-size: 24px; color: gray; margin: 0 auto"
          ><span style="color: tomato; font-weight: bold">Rapid Eat</span>
          在线订餐</span
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
          :collapse-transition="false"
          :default-active="$route.path"
        >
          <el-menu-item
            style="padding: 0 5px"
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
        <m-dish :hidden="hidden"></m-dish>
        <router-view></router-view>
      </el-main>
    </el-container>
    <f-footer></f-footer>
  </el-container>
</template>

<script>
import sidedata from '@/data/sidebar-user'
import Setting from '@/components/private/user/Setting'
import Dish from '@/components/private/user/Dish'
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
    'm-dish': Dish,
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
      this.hidden = val !== '/'
      console.log(val)
    }
  },
  created () {
    this.hidden = this.$route.name !== 'home'
    this.sidedata = sidedata.data
  }
}
</script>

<style>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  min-height: 400px;
  width: 180px;
}
.collapse {
  width: 200px;
}
.el-breadcrumb-item {
  margin-top: 10px;
}
.header-one {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  height: 60px;
}
</style>
