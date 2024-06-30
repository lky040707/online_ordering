import request from '@/utils/request'

const baseUrl = '/user'

const loginUrl = baseUrl + '/login'
export function login (data) {
  return request({
    url: loginUrl,
    method: 'post',
    data: data
  })
}
const registerUrl = baseUrl + '/register'
export function register (data) {
  return request({
    url: registerUrl,
    method: 'post',
    data: data
  })
}
const reviseUrl = baseUrl + '/revise'
export function revise (data) {
  return request({
    url: reviseUrl,
    method: 'post',
    data: data
  })
}

const infoUrl = baseUrl + '/info'
export function info (data) {
  return request({
    url: infoUrl,
    method: 'post',
    data: data
  })
}
