import request from '@/utils/request'

const baseUrl = '/dish'

const viewUrl = baseUrl + ''
export function view (query) {
  return request({
    url: viewUrl,
    method: 'get',
    params: query
  })
}

const viewByTypeUrl = baseUrl + '/selectByType'
export function viewByType (query) {
  return request({
    url: viewByTypeUrl,
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
