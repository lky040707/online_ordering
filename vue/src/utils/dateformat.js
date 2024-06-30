export function dateFormatter (date) {
  if (date === null) {
    return date
  }
  date = new Date(date)
  var y = date.getFullYear()
  var m = date.getMonth() + 1
  m = m < 10 ? '0' + m : m
  var d = date.getDate()
  d = d < 10 ? '0' + d : d
  return `${y}-${m}-${d}`
}
export function dateCreater (string) {
  return string === null ? string : new Date(string)
}
