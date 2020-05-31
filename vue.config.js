module.exports = {
  devServer: {
    proxy: {
      '^/api/': {
        target: 'http://localhost:8888/proj3-show/src/backend',
        changeOrigin: true // so CORS doesn't bite us.
      }
    }
  }
}
