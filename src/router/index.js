import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import CreateForm from '../views/CreateForm'
import SearchResult from '../views/SearchResult'
import Recipe from '../views/Recipe'
import Update from '../views/Update'
import Admin from '../views/Admin'
import NotFound from '../views/NotFound'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/create',
    name: 'CreateForm',
    component: CreateForm
  },
  {
    path: '/search/:item',
    name: 'SearchResult',
    component: SearchResult
  },
  {
    path: '/recipe/:id',
    name: 'Recipe',
    component: Recipe
  },
  {
    path: '/update/:id',
    name: 'Update',
    component: Update,
    beforeEnter (to, from, next) {
      if (from.name !== 'Recipe') {
        next('/404')
      } else {
        next()
      }
    }
  },
  {
    path: '/admin',
    name: 'Admin',
    component: Admin,
    beforeEnter (to, from, next) {
      var clientIp
      async function getIp () {
        const response = await fetch('https://api.ipify.org?format=json')
        const data = await response.json()
        clientIp = data.ip
        console.log(clientIp)
        if (process.env.VUE_APP_IP === clientIp) {
          next()
        } else {
          next('/404')
        }
      }
      getIp()
    }
  },
  {
    path: '*',
    name: 'NotFound',
    component: NotFound
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
