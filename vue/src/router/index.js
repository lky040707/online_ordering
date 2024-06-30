import Vue from 'vue'
import VueRouter from 'vue-router'
import { getLocalStorage } from '@/utils/local-storage'

import NotFound from '@/views/error/NotFound'

import Manager from '@/views/manager/Home'
import ManagerLogin from '@/views/manager/Login'
import ManagerDish from '@/components/private/manager/Dish'
import ManagerType from '@/components/private/manager/Type'
import ManagerOrder from '@/components/private/manager/Order'

import Home from '@/views/user/Home'
import Login from '@/views/user/Login'
import Register from '@/views/user/Register'
import Cart from '@/components/private/user/Cart'
import Address from '@/components/private/user/Address'
import Order from '@/components/private/user/Order'
import Info from '@/components/private/user/Info'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home,
    children: [
      {
        path: 'index',
        redirect: {
          name: 'home'
        }
      },
      {
        path: 'home',
        redirect: {
          name: 'home'
        }
      },
      {
        path: 'cart',
        name: 'cart',
        component: Cart,
        meta: {
          cname: '购物车'
        }
      },
      {
        path: 'order',
        name: 'order',
        component: Order,
        meta: {
          cname: '订单'
        }
      },
      {
        path: 'info',
        name: 'info',
        component: Info,
        meta: {
          cname: '个人信息'
        }
      },
      {
        path: 'address',
        name: 'address',
        component: Address,
        meta: {
          cname: '地址'
        }
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: { login: true }
  },
  {
    path: '/register',
    name: 'register',
    component: Register,
    meta: { register: true }
  },
  {
    path: '/manager',
    name: 'manager',
    component: Manager,
    meta: { manager: true },
    children: [
      {
        path: 'index',
        redirect: {
          name: 'manager'
        }
      },
      {
        path: 'home',
        redirect: {
          name: 'manager'
        }
      },
      {
        path: 'dish',
        name: 'managerDish',
        component: ManagerDish,
        meta: {
          cname: '菜品',
          manager: true
        }
      },
      {
        path: 'type',
        name: 'managerType',
        component: ManagerType,
        meta: {
          cname: '菜品类型',
          manager: true
        }
      },
      {
        path: 'order',
        name: 'managerOrder',
        component: ManagerOrder,
        meta: {
          cname: '订单',
          manager: true
        }
      }
    ]
  },
  {
    path: '/manager/login',
    name: 'managerLogin',
    component: ManagerLogin,
    meta: {
      login: true,
      manager: true
    }
  },
  {
    path: '*',
    component: NotFound
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  if (!to.meta.register) {
    const { token } = getLocalStorage('token')
    // 如果没有token，并且不是登录页, 跳转到登录页
    if (token) {
      if (!to.meta.login) {
        // console.log('login')
        if (to.meta.manager) {
          // next({ name: 'managerLogin' })
        } else {
          // next({ name: 'login' })
        }
      }
    }
    next()
  }

  next()
})

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch((err) => err)
}

export default router
