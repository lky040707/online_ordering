import request from '@/utils/request'

const baseUrl = '/type'

const viewUrl = baseUrl + ''
export function view () {
  return request({
    url: viewUrl,
    method: 'get'
  })
}
