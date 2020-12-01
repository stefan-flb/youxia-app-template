import JsEncrypt from 'jsencrypt'
import CryptoJS from 'crypto-js'

//生成随机数
export function randomString(len) {
  len = len || 32
  var $chars =
    'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678' /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
  var maxPos = $chars.length
  var pwd = ''
  for (var i = 0; i < len; i++) {
    pwd += $chars.charAt(Math.floor(Math.random() * maxPos))
  }
  return pwd
}
//RSA加密
function RSA_encrypt(data, PUBLIC_KEY) {
  let encryptor = new JsEncrypt() // 新建JSEncrypt对象
  encryptor.setPublicKey(PUBLIC_KEY) // 设置公钥
  const rsaDta = encryptor.encrypt(data) // 进行加密
  return rsaDta
}
//组包
function pack(encrypted, iv, key, pub_key) {
  var rsa_iv = RSA_encrypt(iv, pub_key)
  var rsa_key = RSA_encrypt(key, pub_key)

  var splitFlag = 'aesrsastart'

  var res_data = encrypted + splitFlag + rsa_iv + splitFlag + rsa_key
  return res_data
}
/**
 * AES加密数组 传入参数为需要传递的数组JSON
 */
export function AES_encrypt(data, KEY, IV, pkcs8_public) {
  var key_utf8 = CryptoJS.enc.Utf8.parse(KEY) // 秘钥
  var iv_utf8 = CryptoJS.enc.Utf8.parse(IV) //向量iv
  //AES 加密
  var encrypted = CryptoJS.AES.encrypt(data, key_utf8, {
    iv: iv_utf8,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7
  }).toString()
  //RSA 加密 组包
  return pack(encrypted, IV, KEY, pkcs8_public)
}
