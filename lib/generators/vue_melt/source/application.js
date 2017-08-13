import Vue from 'vue/dist/vue.esm'
import store from './store'
import cloneDeep from 'lodash.clonedeep'

import VueAssignModel from 'vue-assign-model'
Vue.use(VueAssignModel)

const storeState = cloneDeep(store.state)
var vms = []
var options = {}
var requireContext = require.context("./options", false, /\.js$/)
requireContext.keys().forEach(key => {
  let name = key.split('/').pop().split('.').shift()
  options[name] = requireContext(key).default
})

document.addEventListener('turbolinks:load', () => {
  let templates = document.querySelectorAll('[data-vue]')
  for (let el of templates) {
    let vm = new Vue(
      Object.assign(options[el.dataset.vue], { el, store })
    )
    vms.push(vm)
  }
})

document.addEventListener('turbolinks:visit', () => {
  for (let vm of vms) {
    vm.$destroy()
  }
  vms = []
  store.replaceState(cloneDeep(storeState))
})
