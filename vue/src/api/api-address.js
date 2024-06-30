import request from '@/utils/request'

const baseUrl = '/address'

const viewUrl = baseUrl + ''
export function view (query) {
  return request({
    url: viewUrl,
    method: 'get',
    params: query
  })
}

const addUrl = baseUrl + '/add'
export function add (data) {
  return request({
    url: addUrl,
    method: 'post',
    data: data
  })
}

const removeUrl = baseUrl + '/delete'
export function remove (data) {
  return request({
    url: removeUrl,
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
