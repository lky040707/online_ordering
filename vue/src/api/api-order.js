import request from '@/utils/request'

const baseUrl = '/order'

const viewUrl = baseUrl + ''
export function view (query) {
  return request({
    url: viewUrl,
    method: 'get',
    params: query
  })
}

const viewByIdUrl = baseUrl + '/selectById'
export function viewById (query) {
  return request({
    url: viewByIdUrl,
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
