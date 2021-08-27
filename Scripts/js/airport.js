// @grant nodejs
console.log("⏳ 初始化安装推送模块中......")
$exec('wget https://raw.githubusercontent.com/whyour/qinglong/master/sample/notify.py -O notify.py', {
  cwd: './script/Shell',
  timeout: 0,
  cb(data, error) {
    error ? console.error(error) : console.log(data)
  }
})
// 通知填写参考 https://raw.githubusercontent.com/whyour/qinglong/master/sample/notify.py
console.log("⏳ 开始执行机场签到任务")
$exec('python3 https://raw.githubusercontent.com/kiddin9/Oreomeow-VIP/main/Scripts/py/airport.py', {
  cwd: './script/Shell',
  timeout: 0,
  env: {
    airport_url: $store.get('airport_url', 'string'),                         // 签到机场网址，多个网址用英文逗号分割，不要 user 之类的
    airport_user: $store.get('airport_user', 'string'),                       // 签到机场登陆邮箱，与网站对应，多个用户用英文逗号分割
    airport_pwd: $store.get('airport_pwd', 'string'),                         // 签到机场登陆密码，与网站对应，多个密码用英文逗号分割
    BARK: $store.get('BARK', 'string'),                                       // bark服务，此参数如果以http或者https开头则判定为自建bark服务; secrets可填;
    SCKEY: $store.get('SCKEY', 'string'),                                     // Server酱的SCKEY; secrets可填
    TG_BOT_TOKEN: $store.get('TG_BOT_TOKEN', 'string'),                       // tg机器人的TG_BOT_TOKEN; secrets可填
    TG_USER_ID: $store.get('TG_USER_ID', 'string'),                           // tg机器人的TG_USER_ID; secrets可填
    TG_PROXY_IP: $store.get('TG_PROXY_IP', 'string'),                         // tg机器人的TG_PROXY_IP; secrets可填
    TG_PROXY_PORT: $store.get('TG_PROXY_PORT', 'string'),                     // tg机器人的TG_PROXY_PORT; secrets可填
    DD_BOT_ACCESS_TOKEN: $store.get('DD_BOT_ACCESS_TOKEN', 'string'),         // 钉钉机器人的DD_BOT_ACCESS_TOKEN; secrets可填
    DD_BOT_SECRET: $store.get('DD_BOT_SECRET', 'string'),                     // 钉钉机器人的DD_BOT_SECRET; secrets可填
    QYWX_APP: $store.get('QYWX_APP', 'string')                                // 企业微信应用的QYWX_APP; secrets可填 参考http://note.youdao.com/s/HMiudGkb
  },
  cb(data, error) {
    error ? console.error(error) : console.log(data)
  }
})