require 'openssl'
require 'base64'
module NeotelisPay
  module Utils
    class Des
      ALG = 'DES-ECB'

      #加密
      def self.encode(str, key)
        #key取固定前8位
        use_key = key[0,8]
        #使用GBK编码
        use_str = str.encode("GBK")
        cipher = OpenSSL::Cipher.new(ALG)
        cipher.encrypt
        cipher.key = use_key
        result = cipher.update(use_str) + cipher.final
        return result.unpack('H*')
      end

      #解密
      def self.decode(str, key)
        #key取固定前8位
        use_key = key[0,8]
        #
        decode_str = [str].pack('H*')
        des = OpenSSL::Cipher::Cipher.new(ALG)
        des.decrypt
        des.key = use_key
        result = des.update(decode_str) + des.final
        dec_str = result.force_encoding("GBK")
        utf8_str = dec_str.encode("UTF-8")
        return utf8_str
      end
    end

    #获取需要加密的字段
    def self.des_param_list(service_type)
      des_key_list = []
      case service_type
        when NeotelisPay::SERVICE_TYPE_SIGN_APPLY
          des_key_list << 'userToken'
          des_key_list << 'payerName'
          des_key_list << 'certNo'
          des_key_list << 'bankCardNo'
        when NeotelisPay::SERVICE_TYPE_SIGN_CONFIRM
          des_key_list << 'token'
          des_key_list << 'verifyCode'
        when NeotelisPay::SERVICE_TYPE_PREPAY
          des_key_list << 'userToken'
          des_key_list << 'payerName'
          des_key_list << 'certNo'
          des_key_list << 'bankCardNo'
        when NeotelisPay::SERVICE_TYPE_PAY_CONFIRM
          des_key_list << 'token'
          des_key_list << 'verifyCode'
        when NeotelisPay::SERVICE_TYPE_GATEWAY_PAY
          des_key_list << ''
      end
      return des_key_list
    end
  end
end
