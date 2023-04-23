(function (win) {
  axios.defaults.headers['Content-Type'] = 'application/json;charset=utf-8'
  // Create an axios instance
  const service = axios.create({
    // The request configuration in axios has a baseURL option, indicating the public part of the request URL
    baseURL: '/',
    // time out
    timeout: 100000
  })
  // request interceptor
  service.interceptors.request.use(config => {
    // if token is needed
    // const isToken = (config.headers || {}).isToken === false
    // if (getToken() && !isToken) {
    //   config.headers['Authorization'] = 'Bearer ' + getToken() //Let each request carry a custom token
    // }
    // get request mapping params parameter
    if (config.method === 'get' && config.params) {
      let url = config.url + '?';
      for (const propName of Object.keys(config.params)) {
        const value = config.params[propName];
        var part = encodeURIComponent(propName) + "=";
        if (value !== null && typeof(value) !== "undefined") {
          if (typeof value === 'object') {
            for (const key of Object.keys(value)) {
              let params = propName + '[' + key + ']';
              var subPart = encodeURIComponent(params) + "=";
              url += subPart + encodeURIComponent(value[key]) + "&";
            }
          } else {
            url += part + encodeURIComponent(value) + "&";
          }
        }
      }
      url = url.slice(0, -1);
      config.params = {};
      config.url = url;
    }
    return config
  }, error => {
      console.log(error)
      Promise.reject(error)
  })

  // response interceptor
  service.interceptors.response.use(res => {
      if (res.data.code === 0 && res.data.msg === 'NOTLOGIN') {// back to login page
        console.log('---/backend/page/login/login.html---')
        localStorage.removeItem('userInfo')
        window.top.location.href = '/backend/page/login/login.html'
      } else {
        return res.data
      }
    },
    error => {
      console.log('err' + error)
      let { message } = error;
      if (message == "Network Error") {
        message = "Abnormal backend interface connection";
      }
      else if (message.includes("timeout")) {
        message = "System interface request timed out";
      }
      else if (message.includes("Request failed with status code")) {
        message = "system interface" + message.substr(message.length - 3) + "abnormal";
      }
      window.ELEMENT.Message({
        message: message,
        type: 'error',
        duration: 5 * 1000
      })
      return Promise.reject(error)
    }
  )
  win.$axios = service
})(window);
