import request from '@/utils/request'

const baseUrl = '/manager'

const loginUrl = baseUrl + '/login'
export function login (data) {
  return request({
    url: loginUrl,
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
