module.exports = {
  // 打包用
  // publicPath: './',
  devServer: {
    open: false,
    host: '0.0.0.0',
    port: 8081,
    https: false,
    hotOnly: false,
    proxy: {
      '/api': {
        target: 'http://localhost:9081',
        // 代理websockets
        ws: true,
        // 开启跨域，经由本地虚拟服务进行转发
        changeOrigin: true,
        // 重写路径
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  }
}
